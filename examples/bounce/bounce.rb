require 'json'
require 'chunky_png'
require 'simulator'

module Bounce
  class Program
    attr_accessor :model, :steps_per_second

    def initialize
      steps_per_second = 3.0
      @steps_per_second = steps_per_second
      @model = ::Simulator::Model.new do
        name = "Bounce model"
        var :ax, 0
        var :ay, - 9.8/steps_per_second
        eqtn(:vx, 20) { vx + ax }
        eqtn(:vy, 50) { vy + ay }
        eqtn(:x, 10) { x + vx }
        eqtn(:y, 100) { y + vy }
      end
      @height = 500
      @width = 700
    end

    def model_data
      # Run the model 30 steps
      model_run = @model.new_run
      30.times do 
        model_run.step
      end
      
      # get the data
      model_run.data
    end

    def norm_data(data)
      xs, ys = data.series :x, :y

      # normalize
      xs = xs.collect(&:round)
      # Flip the y coordinates so we can draw
      ys = ys.collect {|y| @height - y.round}

      xs.zip(ys)
    end

    def plot_data(filename, pts)
      # display the data in an image
      image = ChunkyPNG::Image.new @width, @height, 
        ChunkyPNG::Color::BLACK
      pts.each do |pt|
        x, y = pt
        image.circle x, y, 3, ChunkyPNG::Color('red')
      end
      image.save filename
    end


    def run
      data = model_data
      pts = norm_data data
      plot_data 'bounce.png', pts
    end
  end
end


# Run the program
Bounce::Program.new.run

