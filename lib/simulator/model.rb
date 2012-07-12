module Simulator
  #
  class Model
    attr_reader :equations
    attr_reader :variables

    def initialize
      @equations = []
      @variables = []
    end
    def add_equation(equation)
      @equations << equation
    end
    def add_variable(variable)
      @variables << variable
    end
  end
end
