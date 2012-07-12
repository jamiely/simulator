Feature: equations
  In order to create simulations
  As a simulation author
  I want to be able to create equations which model the behavior of a system

  Scenario: adding equations to scenarios
    Given a model
    When I add a new equation
    Then it should be accessible in the list of equations

  Scenario: creating an equation based on the pythagorean equation
    Given a variable context
    And bound variable "x=3"
    And bound variable "z=4"
    When I create a new equation "Math.sqrt(x^2 + z^2)"
    Then I get a value result 5

