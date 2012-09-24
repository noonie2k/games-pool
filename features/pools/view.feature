Feature: Viewing Pools
  In order to view the available content within a pool
  As a user
  I want to be able to visit and view pools

  Background:
    Given I have a registered account
      And I am logged in
      And There is an existing pool

  Scenario: User visits a site he is a member of
    When I go to the join pools page
      And I enter a valid invite code
      And I go to the last pool page
    Then I should be redirected to the last pool page

  Scenario: User visits a site he is not a member of
    When I go to the last pool page
    Then I should be redirected to the home page
      And I should be shown a notice with not a member
