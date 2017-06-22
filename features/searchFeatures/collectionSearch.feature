Feature: As a planetradio user I would like to search different collections

  Scenario Outline: user performs different search under collections
    Given I have logged in as defaultUser
    When I search for "<search_item>" collection
    Then I am shown the results for collection

    Examples: searching different collections
    | search_item |
    | articles    |
    | contacts    |