#need to debug and fix the promotion issue
#@adyen_checkout @us
Feature: Checkout - Adyen - COG-US

  As a user I want to check out using a credit card where Adyen is the payment provider
  In US, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|
  | 130664        | Y     | 12.99 |11.99                  |5.20          |
  | 9351785092140 | N     | 49.99 |NA                     |NA            |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $6
  Particular card details cause approve or reject
  Assume configured payment method is Adyen
  HD is $20, cnc is $3

  @valid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in|
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.75"

  @valid @guest @cnc
  Scenario: Checkout with guest and credit card, CNC Adyen approves
    Given I am on country "US"
    And site is "COG"
    And an user "Thomas"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.42"

  @valid @guest @product_promo @cnc
  Scenario: Checkout with guest user and credit card, CNC, product promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Thomas"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And the price of product before any promotion is "12.99"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.99"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "0.82"

  @valid @guest @order_promo @cnc
  Scenario: Checkout with guest user and credit card, CNC, order promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Thomas"
    And a bag with products:
      | sku    | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.98"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.20"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.42"

  @valid @guest @shipping_promo @hd
  Scenario: Checkout with guest user and credit card, HD, shipping promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Thomas"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.97"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.97"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.92"

  @valid @registered @hd
  Scenario: Checkout with registered user and credit card, Adyen approves
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Robert"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.75"

  @valid @registered @product_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, product promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Robert"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And the price of product before any promotion is "12.99"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.99"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "0.82"

  @valid @registered @order_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, order promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Robert"
    And a bag with products:
      | sku    | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.98"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.20"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.42"

  @valid @registered @order_promo @hd
  Scenario: Checkout with registered user and credit card, HD, order promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Robert"
    And a bag with products:
      | sku    | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.98"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.20"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.56"

  @valid @registered @shipping_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, shipping promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Robert"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.97"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.97"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.67"

  @valid @guest @shipping_promo @cnc
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion, Adyen accepts
    Given I am on country "US"
    And site is "COG"
    And an user "Thomas"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.97"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.97"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.67"

  @invalid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen rejects
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Thomas"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then "invalid_cvc" error message is displayed for the "HD" order as "Sorry there has been a problem with your payment and your order could not be placed (CVC Declined). Please check your details or try a different payment method if the problem persists."
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user places an order
#    And customer will land on the checkout page with "HD" details and the error message "We're sorry, your payment has been declined."
    And in BM last order for "Thomas" is:
      | order_status | adyen_status | eventcode     | authResult |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    |

  @outline @invalid @guest @hd
  Scenario Outline: Checkout with guest and credit card, error code checks
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Thomas"
    And the adyen HPP holderName is <response_codes>
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then based on the <response_codes>, error message is displayed for the "HD" order
    And user is redirected to refused single page checkout url
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user places an order
#    And customer will land on the checkout page with "HD" details and the error message "We're sorry, your payment has been declined."
    And in BM last order for "Thomas" is:
      | order_status | adyen_status | eventcode     | authResult |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    |


    Examples:
      | response_codes |
      #| INVALID_CARD  |
      #| NOT_3D_AUTHENTICATED|
      #| REFERRAL     |
      #| ERROR        |
      | BLOCK_CARD   |
      | CARD_EXPIRED |
      | DECLINED     |
      #| INVALID_AMOUNT|
      #| NOT_SUPPORTED |
      #| NOT_ENOUGH_BALANCE  |

  # Following scenarios became redundant after single page checkout release
#  @invalid @guest @hd
#  Scenario: Checkout with guest and credit card, user cancels from top back button
#    Given I am on country "US"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Thomas"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | HD            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Top Back"
#    Then user is taken back to checkout page with "HD" details
#    And in BM last order for "Thomas" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |
#
#
#  @invalid @registered @cnc
#  Scenario: Checkout with registered and credit card, user cancels from bottom back button
#    Given I am on country "US"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Robert"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | CNC            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "registered" user fills in billing address details for "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Bottom Back"
#    Then user is taken back to checkout page with "click&collect" details
#    And in BM last order for "Robert" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |
#
#  @invalid @registered @cnc
#     #need to code the BM part later as the response url on checkout lacks the order number
#  Scenario: Checkout with guest and credit card, user cancels from browser back button
#    Given I am on country "US"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Thomas"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | HD            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Browser Back"
#    Then user is taken back to checkout page with "HD" details if browser back it hit
##    And in BM last order for "Thomas" is:
##      | status | eventcode | authResult |
##      | FAILED | CANCELLED | CANCELLED |



