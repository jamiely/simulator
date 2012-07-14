require 'simulator'
include Simulator

describe "an equation" do
  before :each do
    @context = VariableContext.new
    @var_x = Variable.new :x
    @var_z = Variable.new :z

    # add new variables to the context
    @context.add_variables @var_x, @var_z

    # set the values of the variables in this context
    @context.set x: 3, z: 4
  end
  it "is bound to a variable" do
    @context.get(:x).value.should be 3
    eqtn = Equation.new @var_x do
      99
    end
    eqtn.evaluate_in(@context).should be 99
  end
end

