Feature: Joining Pools
  In order to share games with my colleagues
  As a user
  I would like to join pools

  Background:
    Given I have a registered account
      And There is an existing pool
    When I log in with valid credentials

  Scenario: User joins a pool
    When I join the existing pool with a valid password
    Then I should be redirected to the last pool page
      And I should be shown a successful join message
      And I should be a member of the existing pool

  Scenario: User attempts to join a pool with an incorrect password
    When I join the existing pool with an invalid password
    Then I should be shown in invalid password message
      And I should not be a member of the existing pool
