module Simulator
  #
  class Model
    attr_accessor :name
    attr_reader :equations

    def initialize(&block)
      @equations = []
      @variables = {}
      instance_eval &block unless block.nil?
    end
    def var(name, default_value = nil)
      v = get_variable(name)
      if v.nil?
        v = Variable.new name, default_value
        add_variable v
      end
      v
    end
    def eqtn(var_name, default_value = nil, &block)
      v = var(var_name, default_value)
      e = Equation.new(v, &block)
      add_equation e
      e
    end
    def add_equation(equation)
      @equations << equation
    end
    def add_variable(variable)
      @variables[variable.name] = variable
    end
    def get_variable(name)
      @variables[name]
    end
    def variables
      @variables.values
    end

    def new_run
      Run.new self
    end
  end
end
