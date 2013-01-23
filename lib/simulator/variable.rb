module Simulator
  class Variable
    attr_reader :name, :default_value

    def initialize(name, default_value = nil)
      @name = name
      @default_value = default_value
    end
  end
end

