module Simulator
  class PeriodVariableContext < VariableContext
    attr_accessor :period
    def initialize(period = nil)
      super()
      @period = period
    end
    # Override new_sandbox to create a sandbox bound to the period
    def new_sandbox
      PeriodSandbox.new self
    end
    def clone(new_period = nil)
      result = super()
      result.period = new_period unless new_period.nil?
      result
    end
  end
end
