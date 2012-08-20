Feature: User Login
  In order to access member areas of the site
  As a user
  I want to be able to log in

  Background:
    Given I have a registered account
      And I am logged out

  Scenario: Log in with valid credentials
    When I log in with valid credentials
    Then I should be logged in

  Scenario: Log in with invalid credentials
    When I log in with an invalid password
    Then I should be redirected to the login page
      And I should be logged out
