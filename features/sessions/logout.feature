Feature: User Logout
  In order to protect my account
  As a user
  I want to be able to log out

  Background:
    Given I have a registered account

  Scenario: Log in with valid credentials
    When I log in with valid credentials
      And I log out
    Then I should be logged out
