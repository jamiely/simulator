require 'simulator'
include Simulator

describe "a model" do
  before :each do
    @model = Model.new
  end

  it "has equations" do
    @model.equations.nil?.should be false
  end

  it "has variables" do
    @model.variables.nil?.should be false
  end

  it "accepts new variables" do
    @model.variables.length.should be 0
    x = Variable.new :x
    @model.add_variable x
    @model.variables.length.should be 1
  end

  it "accepts new equations" do
    @model.equations.length.should be 0
    e = Equation.new nil do
      1
    end
    @model.add_equation e
    @model.equations.length.should be 1
  end
end

