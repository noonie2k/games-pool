Feature: Joining Pools
  In order to share games with my colleagues
  As a user
  I would like to join pools

  Background:
    Given I have a registered account
      And I am logged in
      And There is an existing pool

  Scenario: User joins a pool
    When I go to the join pools page
      And I enter a valid invite code
    Then I should be redirected to the last pool page
      And I should be shown a successful join message
      And I should be a member of the existing pool

  Scenario: User attempts to join a pool with an incorrect invite code
    When I go to the join pools page
      And I enter an invalid invite code
    Then I should be shown a failed join message with invalid invite code
      And I should not be a member of the existing pool

  Scenario: User attempts to join a pool again
    Given I am a member of the existing pool
    When I go to the join pools page
      And I enter a valid invite code
    Then I should be redirected to the last pool page
