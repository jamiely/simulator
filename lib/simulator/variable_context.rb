module Simulator
  class VariableContext
    def initialize
      @variables_hash = {}
    end

    def add(var_hash)
      vars = var_hash.collect do |k, v|
        Variable.new k
      end
      add_variables *vars
      set var_hash
    end

    # add variables. doesn't check for uniqueness, does not overwrite existing
    def add_variables(*vars)
      # create bound variables for each variable
      bound_vars = vars.collect do |v|
        BoundVariable.new v, self
      end

      # add all the bound variables to the variables hash
      keys = vars.collect(&:name)
      append_hash = Hash[ keys.zip(bound_vars) ]
      @variables_hash.merge!(append_hash) do |key, oldval, newval|
        oldval # the first bound variable
      end
    end

    # Use to set the value for a variety of variables
    def set(var_hash)
      var_hash.each do |variable_name, value|
        throw :MissingVariable unless @variables_hash.has_key? variable_name

        bv = @variables_hash[variable_name]
        bv.value = value
      end
    end

    def get(var_name)
      @variables_hash[var_name]
    end

    def variables
      @variables_hash.values
    end

    def unbound_variables
      variables.collect(&:variable)
    end

    def clone
      copy = VariableContext.new
      copy.add_variables *unbound_variables

      # create a value hash of variable names and values
      value_hash = variables.inject({}) do |memo, v|
        memo[v.name] = v.value
        memo
      end
      copy.set value_hash
      copy
    end
  end
end

