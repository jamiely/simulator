module Simulator
  class Data
    attr_accessor :periods
    def series(*var_names)
      data = var_names.collect do |var_name|
        @periods.collect do |period|
          var = period.context.get var_name
          var.value unless var.nil?
        end
      end

      # If we just hae one series, then just return the first
      var_names.length == 1 ? data.first : data
    end
    def series_with_headers(*var_names)
      data = series *var_names
      table = var_names.zip data
      table.collect do |row|
        row.flatten
      end
    end
  end
end
