@subsite
Feature: Subsite - COG-ZA

  As a user I want to check if subsite feature when switched On is working as expected
  In ZA, we have these products
  |138436-02 |Typo Brand |
  |665575-03| Cotton On Brand |
  |965575-23|Kids Brand |

  Scenario: Verify cotton on product subsite and brand with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "665575-03"
    And the highlighted brand tile is of subsite "co" and brand "brand-co"

  Scenario: Verify typo product subsite with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "138436-02"
    And the highlighted brand tile is of subsite "typo"

  Scenario: Verify subsite and brand highlighted when navigate to a product which is not existing with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "965575-23" which does not exist
    And the highlighted brand tile is of subsite "co" and brand "brand-co"
    When Navigate to the brand "kids"
    And the user navigates to PDP of the product "965575-23" which does not exist
    Then the highlighted brand tile is of subsite "kids"

  Scenario: Verify no search result and search result page based on subsite
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And Navigate to the brand "kids"
    Then I search for "Springtime" in the search text box
    And I click on the search magnifying glass
    And no search result page is displayed with the message as "We couldn't find any results for"
    And Navigate to the brand "cottonon"
    Then I search for "Springtime" in the search text box
    And I click on the search magnifying glass
    And search results page for "Springtime" is displayed

  Scenario: Verify new PLP of typo subsite with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And user navigates to "typo/stationery-living/stationery/journals/" page
    And the highlighted brand tile is of subsite "typo"

  Scenario: Verify old PLP url not existing in typo or any subsite with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And user navigates to "typo/stationery-living/stationery/journaills/" page
    And the highlighted brand tile is of subsite "co" and brand "brand-co"
    When Navigate to the brand "typo"
    And user navigates to "typo/stationery-living/stationery/journaills/" page
    Then the highlighted brand tile is of subsite "typo"

  Scenario: Verify highlighting of brands in brand header based on query param with subsite feature ON(HP query param does not work as per the rule)
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    When user navigates to "/?subsiteID=kids" page
    Then the highlighted brand tile is of subsite "co"
    When user navigates to "bag/?subsiteID=kids" page
    Then the highlighted brand tile is of subsite "kids"

  Scenario: Verify highlighting of last selected brand in brand header on navigating to My Bag page with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    When a bag with products:
      | sku           | qty |
      | 9351533834022 | 1   |
    Then the highlighted brand tile is of subsite "factorie"
    And Navigate to the brand "typo"
    And I click on View Cart button
    Then the highlighted brand tile is of subsite "typo"

  Scenario: Verify highlighting of last selected brand in brand header on returning from adyen HPP with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    When a bag with products:
      | sku           | qty |
      | 9351533834022 | 1   |
    And Navigate to the brand "typo"
    And I click on View Cart button
    And user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And user selects the payment type as "payflex"
    And the user clicks on the Continue to Payment button on the Checkout page for "payflex"
    And user click cancel transaction on payflex page
    Then on CO page user clicks edit button in summary section
    And the highlighted brand tile is of subsite "typo"

  Scenario: Verify highlighting of brands in brand header based on cgid param(for not existing and existing cat id) with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    When user navigates to "search/?cgid=clothing-shorts" page
    Then the highlighted brand tile is of subsite "co"
    When user navigates to "search/?cgid=kids-boys-1-8" page
    Then the highlighted brand tile is of subsite "kids"

  Scenario: Verify selected brand on subscribe page based on selected subsite with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And Navigate to the brand "typo"
    When I navigate to the loyalty subscription page
    Then no brand out of all "6" brands is pre-selected in the preference section
#    Then the highlighted brand in the preference section is "Typo"
    And Navigate to the brand "cottonon"
    When I navigate to the loyalty subscription page
    Then no brand out of all "6" brands is pre-selected in the preference section
#    Then the highlighted brand in the preference section is "Cotton On"

  Scenario: Verify selected brand on register page based on selected subsite with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    And Navigate to the brand "typo"
    When the user navigates to Create an account page
    And user selects the join perks checkbox on register pg
    Then no brand out of all "6" brands is pre-selected in the preference section
#    Then the highlighted brand in the preference section is "Typo"
    And Navigate to the brand "cottonon"
    When the user navigates to Create an account page
    And user selects the join perks checkbox on register pg
    Then no brand out of all "6" brands is pre-selected in the preference section
#    Then the highlighted brand in the preference section is "Cotton On"

  Scenario: Verify selected brand on store finder page based on selected subsite with subsite feature ON
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SA      | Junior | guest        | sign-in      | not_logged_in |
    When user navigates to Store Finder page
    Then for "Cotton On" selected header brand, "3" brands are selected by default on store locator page
    And Navigate to the brand "typo"
    And user navigates to Store Finder page
    Then for "Typo" selected header brand, "1" brands are selected by default on store locator page