Feature: savings simulation
  In order to simulate the outcome of savings rates across a number of periods
  As a simulation runner
  I want the simulation to output the outcome of the decisions made

  Scenario: constant savings rate
    Given a savings model
    And variable "principle"
    And variable "savings_rate"
    And variable "savings"
    And equation "savings + principle * (1+savings_rate)" bound to savings
    And a new run of the model
    And the value 0 bound to savings
    And the value 100 bound to principle
    And the value 0.05 bound to savings_rate
    When I step the run for 10 periods
    Then the value 162.89 should be bound to savings


