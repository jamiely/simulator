module Simulator
  # A run of a model. It has its own context
  class Run
    attr_reader :model
    attr_reader :periods

    def initialize(model)
      @model = model
      @periods = [Period.new(self)]
      current_context.add_variables *@model.variables
    end

    def evaluate
      # evaluate the equations in the current context
      @model.equations.each do | eqtn |
        result = eqtn.evaluate_in current_context
        var = eqtn.variable
        bound_var = current_context.get(var.name)
        bound_var.value = result
      end
    end

    def increment_period
      p = Period.new self, @periods.dup
      @periods << p
      p
    end

    def step
      evaluate
      increment_period
    end

    # The number of periods so far. All runs have at least 1 period.
    def period_count
      @periods.length
    end

    # Returns the current_context, that is the variable context of the last 
    # period.
    def current_context
      @periods.last.context
    end

    def variables
      current_context.variables
    end

    def set(var_hash)
      current_context.set var_hash
    end

    def variable_value(var_name)
      current_context.get(var_name).value
    end
  end
end

