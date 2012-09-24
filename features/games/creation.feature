Feature: Games Creation
  In order to share my games with my colleagues
  As a user
  I want to be able to create games

  Background:
    Given I have a registered account
      And I am logged in

  Scenario: User creates a game with valid data
    When I create a game
    Then I should be redirected to my account page
      And I should be shown a notice with game created
