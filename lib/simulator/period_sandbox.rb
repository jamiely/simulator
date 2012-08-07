module Simulator
  class PeriodSandbox < Sandbox
    def previous
      previous_period.nil? ? self : previous_sandbox
    end
    private
    def previous_period
      period.previous
    end
    def period
      context.period
    end
    def previous_context
      previous.context
    end
    def previous_sandbox
      previous_context.sandbox
    end
  end
end
