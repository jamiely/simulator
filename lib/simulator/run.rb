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
        result = eqtn.evaluate_in current_context, @periods
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

    def step(times=1)
      times.times do
        evaluate
        increment_period
      end
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

    def summary
      var_list = variables.sort_by(&:name).collect do |v|
        "\t#{v.name} = #{v.value}"
      end.join("\n")
      model_summary = %Q{Model "#{@model.name}"}
      period_summary = "Period #{period_count}"

      "#{model_summary}\n#{period_summary}\nVariables:\n#{var_list}"
    end

    def variables_csv
      vars = variables.sort_by(&:name)
      var_names = vars.collect(&:name)
      header = "'Period',#{var_names.collect{|n| "'#{n}'"}.join(',')}"

      rows = []
      @periods.each_index do |index|
        period = @periods[index]

        context = period.context
        var_values = var_names.collect do | var_name |
          var = context.get var_name
          var.value
        end.join(',')

        rows << "#{index},#{var_values}"
      end

      "#{header}\n#{rows.join("\n")}"
    end

    def data
      data = Data.new
      data.periods = @periods
      data
    end
  end
end

