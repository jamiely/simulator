require 'simulator'
include Simulator

describe "a run" do
  before :each do
    @model = Model.new
    var_x = Variable.new :x
    eqtn = Equation.new var_x do
      x + 1
    end
    @model.add_equation eqtn
    @model.add_variable var_x
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

  it "can evaluate model equations in its current context" do
    @run.set x: 3
    @run.evaluate
    @run.variable_value(:x).should be 4
    @run.evaluate
    @run.variable_value(:x).should be 5
  end

  it "can increment periods" do
    @run.periods.length.should be 1
    @run.increment_period
    @run.periods.length.should be 2
  end
end

