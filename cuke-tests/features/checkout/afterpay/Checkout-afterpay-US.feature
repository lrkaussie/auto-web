@afterpay_checkout @us
Feature: Afterpay- COG-US

  As a user I want to check out using afterpay
  In US, we have these products
  | sku             | promo_type                                           | price  |product_promotion_price|order_discount|
  | 9351785454856   | Y(product,order and shipping)                        | 169.99 |1.00                   |168.99        |

  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9
  default threshold is $35

  @registered @hd @product_promo @afterpay
  Scenario: Checkout with registered user and afterpay, HD with product promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    When I change delivery method to "Standard"
    And the price of product before any promotion is "169.99"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "168.99"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "US" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "12.67"
    And in BM last order for "Thomas" is:
      | order_status | adyen_status| eventcode     | authResult   |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @registered @cnc @order_promo @afterpay
  Scenario: Checkout with registered user and afterpay, CNC with order promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in   |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 2   |
    And the price of product before any promotion is "339.98"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "68.00"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery on checkout page
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "US" site
    Then Afterpay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "18.63"
    And in BM last order for "Thomas" is:
      | order_status | adyen_status| eventcode     | authResult   |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @guest @hd @shipping_promo @afterpay
  Scenario: Checkout with guest user and afterpay, HD with shipping promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 3   |
    And the price of product before any promotion is "509.97"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "514.97"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "US" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "38.25"
    And in BM last order for "Robert" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @guest @hd @threshold @afterpay
  Scenario: Checkout with guest user and afterpay, HD, Afterpay not available when order total is below lower threshold
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state   |
      |COG   | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
    |error_msg|
    |Afterpay is only available on orders above US$35.00|
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay" 
    And customer will land on the checkout page with "HD" details and the error message "Afterpay is only available on orders above US$35.00"

  @guest @hd @threshold @afterpay
  Scenario: Checkout with guest user and afterpay, HD, Afterpay not available when order total is above upper threshold
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 6   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is only available on orders under US$1,000.00|
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay" 
    And customer will land on the checkout page with "HD" details and the error message "Afterpay is only available on orders under US$1,000.00"

  @guest @hd @afterpay
  Scenario: Verify the Afterpay checkout text with international shipping address and afterpay as a guest user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state   |
      |COG   | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "GB" international delivery address
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is not available for delivery and billing addresses outside of United States|

  @registered @hd @afterpay
  Scenario: Verify the Afterpay checkout text with international shipping address and afterpay as a registered user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in   |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "GB" international delivery address
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is not available for delivery and billing addresses outside of United States|