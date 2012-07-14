require 'simulator'
include Simulator

Given /^a savings model$/ do
  @model = Model.new
end

Given /^variable "([_\w]+)"$/ do |var_name|
  @model.add_variable Variable.new var_name.to_sym
end

Given /^equation "(.*?)" bound to ([\w_]+)$/ do |eqtn_str, var_name|
  var = @model.get_variable var_name.to_sym
  eqtn = Equation.new var do
    eval eqtn_str
  end
  @model.add_equation eqtn
end

Given /^the value (-?[\d\.]+) bound to ([\w_]+)$/ do |value, name|
  @run.set name.to_sym => value.to_f
end

Given /^a new run of the model$/ do
  @run = Run.new @model
end

When /^I step the run for (\d+) periods$/ do |period_count|
  period_count.to_i.times do
    @run.step
  end
end

Then /^the value (-?[\d\.]+) should be bound to ([\w_]+)$/ do |expected, var_name|
  actual = @run.variable_value var_name.to_sym
  actual.should be_within(0.001).of expected.to_f
end



