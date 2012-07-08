Feature: savings simulation
  In order to simulate the outcome of savings rates across a number of periods
  As a simulation runner
  I want the simulation to output the outcome of the decisions made

  Scenario: constant savings rate
    Given I enter 5% as the savings rate for each of 10 periods
    And I start with a principle of $100 in my account
    When I run the simulation
    Then the result should be $100 * 1.05^10 = $162.89

  Scenario: variable savings rate
    Given I enter 5% as the first period savings rate, and add 1% each period for 5 periods
    And I start with a principle of $100 
    When I run the entire simulation
    Then the result should be $100 * 1.05 * 1.06 * 1.07 * 1.08 * 1.09 = $140.19

