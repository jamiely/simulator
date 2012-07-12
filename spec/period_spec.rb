require 'simulator'
include Simulator

describe "a period" do
  before :each do
    #model = Model.new
    #[:x, :z].each do |v|
      #model.add_variable Variable.new v
    #end
    #run = Run.new model
    #@period = run.periods.first

    periods = []
    3.times do 
      periods << Period.new(nil, periods.clone)
    end
    @period = Period.new nil, periods
  end
  it "has a variable context" do
    @period.context.should_not be nil
  end
  it "knows about previous periods" do
    @period.previous_periods.should_not be_empty
    @period.previous.previous_periods.length.should be (@period.previous_periods.length - 1)
    @period.first.should be @period.previous_periods.first
  end
end

