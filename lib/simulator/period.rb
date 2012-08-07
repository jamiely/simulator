module Simulator
  class Period
    attr_reader :context
    attr_reader :run
    attr_reader :previous_periods

    def initialize(run, previous_periods = [])
      @run = run
      @previous_periods = previous_periods
      @context = @previous_periods.empty? ? PeriodVariableContext.new(self) : previous.context.clone
    end

    # the first period
    def first
      @previous_periods.first
    end

    # the period before this one
    def previous
      @previous_periods.last
    end

    # returns a period count ago
    def ago(count)
      count == 0 ? self : @previous_periods[-count]
    end
  end
end
