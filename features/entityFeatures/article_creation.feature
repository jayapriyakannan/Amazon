Feature: As a planetradio user I would like to search different collections

  Scenario: user creates an article
    Given I have logged in as defaultUser
    When I create a new article
    Then article should be created successfully
    When I delete the created article
    Then article should be deleted successfully