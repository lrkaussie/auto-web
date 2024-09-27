@klarna
Feature: Checkout - Klarna - COG-US

  As a user I want to verify perks points calculation on the CO page for US site with sales tax
  In US, we have these products
  | sku           | promo | price | Size |
  | 9351533812327 | N     | 19.99 | NA   |
  | 9352855089992 | N     | 20.00 | NA   |
  | 9351785586540 | Y     | 5.00  | M    |
  | 9351785092140 | N     | 49.99 | NA   |

  @klarna
  Scenario: Checkout with klarna as a guest user with normal product for an approved order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "klarna"
    And the first installment amount for klarna is "US$11.97" on "US" site
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    And on "US" klarna page "guest" user places an order of "$47.89"
    Then "klarna" Thankyou page is shown with details for the user
    And in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |

  Scenario: Verify the approved order for klarna as a registered user with international delivery and national billing addresses
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | US      | Robert | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "AU" international delivery address
    And "registered" user fills in billing address details for "klarna"
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    And on "US" klarna page "guest" user places an order of "$68.97"
    Then "klarna" Thankyou page is shown with details for the user
    And in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |

  Scenario: Checkout with klarna as a registered user, CNC with order promotion
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
    When "registered" user fills in details for "cnc" delivery
    And "registered" user fills in billing address details for "klarna"
    And the first installment amount for klarna is "US$73.16" on "US" site
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    And on "US" klarna page "registered" user places an order of "$292.61"
    Then "klarna" Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the klarna Thankyou page
    And tax amount is "18.63"
    And in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |

  Scenario: Checkout with klarna as a registered user, CNC order with mixed cart, order promotion and voucher
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state  |
      | COG  | US      | Steve | registered   | sign-in      | logged_in   |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 2   |
      | 5555555555011 | 1   |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty |
      | 9351785454856 |  1  |
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "68.00"
    And user selects to checkout from their bag
    When promo or voucher is applied on the Checkout page
      | promos_vouchers  |
      | 9500150120702065 |
    Then the "order" discount applied is "76.28"
    And "registered" user fills in details for "cnc" delivery
    And "registered" user fills in billing address details for "klarna"
    And the first installment amount for klarna is "US$85.90" on "US" site
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    And on "US" klarna page "registered" user places an order of "$343.60"
    And "klarna" Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the klarna Thankyou page
    And tax amount is "21.90"
    And in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |

  Scenario: Checkout with guest, multipack and credit card, Klarna approves
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |US     |Thomas|guest       |sign-in            |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 5555555555011 | 1   |
      | 4444444444011 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "klarna"
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    And on "US" klarna page "guest" user places an order of "$81.25"
    Then "klarna" Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the klarna Thankyou page
    And tax amount is "5.25"
    And in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |

  Scenario: Verify the error for klarna as a guest user with national delivery and international billing addresses
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing details for "klarna" with "AU" international address
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    Then user sees the global error message:
      | error_message |
      | Klarna is not available for billing addresses outside of United States |

  Scenario: Verify the error for klarna as a guest user with international delivery and billing addresses
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "AU" international delivery address
    And "guest" user fills in billing details for "klarna" with "AU" international address
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    Then user sees the global error message:
      | error_message |
      | Klarna is not available for billing addresses outside of United States |

  Scenario: Verify the error of maximum threshold amount for klarna as a registered user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    When a bag with products:
      | sku           | qty |
      | 9351785440088 | 10  |
      | 9351785144559 | 2   |
    And user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "klarna"
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    Then user sees the global error message:
      | error_message |
      | Klarna is only available on orders under US$1,500.00 |

  Scenario: Verify the error of minimum threshold amount for klarna as a guest user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    When a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "klarna"
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    Then user sees the global error message:
      | error_message |
      | Klarna is only available on orders above US$35.00 |

  Scenario: Verify that klarna is not available when egift card is tehre in the cart
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "9354233659087"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    When a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    Then klarna should not be available on CO page

  Scenario: Verify back scenario with klarna as a guest user with normal product for a failed order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And user selects the payment type as "klarna"
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    When user clicks on back button on klarna hpp
    Then in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction |
      | FAILED              | KLARNA_PAYMENTS  | Transaction        |

  Scenario: Verify denied scenario with klarna as a guest user with normal product for a failed order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects to checkout from their bag
    When "guest" user with "home" delivery fills in details for a klarna declined order
    And user selects the payment type as "klarna"
    And the user clicks Continue to Payment button on the Checkout page of "US" site for klarna
    And on "US" klarna page "guest" user places a declined order of "$47.89"
    Then user sees the global error message:
      | error_message |
      | Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience! |
    And in BM last klarna order for "Robert" is:
      | klarna_order_status | klarna_processor | klarna_transaction |
      | FAILED              | KLARNA_PAYMENTS  | Transaction        |