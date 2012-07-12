module Simulator
  class Equation
    def initialize(&equation)
      @equation_block = equation
    end

    # evaluate the equation in the passed context
    def evaluate_in(context)
      sandbox = Sandbox.new context
      sandbox.instance_eval &@equation_block
    end
  end
end
