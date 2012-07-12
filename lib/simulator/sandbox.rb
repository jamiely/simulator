module Simulator
  class Sandbox
    def initialize(context)
      @context = context
    end

    def respond_to?(sym)
      not @context.get(method_name.to_sym).nil?
    end

    def method_missing(method_name, *args, &block)
      var = @context.get method_name.to_sym
      return var.value unless var.nil?
      super(method_name, *args, &block)
    end
  end
end
