@afterpay_checkout @nz
Feature: Afterpay- COG-NZ

  As a user I want to check out using afterpay
  In NZ, we have these products
  | sku          | promo_type                                           | price |product_promotion_price|order_discount|
  | 140122-02    | Y(product,order and shipping)                        | 29.99 |28.99                  |12.00         |
  |9351785565019 | NA                                                   |129.99 | NA                    | NA           |

  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9

  @registered @hd @product_promo @afterpay
  Scenario: Checkout with registered user and afterpay, HD with product promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | NZ      | Bob    | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku       | qty |
      | 140122-02 | 1   |
    And the price of product before any promotion is "29.99"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "28.99"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "NZ" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "4.56"
    And in BM last order for "Bob" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @registered @cnc @order_promo @afterpay
  Scenario: Checkout with registered user and afterpay, CNC with order promotion
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state |
      | COG  | NZ      | Bob  | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku       | qty |
      | 140122-02 | 2   |
    And the price of product before any promotion is "59.98"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "12.00"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery on checkout page
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "NZ" site
    Then Afterpay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "6.26"
    And in BM last order for "Bob" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @guest @hd @shipping_promo @afterpay
  Scenario: Checkout with guest user and afterpay, HD with shipping promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |NZ       |Robin   | guest        |sign-in       |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 140122-02 | 3   |
    And the price of product before any promotion is "89.97"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "94.97"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "NZ" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "12.39"
    And in BM last order for "Robin" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @guest @hd @threshold @afterpay
  Scenario: Checkout with guest user and afterpay, HD, Afterpay not available when order total
  is above upper threshold
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |NZ       |Robin   | guest        |sign-in       |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785565019 | 9   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the error message text on "afterpay" tab is:
      |error_msg|
      |Afterpay is only available on orders under NZ$1,000.00|
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay" 
    And customer will land on the checkout page with "HD" details and the error message "Afterpay is only available on orders under NZ$1,000.00"