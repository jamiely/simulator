require 'simulator'
require 'chunky_png'

module Mortgage
  class Program
    include Simulator
    def model
      @model = Model.new do
        name = "Mortgage model"

        # monthly steps
        var :base_rate, 0.08
        eqtn(:annual_rate) { base_rate + rand(10).to_f/1000 }
        eqtn(:monthly_rate) { annual_rate / 12.0 }
        var :payment, 2000
        eqtn :balance, 250000 do
          balance * (1 + monthly_rate) - payment
        end
      end
    end

    def model_data
      # a quick convenience method, don't try this at home
      Fixnum.class_eval do
        def years
          self * 12
        end
      end

      # fixed rate mortgage
      fixed = @model.new_run
      fixed.set payment: 2100
      fixed.step 30.years

      # balloon
      balloon = @model.new_run
      balloon.set payment: 1850
      balloon.step 30.years

      variable = @model.new_run
      # first 10 years, stick with low payment
      variable.set payment: 1800
      variable.step 10.years

      # subsequent years, balloon to higher payment until its paid
      variable.set payment: 2100
      variable.step 20.years

      @balances = {
        variable: variable.data.series(:balance),
        fixed: fixed.data.series(:balance),
        balloon: balloon.data.series(:balance)
      }

      @balances
    end
    def plot
      @height = 500
      @width = 800

      # display the data in an image
      image = ChunkyPNG::Image.new @width, @height, 
        ChunkyPNG::Color::BLACK

      peg = @balances[:variable]
      count = peg.length
      max = peg.max.to_f
      colors = {
        variable: ChunkyPNG::Color('blue'), 
        fixed: ChunkyPNG::Color('yellow'),
        balloon: ChunkyPNG::Color('red')
      }
      @balances.keys.each do |type|
        balances = @balances[type]
        color = colors[type]

        balances.each_index do |i|
          x = i/count.to_f * @width
          y = @height - (balances[i]/max * @height).to_i
          image.circle x, y, 3, color
        end
      end

      image.save @filename
    end
    def run
      model
      model_data
      @filename = "mortgage.png"
      plot
    end

  end
end

Mortgage::Program.new.run

