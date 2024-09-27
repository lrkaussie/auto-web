@afterpay_checkout @au
Feature: Afterpay- COG-AU

  As a user I want to check out using afterpay
  In AU, we have these products
  | sku          | promo_type                                           | price |product_promotion_price|order_discount|
  | 9351785586540| NA                                                   | 199.99|NA                     |NA            |
  | 9351785586540| Y(product,order and shipping)                        | 19.95 |18.95                  |5.18          |

  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9


  @registered @hd @product_promo @afterpay @smoke_test
  Scenario: Checkout with registered user and afterpay, HD with product promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark   | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku       | qty |
      | 9351785586540 | 1   |
    When I change delivery method to "Standard"
    And the price of product before any promotion is "19.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "18.95"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay" 
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "2.27"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode       | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @registered @cnc @order_promo @afterpay
  Scenario: Checkout with registered user and afterpay, CNC with order promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark   | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku       | qty |
      | 9351785586540 | 2   |
    And the price of product before any promotion is "39.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "7.98"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "2.90"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode       | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @registered @hd @shipping_promo @jenkins @afterpay
  Scenario: Checkout with guest user and afterpay, HD with shipping promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark   | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku       | qty |
      | 9351785586540 | 3   |
    And the price of product before any promotion is "59.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "64.85"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "5.90"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode       | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @guest @hd @threshold @afterpay
  Scenario: Checkout with guest user and afterpay, HD, Afterpay not available when order total
  is above upper threshold
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9003150876526 | 6   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is only available on orders under AU$1,000.00|
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay" 
    And customer will land on the checkout page with "HD" details and the error message "Afterpay is only available on orders under AU$1,000.00"

  @guest @hd @afterpay
  Scenario: Verify the Afterpay checkout text with international shipping address and afterpay as a guest user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 9351785586540 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "GB" international delivery address
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is not available for delivery and billing addresses outside of Australia|

  @registered @hd @afterpay
  Scenario: Verify the Afterpay checkout text with international shipping address and afterpay as a registered user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark   | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku       | qty |
      | 9351785586540 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "GB" international delivery address
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is not available for delivery and billing addresses outside of Australia|