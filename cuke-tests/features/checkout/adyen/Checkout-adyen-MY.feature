@adyen_checkout @my
Feature: Checkout - Adyen - COG-MY

  As a user I want to check out using a credit card where Adyen is the payment provider
  In MY, we have these products
  | sku           | promo | price  |product_promotion_price|order_discount|
  | 9351785509303 | Y     | 30.00  |29.00                  |12.00         |
  | 9351785092140 | N     | 149.00 |NA                     |NA            |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get RM1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get RM1 discount on shipping where applies
  default shipping is RM43
  Particular card details cause approve or reject
  Assume configured payment method is Adyen
  HD is RM43

  @valid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Adam" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @product_promo
  Scenario: Checkout with guest user and credit card, HD, product promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And the price of product before any promotion is "30.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "29.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Adam" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @order_promo @guest
  Scenario: Checkout with guest user and credit card, HD, order promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And the price of product before any promotion is "60.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "12.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Adam" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @shipping_promo
  Scenario: Checkout with guest user and credit card, HD, shipping promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "90.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "96.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Adam" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered
  Scenario: Checkout with registered user and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | MY      | Raja | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Raja" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @product_promo
  Scenario: Checkout with registered user and credit card, HD, product promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | MY      | Raja | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And the price of product before any promotion is "30.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "29.00"
    And checkout button is pressed
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Raja" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |


  @valid @registered @order_promo
  Scenario: Checkout with registered user and credit card, HD, order promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | MY      | Raja | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And the price of product before any promotion is "60.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "12.00"
    And checkout button is pressed
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Raja" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @shipping_promo
  Scenario: Checkout with registered user and credit card, HD, shipping promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | MY      | Raja | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "90.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "96.00"
    And checkout button is pressed
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Raja" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |


  @invalid @guest
  Scenario: Checkout with guest and credit card, Adyen rejects
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
#    And customer will land on the checkout page with "DEFAULT" details and the error message "We're sorry, your payment has been declined."
    Then "invalid_cvc" error message is displayed for the "HD" order as "Sorry there has been a problem with your payment and your order could not be placed (CVC Declined). Please check your details or try a different payment method if the problem persists."
    And user is redirected to refused single page checkout url
    And in BM last order for "Adam" is:
      | order_status | adyen_status | eventcode     | authResult |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    |

  @outline  @invalid @guest
  Scenario Outline: Checkout with guest and credit card, error code checks
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam | guest        | sign-in      | not_logged_in |
    And the adyen HPP holderName is <response_codes>
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then based on the <response_codes>, error message is displayed for the "HD" order
    And user is redirected to refused single page checkout url
    And in BM last order for "Adam" is:
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
  #  @invalid @guest
#  Scenario: Checkout with guest and credit card, user cancels from top back button
#    Given I log on to the site with the following:
#      | site | country | user   | type_of_user | landing_page | user_state  |
#      |COG   |MY       |Adam    |guest    | sign-in      | not_logged_in   |
#    And a bag with products:
#      | sku           | qty |
#      | 9351785092140 | 1   |
#    And user selects to checkout from their bag
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | DEFAULT            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Top Back"
#    Then user is taken back to checkout page with "DEFAULT" details
#    And in BM last order for "Adam" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |

#  @invalid @registered
#  Scenario: Checkout with registered and credit card, user cancels from bottom back button
#    Given I log on to the site with the following:
#      | site | country | user   | type_of_user | landing_page | user_state  |
#      |COG   |MY       |Raja    |guest    | sign-in      | not_logged_in   |
#    And a bag with products:
#      | sku           | qty |
#      | 9351785092140 | 1   |
#    And user selects to checkout from their bag
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | DEFAULT       |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Bottom Back"
#    Then user is taken back to checkout page with "DEFAULT" details
#    And in BM last order for "Raja" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |

#  @invalid @guest
#     #need to code the BM part later as the response url on checkout lacks the order number
#  Scenario: Checkout with guest and credit card, user cancels from browser back button
#    Given I log on to the site with the following:
#      | site | country | user   | type_of_user | landing_page | user_state  |
#      |COG   |MY       |Adam    |guest    | sign-in      | not_logged_in   |
#    And a bag with products:
#      | sku           | qty |
#      | 9351785092140 | 1   |
#    And user selects to checkout from their bag
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | DEFAULT            |
#    And user selects the payment type as "adyen_invalid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Browser Back"
#    Then user is taken back to checkout page with "DEFAULT" details if browser back it hit
#    #And in BM last order for "Robin" is:
#    #  | status | eventcode | authResult |
#    #  | FAILED | CANCELLED | CANCELLED |

