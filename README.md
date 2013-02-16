# Simulator

Use to easily create models and view results across periods. 

[![Build Status](https://travis-ci.org/jamiely/simulator.png?branch=master)](https://travis-ci.org/jamiely/simulator)

## Installation

Add this line to your application's Gemfile:

    gem 'simulator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simulator

## Usage

See the features for some examples.

    bundle exec cucumber

See the specs for some simpler examples.

    bundle exec rspec

See the `examples` subdirectory for examples as well. Including the one
excerpted below:

```ruby
# We create a model that simulates a ball drop
model = Simulator::Model.new do
  name = "Ball drop model"
  # create a couple static variables to represent acceleration with
  # default values
  var :ax, 0
  var :ay, - 9.8

  # create dynamic variables bound to some computation, with default
  # values. 

  # velocity is affected by acceleration
  eqtn(:vx, 20) { vx + ax }
  eqtn(:vy, 50) { vy + ay }

  # position is affected by velocity
  eqtn(:x, 10) { x + vx }
  eqtn(:y, 100) { y + vy }
end

# Run the model 10 periods
model_run = model.new_run
10.times do 
  model_run.step
end

# retrieve the data
series = model_run.data.series :x, :y
puts series
# > [[30, 50, 70, 90, 110, 130, 150, 170, 190, 210, 210],
# > [140.2, 170.6, 191.2, 202.0, 203.0, 194.2, 175.6, 147.2, 108.99999999999999, 60.999999999999986, 60.999999999999986]]

# Then plot it or do whatever you like
```

