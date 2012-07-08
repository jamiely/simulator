Feature: simulation building
  In order to create a framework for constructing simulations
  As a simulation author
  I want to be able to build new simulations

  Scenario: equation interpretation
    Given an equation z = x * y
    When I input x = 4, y = 10
    Then I should get a result that z = 40

  Scenario: periods
    Given a scenario with an equation z = 10
    When I specify 10 periods
    And run the simulation 
    Then I should get output in the form of 10 instances of 10


