@wishlist_my @my
Feature: Verifying out of stock scenario on wishlist page for registered user
  As a Cottonon Customer, I want to see OOS badge and disabled add to bag button on Wishlist page

  Assumption
  In MY, we have these products
  | Colour    |  SKU          | Size | Type           |
  | 135820-00 | 9351785724027 | NA   | single size    |
  | 131999-01 | 9351785722917 | NA   | single size    |

  The following users exist in Commerce Cloud and used for registered user scenarios
  | Email                | First Name | Last Name | Commerce Cloud Account |
  | raja.zaidi@email.com | Raja       | Zaidi     | Yes                    |


  @guest @wip
  Scenario: Out of stock and its removal functionality on Wishlist page
  Given I log on to the site with the following:
    | site | country | user  | type_of_user | landing_page | user_state    |
    | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
  And the inventory of the product is changed in the BM as below:
      | sku           | inventory |
      | 9351785724027 | in_stock  |
  And refresh the PDP page of the product with sku as "9351785724027"
  When I add the products to Wishlist from PDP page
    | sku           |
    | 9351785724027 |
  And the inventory of the product is changed in the BM as below:
    | sku           | inventory    |
    | 9351785724027 | out_of_stock |
  And I log on to the site with the following:
    | site | country | user  | type_of_user | landing_page | user_state    |
    | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
  And I navigate to Wishlist page
  Then the OUT OF STOCK badge is displayed on the thumbnail of product "135820-00" on Wishlist page
  And Add to Bag button is disabled for product "135820-00" on Wishlist page
  And I remove the products from Wishlist page
    | product   |
    | 135820-00 |
  And there are no products on the Wishlist page
  And the message "You have no saved items." is displayed on Wishlist page


  @registered
  Scenario: Out of stock products functionality on Wishlist page as a registered user
  Given I log on to the site with the following:
    | site | country | user  | type_of_user | landing_page | user_state |
    | COG  | MY      | Raja  | registered   | sign-in      | logged_in  |
    When I navigate to Wishlist page
    Then the OUT OF STOCK badge is displayed on the thumbnail of product "131999-01" on Wishlist page
    And Add to Bag button is disabled for product "131999-01" on Wishlist page