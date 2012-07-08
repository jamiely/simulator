require File.join(File.dirname(__FILE__), '../../lib/simulator')

Given /^variables with values x=(\d+), and y=(\d+)$/ do |x_value, y_value|
  var_x = Variable.new :x
  var_y = Variable.new :y

  @context = VariableContext.new

  # add new variables to the context
  @context.add_variables var_x, var_y

  # set the values of the variables in this context
  @context.set x: x_value, y: y_value
end

When /^I create a new equation sqrt\(x\^(\d+) \+ y\^(\d+)\)$/ do |arg1, arg2|
  @pythagorean_eqtn = Equation.new do
    Math.sqrt( x*x + y*y )
  end
end

Then /^I get a value result (\d+)$/ do |equation_result|
  # the context evaluates an equation in its own context
  @context.evaluate(@pythagorean_eqtn).should be(equation_result)
end

