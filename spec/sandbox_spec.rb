require File.join(File.dirname(__FILE__), '../lib/simulator')

describe "an evaluation sandbox" do
  before :each do
    @context = VariableContext.new
    @context.add x: 3, z: 4
    @sandbox = Sandbox.new @context
  end
  it "can evaluate variables" do
    @sandbox.instance_eval do
      x
    end.should eq 3
    @sandbox.instance_eval do
      z
    end.should eq 4
  end
  it "is used to evaluate expressions" do
    @sandbox.instance_eval do
      x * z
    end.should eq 12
  end
end

