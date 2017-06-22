@smoke
  Feature: As a end user I would like to login to the amazon site.

    Scenario: user attempts to login with invalid credentials
      When I attempt to login with invalid credentials
      Then I am shown an error "Email or Password is wrong!" message

    Scenario: user login with valid credentials
      When I have logged in as defaultUser
      Then I am in home page


Feature: Shop online at Amazon.co.uk

  Scenario: Sign into Amazon.co.uk

    Given Amazon.co.uk is open
    When I click Sign-in
    And enter valid user name password
    Then I am logged in

  Scenario: Search for product and verify the first result is related to your product

    Given Amazon.co.uk is open and I am logged in

    When I search for "#### (pick a product of your choice)"

    Then the first result has the word ”####" in it

  Scenario: verify that the original price of the product matches the price seen in the basket

    Given Amazon.co.uk is open and I am logged in

    And I add "####(pick a product of your choice)" to my basket

    When I check my basket total

    Then it should match the price of "#### (pick a product of your choice)"