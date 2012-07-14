Feature: Kinematics estimation
  In order to determine the path of a ball
  As someone studying physics
  I want to be able model kinematics equations

  Scenario: dropping a ball from rest
    Given a model
    And variable "velocity_y"
    And variable "acceleration_y"
    And variable "displacement_y"
    And variable "t"
    And equation "acceleration_y * t" bound to velocity_y
    And equation "0.5 * acceleration_y * t**2" bound to displacement_y
    And equation "t + 1" bound to t
    And a new run of the model
    And the value 0 bound to displacement_y
    And the value 1 bound to t
    And the value -9.8 bound to acceleration_y
    When I step the run for 10 periods
    Then the value -490 should be bound to displacement_y
    And the value -98 should be bound to velocity_y

