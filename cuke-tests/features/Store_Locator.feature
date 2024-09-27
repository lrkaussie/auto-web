Feature: Store Locator
  As a tester I want to check whether the store locator functionality works

  @store @perf
  Scenario: As a user I want sensible default behaviour for the store finder
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page |user_state   |
      |COG |AU     |Don |guest       |store-finder |not_logged_in|
    And no default selected brand is displayed
    And I select "CottonOn" brand
    And I leave the default selected country as "Australia"
    When I click on the Search button on the Store Finder page
    Then the first store locator displayed has the following details:
      | store_city     | store_name | store_brand_name |
      | WHYALLA NORRIE | WHYALLA    | Cotton On        |
#    Then the store locator results are:
#      | store_city     | store_name | store_brand_name |
#      | WHYALLA NORRIE | WHYALLA    | Cotton On        |