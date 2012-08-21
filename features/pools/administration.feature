Feature: Pools Administration
  In order to share games with my colleagues
  As a user
  I want to be able to create and manage pools

  Background:
  	Given I have a registered account
    When I log in with valid credentials

  Scenario: Creating a pool with a password
    When I create a pool with a password
    Then I should be shown a success message
      And I should be redirected to the last pool model page
