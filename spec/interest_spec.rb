require 'simulator'
include Simulator

describe "a simple interest model" do
  before :each do
    @model = Model.new do
      name = "Interest Model"

      var :balance
      var :interest

      eqtn :balance do 
        balance + balance * interest
      end
    end

    @run = Run.new @model
  end

  it "can step a run" do
    @run.period_count.should eq 1
    @run.set balance: 100, interest: 0.1 

    @run.step
    @run.period_count.should eq 2
    @run.variable_value(:balance).should eq 110
    @run.step

    @run.period_count.should eq 3
    @run.variable_value(:balance).should eq 121

    @run.set interest: 0.5
    @run.step
    
    @run.period_count.should eq 4
    @run.variable_value(:balance).should eq (181.5)
  end
end


describe "a complex interest model" do
  before :each do
    @model = Model.new do
      name = "Interest Model"

      var :balance
      var :interest

      eqtn :balance do 
        balance + balance * interest
      end

      eqtn :interest do
        # Add 1% each evaluation
        interest + 0.01
      end
    end

    @run = Run.new @model
  end

  it "can step a run" do
    @run.period_count.should eq 1
    @run.set balance: 100, interest: 0.1 

    @run.step
    @run.period_count.should eq 2
    @run.variable_value(:balance).should eq 110
    @run.variable_value(:interest).should eq 0.11
    @run.step

    @run.period_count.should eq 3
    @run.variable_value(:balance).should eq 122.1
    @run.variable_value(:interest).should eq 0.12

  end
end


