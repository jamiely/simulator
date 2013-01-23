require 'simulator'
include Simulator

describe "a beer distribution simulation" do
  before :each do
    @model = Model.new do
      name = "Beer Distribution"

      var :time_to_ship, 1
      var :vendor_orders, 10
      eqtn :available_goods do
        delay :vendor_orders, time_to_ship
      end

      eqtn :ordered_from_vendors do
        if ordered_from_vendors.nil?
          vendor_orders
        else
          delta = vendor_orders - available_goods
          ordered_from_vendors + delta
        end
      end

      var :time_to_build_product, 1
      eqtn :wip_completion do
        delay :available_goods, time_to_build_product
      end
      eqtn :work_in_progress do
        if work_in_progress.nil?
          available_goods
        else
          delta = available_goods - wip_completion
          work_in_progress + delta
        end
      end
      eqtn :finished_goods_inventory do
        if finished_goods_inventory.nil?
          wip_completion
        else
          delta = wip_completion - shipments
          finished_goods_inventory + delta
        end
      end

      var :new_customer_orders, 10 # this should be an equation later
      eqtn :unfilled_orders do
        [0, new_customer_orders - shipments].max
      end
      eqtn :total_customer_orders do
        cumulative_unfilled_orders + new_customer_orders
      end
      var :shipments, 0
      eqtn :shipments do
        [total_customer_orders, finished_goods_inventory].min
      end

      eqtn :inventory_coverage do
        begin
          finished_goods_inventory/total_customer_orders 
        rescue
          0
        end
      end

      var :fraction_of_unfilled_orders_that_are_cancelled, 0.25
      eqtn :cancelled_unfilled_orders do
        tmp = cumulative_unfilled_orders - filled_orders
        tmp2 = tmp * fraction_of_unfilled_orders_that_are_cancelled
        tmp2.round
      end

      var :cumulative_unfilled_orders, 0
      eqtn :cumulative_unfilled_orders do
        delta = unfilled_orders - filled_orders - cancelled_unfilled_orders
        cumulative_unfilled_orders + delta
      end

      var :filled_orders, 0
      eqtn :filled_orders do 
        [0, shipments - new_customer_orders].max
      end
      var :lost_orders, 0
      eqtn :lost_orders do
        lost_orders + cancelled_unfilled_orders
      end
    end

    @run = Run.new @model
  end

  it "can step a run" do
    puts @run.summary
    @run.period_count.should eq 1

    @run.step
    puts @run.summary

    @run.step
    puts @run.summary

    @run.step
    puts @run.summary

    puts @run.variables_csv
  end
end

