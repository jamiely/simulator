module Simulator
  #
  class Model
    attr_reader :equations
    def initialize
      @equations = []
    end
    def add_equation(equation)
      @equations << equation
    end
  end
end
