Feature: New User Registration
  In order to access member areas of the site
  As a visitor
  I would like to be able to register as a user

  Background:
    Given I am a visitor visiting the site
      And I am logged out

  Scenario: Visitor registers with valid information
    When I register with valid information
    Then I should be redirected to the root page
      And I should be shown a welcome message
      And I should have a user account
      And I should be logged in

  Scenario: Visitor registers with invalid information (missing username)
    When I register with missing username
    Then I should be shown an invalid entry message
      And I should not have a user account

  Scenario: Visitor registers with invalid information (missing email)
    When I register with missing email
    Then I should be shown an invalid entry message
      And I should not have a user account

  Scenario: Visitor registers with invalid information (missing name)
    When I register with missing name
    Then I should be shown an invalid entry message
      And I should not have a user account

  Scenario: Visitor registers with invalid information (mismatched password)
    When I register with mismatched password
      And I should be shown an invalid entry message
      And I should not have a user account