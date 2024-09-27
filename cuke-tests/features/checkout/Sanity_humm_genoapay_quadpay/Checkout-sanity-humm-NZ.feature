@humm
Feature: Checkout - humm - COG-NZ

  As a user I want to check out with humm as the payment provider
  In NZ, we have these products
  | sku             | promo | price |product_promotion_price|order_discount|
  | 9351785509303   | Y     | 12.95 |11.95                  |5.18          |
  | 9351785092140   | N     | 49.99 |NA                     |NA            |
  | 9351785851327   | N     | NA    | NA                    | NA           |
  | EGIFT DESIGN 02 | N     | NA    | NA                    | NA           |

  Users used are Jesse and Don
  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9
  Assume configured payment method is humm

  Scenario: Checkout with humm as a registered user with mixed cart and click to return to sandbox link on humm HPP after login
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | NZ      | Bob  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "humm"
    And the user clicks on the Continue to Payment button on the Checkout page for "humm_nz"
    And on humm page user places an order with an existing user in "NZ"
    And on humm page user selects to go back to checkout "after login"
    Then in BM last humm order for "Bob" is:
      | humm_order_status | humm_processor |  humm_invoice | humm_personalised_order_true |
      | FAILED            | HUMM           |  false        | true                         |
