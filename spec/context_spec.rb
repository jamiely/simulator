require 'simulator'
include Simulator

describe "a variable context" do
  before :each do
    @context = VariableContext.new
  end

  it "can contain variables explicitly" do
    @context.add_variables Variable.new(:x), Variable.new(:y)
    @context.set(x: 3, y: 4).should eq x: 3, y:4
  end

  it "can bind variables implicitly" do
    @context.add x:3, y: 4
    @context.get(:x).value.should eq 3
    @context.get(:y).value.should eq 4
  end

  it "binds variables to values using BoundVariables" do
    @context.add_variables Variable.new(:x), Variable.new(:y)
    @context.set x: 3, y: 4

    @context.get(:x).value.should eq 3
    @context.get(:y).value.should eq 4
  end
end

