@adyen_checkout @sa
Feature: Checkout - Adyen - COG-SA

  As a user I want to check out using a credit card where Adyen is the payment provider
  In SA, we have these products
  | sku           | promo | price  | product_promotion_price | order_discount |
  | 9351533868874 | Y     | 199.00 | 198.00                  | 79.60          |
  | 9352403649715 | N     | 89.00  | NA                      | NA             |
  | 2063046999910 | N     | 89.00  | NA                      | NA             |
  | 9351533834022 | Y     | 199.00 | NA                      | NA             |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get R1 discount on shipping where applies
  default shipping is R50
  Particular card details cause approve or reject
  Assume configured payment method is adyen
  HD is R50


  @valid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen approves
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
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
    And tax amount is "18.13"
    And in BM last order for "Junior" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @valid @guest @cnc
  Scenario: Checkout with guest and credit card, CNC Adyen approves
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
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
    And tax amount is "14.22"
    And in BM last order for "Junior" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @valid @registered @hd
  Scenario: Checkout with registered user and credit card, Adyen approves
    Given I am on country "SA"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Neil"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "18.13"
    And in BM last order for "Neil" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @invalid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen rejects
    Given I am on country "SA"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Junior"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then "invalid_cvc" error message is displayed for the "HD" order as "Sorry there has been a problem with your payment and your order could not be placed (CVC Declined). Please check your details or try a different payment method if the problem persists."
    And user is redirected to refused single page checkout url
    And in BM last order for "Junior" is:
      | order_status | adyen_status|eventcode     | authResult |
      | FAILED       | REFUSED     |AUTHORISATION | REFUSED    |

  @outline @invalid @guest @hd
  Scenario Outline: Checkout with guest and credit card, error code checks
    Given I am on country "SA"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Junior"
    And the adyen HPP holderName is <response_codes>
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then based on the <response_codes>, error message is displayed for the "HD" order
    And user is redirected to refused single page checkout url
    And in BM last order for "Junior" is:
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

  # NEED TO SET UP  THE BELOW SCRIPTS BUT ALSO NOT REQUIRED AS ABOVE COVERS THE SANITY on ZA AND ALSO COMPLETE TESTING IS DONE ON AU AND US FOR SAME PAYMENT METHOD.

#  @valid @guest @product_promo @cnc
#  Scenario: Checkout with guest user and credit card, CNC, product promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Junior"
#    And a bag with products:
#      | sku           | qty |
#      | 9351533868874 | 1   |
#    And the price of product before any promotion is "199.00"
#    And promo code added on bag "autotest_product"
#    And the price of product after product promotion applied is "198.00"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type | address | delivery_type |
#      | guest     | house   | CNC           |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "guest" user fills in billing address details for "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "CNC" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "25.83"
#    And in BM last order for "Junior" is:
#      | order_status | adyen_status| eventcode     | authResult |
#      | NEW          | APPROVED    | AUTHORISATION | NA         |
#
#  @valid @guest @order_promo @cnc
#  Scenario: Checkout with guest user and credit card, CNC, order promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Junior"
#    And a bag with products:
#      | sku       | qty |
#      | 9351533868874 | 2   |
#    And the price of product before any promotion is "398.00"
#    And promo code added on bag "autotest_order"
#    And the discount price after order promotion applied is "79.60"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type | address | delivery_type |
#      | guest     | house   | CNC           |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "guest" user fills in billing address details for "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "CNC" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "41.53"
#    And in BM last order for "Junior" is:
#      | order_status | adyen_status| eventcode     | authResult |
#      | NEW          | APPROVED    | AUTHORISATION | NA         |
#
#  @valid @guest @shipping_promo @hd
#  Scenario: Checkout with guest user and credit card, HD, shipping promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Junior"
#    And a bag with products:
#      | sku       | qty |
#      | 9351533868874 | 3   |
#    And the price of product before any promotion is "597.00"
#    And promo code added on bag "autotest_shipping"
#    And the price of product after shipping promotion applied is "646.00"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type | address | delivery_type |
#      | guest     | house   | HD            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "HD" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "84.26"
#    And in BM last order for "Junior" is:
#      | order_status | adyen_status| eventcode     | authResult |
#      | NEW          | APPROVED    | AUTHORISATION | NA         |

#  @valid @registered @product_promo @cnc
#  Scenario: Checkout with registered user and credit card, CNC, product promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Neil"
#    And a bag with products:
#      | sku           | qty |
#      | 9351533868874 | 1   |
#    And the price of product before any promotion is "199.00"
#    And promo code added on bag "autotest_product"
#    And the price of product after product promotion applied is "198.00"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | CNC           |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "registered" user fills in billing address details for "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "CNC" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "25.83"
#    And in BM last order for "Neil" is:
#      | order_status | adyen_status | eventcode     | authResult |
#      | NEW          | APPROVED     | AUTHORISATION | NA         |
#
#  @valid @registered @order_promo @cnc
#  Scenario: Checkout with registered user and credit card, CNC, order promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Neil"
#    And a bag with products:
#      | sku           | qty |
#      | 9351533868874 | 2   |
#    And the price of product before any promotion is "398.00"
#    And promo code added on bag "autotest_order"
#    And the discount price after order promotion applied is "79.60"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | CNC           |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "registered" user fills in billing address details for "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "CNC" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "41.53"
#    And in BM last order for "Neil" is:
#      | order_status | adyen_status | eventcode     | authResult |
#      | NEW          | APPROVED     | AUTHORISATION | NA         |
#
#  @valid @registered @order_promo @hd
#  Scenario: Checkout with registered user and credit card, HD, order promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Neil"
#    And a bag with products:
#      | sku           | qty |
#      | 9351533868874 | 2   |
#    And the price of product before any promotion is "398.00"
#    And promo code added on bag "autotest_order"
#    And the discount price after order promotion applied is "79.60"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | HD            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "HD" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "48.05"
#    And in BM last order for "Neil" is:
#      | order_status | adyen_status | eventcode     | authResult |
#      | NEW          | APPROVED     | AUTHORISATION | NA         |
#
#  @valid @registered @shipping_promo @cnc
#  Scenario: Checkout with registered user and credit card, CNC, shipping promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Neil"
#    And a bag with products:
#      | sku           | qty |
#      | 9351533868874 | 3   |
#    And the price of product before any promotion is "597.00"
#    And promo code added on bag "autotest_shipping"
#    And the price of product after shipping promotion applied is "646.00"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | CNC           |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "registered" user fills in billing address details for "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "CNC" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "77.87"
#    And in BM last order for "Neil" is:
#      | order_status | adyen_status | eventcode     | authResult |
#      | NEW          | APPROVED     | AUTHORISATION | NA         |
#
#  @valid @guest @shipping_promo @cnc
#  Scenario: Checkout with guest user and credit card, CNC, shipping promotion, Adyen accepts
#    Given I am on country "SA"
#    And site is "COG"
#    And an user "Junior"
#    And a bag with products:
#      | sku           | qty |
#      | 9351533868874 | 3   |
#    And the price of product before any promotion is "597.00"
#    And promo code added on bag "autotest_shipping"
#    And the price of product after shipping promotion applied is "646.00"
#    And checkout button is pressed
#    When user checks out with details:
#      | user_type | address | delivery_type |
#      | guest     | house   | CNC           |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "guest" user fills in billing address details for "adyen_valid_creditcard"
#    And the user enters adyen details for "Credit Card" for single page checkout form
#    And the user places order on the Checkout page for "Credit Card"
#    Then Adyen Thankyou page is shown for the SPC with details for the user
#    And "CNC" delivery address is shown on the Adyen Thankyou page
#    And placed order total is verified and payment type is "Credit Card"
#    And tax amount is "77.87"
#    And in BM last order for "Junior" is:
#      | order_status | adyen_status | eventcode     | authResult |
#      | NEW          | APPROVED     | AUTHORISATION | NA         |

#  @invalid @guest @hd
#  Scenario: Checkout with guest and credit card, user cancels from top back button
#    Given I am on country "SA"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Junior"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | HD            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Top Back"
#    Then user is taken back to checkout page with "HD" details
#    And in BM last order for "Junior" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |
#
#  @invalid @registered @cnc
#  Scenario: Checkout with registered and credit card, user cancels from bottom back button
#    Given I am on country "SA"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Neil"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | CNC            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And "registered" user fills in billing address details for "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Bottom Back"
#    Then user is taken back to checkout page with "CNC" details
#    And in BM last order for "Neil" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |
#
#  @invalid @guest @hd
#     #need to code the BM part later as the response url on checkout lacks the order number
#  Scenario: Checkout with guest and credit card, user cancels from browser back button
#    Given I am on country "SA"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Junior"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | HD            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Browser Back"
#    Then user is taken back to checkout page with "HD" details if browser back it hit
#    #And in BM last order for "Junior" is:
#    #  | status | eventcode | authResult |
#    #  | FAILED | CANCELLED | CANCELLED |



