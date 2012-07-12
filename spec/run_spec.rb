require 'simulator'
include Simulator

describe "a run" do
  before :each do
    @model = Model.new
    @model.add_equation Equation.new do
      x
    end
    @model.add_variable Variable.new :x
    @run = Run.new @model
  end

  it "has bound variables" do
    @run.variables.first.class.should be BoundVariable
  end

  it "is not affected by setting variables in a different run" do
    run2 = Run.new @model

    @run.set x: 1
    run2.set x: 2

    @run.variable_value(:x).should be 1
    run2.variable_value(:x).should be 2
  end
end

