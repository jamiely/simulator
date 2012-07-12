require File.join(File.dirname(__FILE__), '../../lib/simulator')

Given /^a variable context$/ do
  @context = VariableContext.new
end

Given /^bound variable "([^=]*)=(\d+)"$/ do |var_name, value|
  @context.add var_name.to_sym => value.to_i
end

When /^I create a new equation "(.*?)"$/ do |arg1|
  @pythagorean_eqtn = Equation.new do
    Math.sqrt( x*x + z*z )
  end
end

Given /^variables with values x=(\d+), and y=(\d+)$/ do |x_value, y_value|
  @context = VariableContext.new
  @context.add x: 3, z: 4

  # add new variables to the context
  @context.add_variables var_x, var_y

  # set the values of the variables in this context
  @context.set x: x_value.to_i, z: y_value.to_i
end

Then /^I get a value result (\d+)$/ do |equation_result|
  # the context evaluates an equation in its own context
  @pythagorean_eqtn.evaluate_in(@context).should eq equation_result.to_i
end

Given /^a scenario$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I add a new equation$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^it should be accessible in the list of equations$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a set of variables and values$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I use them in a new equation$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the result should appear as expected$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^a bound variable "(.*?)" with value (\d+)$/ do |var_name, value|
  @context.get(var_name.to_sym).value.should eq value.to_i
end
