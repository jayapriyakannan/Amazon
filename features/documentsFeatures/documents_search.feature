Feature: As a planetradio user I would like to search and filter the articles

  Scenario Outline: user search for different document title
    Given I have logged in as defaultUser
    When I search for "<search_item>" in document page
    Then I am shown the filtered results

    Examples: searching different collections
      | search_item                                        |
      | Man dies after falling on descent from Highland    |