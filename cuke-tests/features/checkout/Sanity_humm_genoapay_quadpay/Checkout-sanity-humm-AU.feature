@humm
Feature: Checkout - humm - COG-AU

  As a user I want to check out with humm as the payment provider
  In AU, we have these products
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
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "humm"
    And the user clicks on the Continue to Payment button on the Checkout page for "humm"
    And on humm page user places an order with an existing user in "AU"
    And on humm page user selects to go back to checkout "after login"
    Then in BM last humm order for "Don" is:
      | humm_order_status | humm_processor |  humm_invoice | humm_personalised_order_true |
      | FAILED            | HUMM           |  false        | true                         |

  Scenario: Checkout with humm as a registered user with mixed cart and click to return to sandbox link on humm HPP before login
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "humm"
    And the user clicks on the Continue to Payment button on the Checkout page for "humm"
    And on humm page user selects to go back to checkout "before login"
    Then in BM last humm order for "Don" is:
      | humm_order_status | humm_processor |  humm_invoice | humm_personalised_order_true |
      | FAILED            | HUMM           |  false        | true                         |

  Scenario: Verify the error for humm as a guest user with international delivery and billing addresses
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "US" international delivery address
    And user selects the payment type as "humm"
    And the user clicks on the Continue to Payment button on the Checkout page for "humm"
    And user sees the global error message:
      | error_message |
      | Humm is not available for billing addresses outside of Australia. |

  Scenario: Verify the error for humm payment method as a guest user with national delivery and international billing addresses
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 3   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing details for "humm" with "US" international address
    And the user clicks on the Continue to Payment button on the Checkout page for "humm"
    And user sees the global error message:
      | error_message |
      | Humm is not available for billing addresses outside of Australia. |

  Scenario: Verify humm is not present on the CO page as a registered user with mixed cart
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    Then "humm" payment method is not present on the checkout page