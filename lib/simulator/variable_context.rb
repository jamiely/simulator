class VariableContext
  def initialize
    @variables = []
  end

  # add variables
  def add_variables(*vars)
    @variables.push(*vars)
  end
end

