module Simulator
  # A run of a model. It has its own context
  class Run
    attr_reader :model

    def initialize(model)
      @model = model
      @context = VariableContext.new
      @context.add_variables *@model.variables
    end

    def variables
      @context.variables
    end

    def set(var_hash)
      @context.set var_hash
    end

    def variable_value(var_name)
      @context.get(var_name).value
    end
  end
end

