@adyen_checkout @uk
Feature: Checkout - Adyen - COG-UK

  As a user I want to check out using a credit card where Adyen is the payment provider
  In UK, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|
  | 9351785496894 | Y     | 12.00 |11.00                  |4.80          |
  | 9351785092140 | N     | 12.00 |NA                     |NA            |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get £1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get £1 discount on shipping where applies
  default shipping is £4
  Particular card details cause approve or reject
  Assume configured payment method is Adyen
  HD is £20

  @valid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen approves
    Given I am on country "UK"
    And site is "COG"
    And an user "Tony"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.67"
    And in BM last order for "Tony" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @product_promo @hd
  Scenario: Checkout with guest user and credit card, HD, product promotion, Adyen accepts
    Given I am on country "UK"
    And site is "COG"
    And an user "Tony"
    And a bag with products:
      | sku           | qty |
      | 9351785496894 | 1   |
    And the price of product before any promotion is "12.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.00"
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
    And tax amount is "2.50"

  @valid @guest @order_promo @hd
  Scenario: Checkout with guest user and credit card, HD, order promotion, Adyen accepts
    Given I am on country "UK"
    And site is "COG"
    And an user "Tony"
    And a bag with products:
      | sku           | qty |
      | 9351785496894 | 2   |
    And the price of product before any promotion is "24.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "4.80"
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
    And tax amount is "3.87"

  @valid @guest @shipping_promo @hd
  Scenario: Checkout with guest user and credit card, HD, shipping promotion, Adyen accepts
    Given I am on country "UK"
    And site is "COG"
    And an user "Tony"
    And a bag with products:
      | sku           | qty |
      | 9351785496894 | 3   |
    And the price of product before any promotion is "36.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "39.00"
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
    And tax amount is "6.50"

  @valid @registered @hd
  Scenario: Checkout with registered user and credit card, Adyen approves
    Given I am on country "UK"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Alec"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | DEFAULT            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.67"

  @valid @registered @product_promo @hd
  Scenario: Checkout with registered user and credit card, HD, product promotion, Adyen accepts
    Given I am on country "UK"
    And site is "COG"
    And an user "Alec"
    And a bag with products:
      | sku           | qty |
      | 9351785496894 | 1   |
    And the price of product before any promotion is "12.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.50"

  @valid @registered @order_promo @hd
  Scenario: Checkout with registered user and credit card, HD, order promotion, Adyen accepts
    Given I am on country "UK"
    And site is "COG"
    And an user "Alec"
    And a bag with products:
      | sku           | qty |
      | 9351785496894 | 2   |
    And the price of product before any promotion is "24.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "4.80"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | DEFAULT       |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.87"

  @valid @registered @shipping_promo @hd
  Scenario: Checkout with registered user and credit card, HD, shipping promotion, Adyen accepts
    Given I am on country "UK"
    And site is "COG"
    And an user "Alec"
    And a bag with products:
      | sku           | qty |
      | 9351785496894 | 3   |
    And the price of product before any promotion is "36.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "39.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | DEFAULT            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "DEFAULT" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "6.50"

  @invalid @guest
  Scenario: Checkout with guest and credit card, Adyen rejects
    Given I am on country "UK"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Tony"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then "invalid_cvc" error message is displayed for the "HD" order as "Sorry there has been a problem with your payment and your order could not be placed (CVC Declined). Please check your details or try a different payment method if the problem persists."
    And user is redirected to refused single page checkout url
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user places an order
#    And customer will land on the checkout page with "DEFAULT" details and the error message "We're sorry, your payment has been declined."
    And in BM last order for "Tony" is:
      | order_status | adyen_status|eventcode     | authResult |
      | FAILED       | REFUSED     |AUTHORISATION | REFUSED    |

  @outline @invalid @guest
  Scenario Outline: Checkout with guest and credit card, error code checks
    Given I am on country "UK"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Tony"
    And the adyen HPP holderName is <response_codes>
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then based on the <response_codes>, error message is displayed for the "HD" order
    And user is redirected to refused single page checkout url
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user places an order
#    And customer will land on the checkout page with "DEFAULT" details and the error message "We're sorry, your payment has been declined."
    And in BM last order for "Tony" is:
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
      #| DECLINED     |
      #| INVALID_AMOUNT|
      #| NOT_SUPPORTED |
      #| NOT_ENOUGH_BALANCE  |


# Following scenarios became redundant after single page checkout release
#  @invalid @guest
#  Scenario: Checkout with guest and credit card, user cancels from top back button
#    Given I am on country "UK"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Tony"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | DEFAULT            |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Top Back"
#    Then user is taken back to checkout page with "DEFAULT" details
#    And in BM last order for "Tony" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED  |
#
#  @invalid @registered
#  Scenario: Checkout with registered and credit card, user cancels from bottom back button
#    Given I am on country "UK"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Alec"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | registered | house   | DEFAULT       |
#    And user selects the payment type as "adyen_valid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Bottom Back"
#    Then user is taken back to checkout page with "DEFAULT" details
#    And in BM last order for "Alec" is:
#      | order_status | adyen_status  |eventcode     | authResult |
#      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED  |
#
#  @invalid @guest
#     #need to code the BM part later as the response url on checkout lacks the order number
#  Scenario: Checkout with guest and credit card, user cancels from browser back button
#    Given I am on country "UK"
#    And site is "COG"
#    And cart is "Standard cart"
#    And an user "Tony"
#    When user checks out with details:
#      | user_type  | address | delivery_type |
#      | guest | house   | DEFAULT            |
#    And user selects the payment type as "adyen_invalid_creditcard"
#    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
#    And on adyen HPP user selects "Browser Back"
#    Then user is taken back to checkout page with "DEFAULT" details if browser back it hit
#    #And in BM last order for "Tony" is:
#    #  | status | eventcode | authResult |
#    #  | FAILED | CANCELLED | CANCELLED |
