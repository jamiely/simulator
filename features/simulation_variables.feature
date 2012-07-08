Feature: simulation variables
  In order to distinguish between different types of input and variables
  As a simulation author
  I want different types of variables with different properties to be available

  Scenario: model variables
    Given a scenario
    When I create a model variable
    Then it should not be changeable by users

  Scenario: decision variables
    Given a scenario with decision variables
    When I create different runs
    Then changing the variable in one run should not affect the other run

