Feature: Using previous values in equations
  In order to simulate models that depend on previous values
  As someone simulating a model across time
  I want to be able to access and use previous values

  Scenario: using a value from a previous period
    Given a model
    And variable "accumulator"
    And variable "result"
    And equation "previous.accumulator + 1" bound to result
    And a new run of the model
    And the value 100 bound to accumulator
    When I step the run for 10 periods
    Then the value 110 should be bound to result

