module Simulator
  class Sandbox
    def initialize(context, periods = [])
      @context = context
      @periods = periods
    end

    private

    def delay(var_name, var_periods)
      throw 'First parameter must be a variable symbol' unless var_name.class == Symbol

      # Get the period n steps back
      period = @periods[-var_periods] # We might have to add 1 period back (- (var_periods+1))
      context = period.context
      var = context.get var_name
      var.value unless var.nil?
    end

    def respond_to?(sym)
      puts "Respond to: #{sym}"
      not @context.get(sym.to_sym).nil?
    end

    def method_missing(method_name, *args, &block)
      var = @context.get method_name.to_sym
      return var.value unless var.nil?
      super(method_name, *args, &block)
    end
  end
end
