@wishlist_au @au
Feature: Add and remove products to/from Wishlist
  As a Cottonon Customer, I want to Add products to Wishlist and Remove products from Wishlist page

  Assumption
  In AU, we have these products
  | Colour    |  SKU          | Size | Type           |
  | 141084-03 | 9351533563175 | NA   | single size    |
  | 270882-03 | 9351785586526 | XS   | multiple sizes |

  The following users exist in Commerce Cloud and used for registered user scenarios
  | Email                 | First Name | Last Name | Commerce Cloud Account |
  | don.bradman@email.com | Don        | Bradman   | Yes                    |

# CO-3824, CO-3825, CO-3826, CO-3861
# BM Configurations: Customer Preference/ Wishlist Toggle / Enable

  @guest @wl1
  Scenario: No saved items Message as 'You have no saved items' on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When I navigate to Wishlist page
    Then the message "You have no saved items." is displayed on Wishlist page

  @guest @wl1
  Scenario: 'Start Shopping' link not present on empty Wishlist page without plp session
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    Then I navigate to Wishlist page
    And "Start Shopping" link is not present on Wishlist page

  @guest @wl1
  Scenario: 'Start Shopping' link functionality on empty Wishlist page with plp session
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When user navigates to "gifts/gift-card/" page
    Then I navigate to Wishlist page
    And I click on "Start Shopping" link on Wishlist page
    Then the user stays on PLP of "gifts/gift-card/"

  @guest @wl1
  Scenario: Guest user viewing Saved items on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    Then I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
      | 270882-03 |
    And I see "2" items on the Wishlist page

  @guest @wl1
  Scenario: Clicking on Product thumbnail navigates to PDP from Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
    And I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
    When I click on thumbnail of product "141084-03" on Wishlist page
    Then I validate the selected colour "141084-03" on the PDP page

  @guest @wl1
  Scenario: Clicking on product name navigates to PDP from Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351785586526 |
    And I navigate to Wishlist page
    Then the products displayed on Wishlist page are
       | product   |
       | 270882-03 |
    When I click on the name of product "270882-03" on Wishlist page
    Then I validate the selected colour "270882-03" on the PDP page

  @guest @wl1
  Scenario: Add to Bag for single size product on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    When the Add to Bag button is clicked for the product "141084-03" on Wishlist page
    Then "Added to bag" message is displayed on Wishlist page
    And the mini cart counter increases to "1"
    And the products displayed on Wishlist page are
      | product   |
      | 270882-03 |
    And I see "1" items on the Wishlist page

  @guest @wl1
  Scenario: Add to Bag for product with sizes on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    When the Add to Bag button is clicked for the product "270882-03" on Wishlist page
    And "XL" size is selected from the size selector on Wishlist page
    Then "Size XL added to bag" message is displayed on Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
    And I see "1" items on the Wishlist page

  @guest @wl1
  Scenario: Remove Single item from Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    When I remove the products from Wishlist page
      | product   |
      | 141084-03 |
    Then the products displayed on Wishlist page are
      | product   |
      | 270882-03 |
    And I see "1" items on the Wishlist page

  @guest @wl1
  Scenario: Verifying 'Remove All items' button functionality from Remove All overlay message on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    When I click on "Remove all" link on Wishlist page
    Then an overlay with the message "Are you sure you'd like to remove all items from your wishlist?" is displayed on Wishlist page
    And I click on "Remove all items" button in the overlay on Wishlist page
    And there are no products on the Wishlist page
    And the message "You have no saved items." is displayed on Wishlist page

  @guest @wl2
  Scenario: Verifying 'No Thanks' button functionality from Remove All overlay on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    When I click on "Remove all" link on Wishlist page
    Then an overlay with the message "Are you sure you'd like to remove all items from your wishlist?" is displayed on Wishlist page
    And I click on "No Thanks" button in the overlay on Wishlist page
    And I do not see the overlay message on Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
      | 270882-03 |

  @guest @wl2
  Scenario: Verifying cross icon functionality from Remove All overlay on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    When I click on "Remove all" link on Wishlist page
    Then an overlay with the message "Are you sure you'd like to remove all items from your wishlist?" is displayed on Wishlist page
    And I click on "X" button in the overlay on Wishlist page
    And I do not see the overlay message on Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
      | 270882-03 |

  @registered @wl2
  Scenario: "Start Shopping" link not present on Wishlist page for reg user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    When I navigate to Wishlist page
    And the Wishlist page is empty
    Then "Start Shopping" link is not present on Wishlist page

  @registered @wl2
  Scenario: No saved items Message as 'You have no saved items' on Wishlist page for reg user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    When user navigates to "gifts/gift-card/" page
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And the message "You have no saved items." is displayed on Wishlist page
    When I click on "Start Shopping" link on Wishlist page
    Then the user stays on PLP of "gifts/gift-card/"

  @registered @wl2
  Scenario: Registered user viewing Saved items on Wishlist page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    Then the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
      | 270882-03 |
    And I see "2" items on the Wishlist page
    And I click on thumbnail of product "141084-03" on Wishlist page
    And I validate the selected colour "141084-03" on the PDP page
    And I navigate to Wishlist page
    And I click on the name of product "270882-03" on Wishlist page
    And I validate the selected colour "270882-03" on the PDP page


  @registered @wl2
  Scenario: Add to Bag for single size product on Wishlist page for reg user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    And the Add to Bag button is clicked for the product "141084-03" on Wishlist page
    Then "Added to bag" message is displayed on Wishlist page
    And the mini cart counter increases to "1"
    And the products displayed on Wishlist page are
      | product   |
      | 270882-03 |
    And I see "1" items on the Wishlist page


  @registered @wl2
  Scenario: Add to Bag for product with sizes on Wishlist page for reg user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    And the Add to Bag button is clicked for the product "270882-03" on Wishlist page
    And "XL" size is selected from the size selector on Wishlist page
    Then "Size XL added to bag" message is displayed on Wishlist page
    And the mini cart counter increases to "1"
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
    And I see "1" items on the Wishlist page


  @registered @wl2
  Scenario: Verifying 'Remove All items' button functionality from Remove All overlay message on Wishlist page for reg user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    And I click on "Remove all" link on Wishlist page
    Then an overlay with the message "Are you sure you'd like to remove all items from your wishlist?" is displayed on Wishlist page
    And I click on "Remove all items" button in the overlay on Wishlist page
    And there are no products on the Wishlist page
    And the message "You have no saved items." is displayed on Wishlist page

  @registered @wl2
  Scenario: Verifying 'No Thanks' button functionality for registered user from Remove All overlay on Wishlist page for reg user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When I add the products to Wishlist from PDP page
      | sku           |
      | 9351533563175 |
      | 9351785586526 |
    And I navigate to Wishlist page
    And I click on "Remove all" link on Wishlist page
    Then an overlay with the message "Are you sure you'd like to remove all items from your wishlist?" is displayed on Wishlist page
    And I click on "No Thanks" button in the overlay on Wishlist page
    And I do not see the overlay message on Wishlist page
    And I click on "Remove all" link on Wishlist page
    And I click on "X" button in the overlay on Wishlist page
    And I do not see the overlay message on Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 141084-03 |
      | 270882-03 |