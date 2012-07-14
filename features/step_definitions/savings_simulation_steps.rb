require 'simulator'
include Simulator

Given /^a savings model$/ do
  @model = Model.new
end

Given /^variable "([_\w]+)"$/ do |var_name|
  @model.add_variable Variable.new var_name.to_sym
end

Given /^equation "(.*?)"$/ do |eqtn_text|
  @model.add_equation Equation.new do
    eval eqtn_text
  end
end

Given /^the value ([\d\.]+) bound to ([\w_]+)$/ do |value, name|
  @run.set name.to_sym => value
end

Given /^a new run of the model$/ do
  @run = Run.new @model
end

When /^I step the run for (\d+) periods$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the result should be (\d+)\.(\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end



