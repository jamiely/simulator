module Simulator
  # A run of a model. It has its own context
  class Run
    attr_reader :model

    def initialize(model)
      @model = model
      @context = VariableContext.new
    end
  end
end

