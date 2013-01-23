module Simulator
  # represents a variable bound to a context
  class BoundVariable
    attr_accessor :value
    attr_reader :context, :variable

    def initialize(variable, context)
      @variable = variable
      @value = @variable.default_value
      @context = context
    end

    def name
      @variable.name
    end
  end
end

