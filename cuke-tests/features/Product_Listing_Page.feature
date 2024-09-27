Feature: Product Listing Page
        As a user I want to check whether the product listing functionality works

@plp
  Scenario: As a user I want sensible default behaviour for the product listing page
    Given I am on the "NZ" site "women" category "womens-tops" subcategory page
    Then I have options on PLP to sort by "Price high to low", "Price low to high" and "What's New"
    And I have options on PLP to show "24", "48" and "96"
    And default Show option on PLP is "48"
    And pagination page selected is "1"

  Scenario: As a user I want check sort by functionality high to low of the product listing page
    Given I am on the "NZ" site "women" category "womens-tops" subcategory page
    When I select a sort value of price high to low
    Then the price decreases down the list
    And I see that the default filter is set to "Price high to low"

  Scenario: As a user I want check sort by functionality low to high of the product listing page
    Given I am on the "NZ" site "women" category "womens-tops" subcategory page
    When I select a sort value of price low to high
    Then the price increases down the list
    And I see that the default filter is set to "Price low to high"

  Scenario: As a user I want check Show functionality specific to show 24 products
    Given I am on the "NZ" site "women" category "womens-tops" subcategory page
    When I select a show value of "24"
    Then the search results page has "24" products

  Scenario: As a user I want check Show functionality specific to show 48 products
    Given I am on the "NZ" site "women" category "womens-tops" subcategory page
    When I select a show value of "48"
    Then the search results page has "48" products


