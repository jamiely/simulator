require 'simulator'
include Simulator

Given /^a variable context$/ do
  @context = VariableContext.new
end

Given /^a value (\d+) bound to (\w+)$/ do |value, name|
  @context.add name.to_sym => value.to_i
end

When /^I create a new equation "(.*?)"$/ do |arg1|
  @pythagorean_eqtn = Equation.new do
    Math.sqrt( x*x + z*z )
  end
end

Given /^variables with values x=(\d+), and y=(\d+)$/ do |x_value, y_value|
  @context = VariableContext.new
  @context.add x: 3, z: 4

  # set the values of the variables in this context
  @context.set x: x_value.to_i, z: y_value.to_i
end

Then /^I get a value result (\d+)$/ do |equation_result|
  # the context evaluates an equation in its own context
  @pythagorean_eqtn.evaluate_in(@context).should eq equation_result.to_i
end

Then /^a bound variable "(.*?)" with value (\d+)$/ do |var_name, value|
  @context.get(var_name.to_sym).value.should eq value.to_i
end

Given /^a model$/ do
  @model = Model.new
end

When /^I add a new equation$/ do
  @new_equation = Equation.new do
    1 + 1
  end
  @model.add_equation @new_equation
end

Then /^it should be accessible in the list of equations$/ do
  @model.equations.member?(@new_equation).should be true
end


