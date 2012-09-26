Feature: Requesting Holds on Game
  In order to borrow a game from a colleague
  As a user
  I want to be able to request a hold on a game

  Background:
    Given I have a registered account
    And I am logged in
    And There are existing games

  Scenario: User requests a hold on a game
    When I go to the first game page
    And I request a hold on the first game
    Then I should be shown a notice with game held

  Scenario: User requests a second hold on a game
    Given I have a hold on the first game
    When I go to the first game page
    And I request a hold on the first game
    Then I should be shown a notice with already held

  Scenario: User requests a hold on a second game with the same title/platform
    Given I have a hold on the first game
    When I go to the last game page
    And I request a hold on the last game
    Then I should be shown a notice with already held
