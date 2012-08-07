module Simulator
  class Equation
    attr_reader :variable 

    def initialize(var, &equation)
      @equation_block = equation
      @variable = var
    end

    # evaluate the equation in the passed context
    def evaluate_in(context)
      sandbox = context.new_sandbox
      sandbox.instance_eval &@equation_block
    end
  end
end
