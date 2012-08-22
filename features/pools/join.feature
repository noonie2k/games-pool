Feature: Joining Pools
  In order to share games with my colleagues
  As a user
  I would like to join pools

  Background:
    Given I have a registered account
      And I am logged in
      And There is an existing pool

  Scenario: User joins a pool
    When I click to join the existing pool
      And I enter a valid password
    Then I should be redirected to the last pool page
      And I should be shown a successful join message
      And I should be a member of the existing pool

  Scenario: User attempts to join a pool with an incorrect password
    When I click to join the existing pool
      And I enter an invalid password
    Then I should be shown a failed join message with invalid password
      And I should not be a member of the existing pool

  Scenario: User attempts to join a pool again
    Given I am a member of the existing pool
    When I click to join the existing pool
    Then I should be redirected to the last pool page
      And I should be shown a failed join message with welcome back
