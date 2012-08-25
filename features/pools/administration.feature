Feature: Pools Administration
  In order to share games with my colleagues
  As a user
  I want to be able to create and manage pools

  Background:
  	Given I have a registered account
      And I am logged in

  Scenario: Creating a pool with a password
    When I create a pool
    Then I should be redirected to the last pool page
      And I should be shown a notice with welcome
