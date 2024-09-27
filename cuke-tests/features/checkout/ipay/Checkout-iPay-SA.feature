@sa
Feature: Checkout - ipay - COG-SA

  As a user I want to check out where ipay is the payment provider
  In SA, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|
  | 9351533868874 | Y     | 199.00 |198.00                |79.60         |
  | 8051795-02    | N     | 89.00  |NA                    |NA            |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get R1 discount on shipping where applies
  default shipping is R50
  Particular card details cause approve or reject
  Assume configured payment method is ipay
  HD is R50


  @valid @guest @hd @jenkins @ipay
  Scenario: Checkout with guest and ipay, ipay approves
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "18.13"
#    And in BM last order for "Junior" is:
#      | order_status | adyen_status| eventcode     | authResult |
#      | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @cnc @ipay
  Scenario: Checkout with guest and ipay, CNC ipay approves
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "11.61"
    #And in BM last order for "Junior" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @product_promo @cnc @ipay
  Scenario: Checkout with guest user and ipay, CNC, product promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 1   |
    And the price of product before any promotion is "199.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "198.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "25.83"
    #And in BM last order for "Junior" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @order_promo @cnc @ipay
  Scenario: Checkout with guest user and ipay, CNC, order promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 2   |
    And the price of product before any promotion is "398.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "79.60"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "41.53"
    #And in BM last order for "Junior" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @shipping_promo @hd @ipay
  Scenario: Checkout with guest user and ipay, HD, shipping promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 3   |
    And the price of product before any promotion is "597.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "646.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "84.26"
    #And in BM last order for "Junior" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @hd @ipay
  Scenario: Checkout with registered user and ipay, ipay approves
    Given I am on country "SA"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Neil"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "18.13"
    #And in BM last order for "Neil" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @product_promo @cnc @ipay
  Scenario: Checkout with registered user and ipay, CNC, product promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Neil"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 1   |
    And the price of product before any promotion is "199.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "198.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "25.83"
    #And in BM last order for "Neil" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @order_promo @cnc @ipay
  Scenario: Checkout with registered user and ipay, CNC, order promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Neil"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 2   |
    And the price of product before any promotion is "398.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "79.60"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "41.53"
    #And in BM last order for "Neil" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @order_promo @hd @ipay
  Scenario: Checkout with registered user and credit card, HD, order promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Neil"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 2   |
    And the price of product before any promotion is "398.00"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "79.60"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "48.05"
    #And in BM last order for "Neil" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @shipping_promo @cnc @ipay
  Scenario: Checkout with registered user and credit card, CNC, shipping promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Neil"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 3   |
    And the price of product before any promotion is "597.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "646.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "77.87"
    #And in BM last order for "Neil" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |


  @valid @guest @shipping_promo @cnc @ipay
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion, ipay accepts
    Given I am on country "SA"
    And site is "COG"
    And an user "Junior"
    And a bag with products:
      | sku       | qty |
      | 9351533868874 | 3   |
    And the price of product before any promotion is "597.00"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "646.00"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Successful Response"
    Then ipay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the ipay Thankyou page
    And placed order total is verified
    And payment type is "Bank Transfer"
    And tax amount is "77.87"
    #And in BM last order for "Junior" is:
    #  | order_status | adyen_status| eventcode     | authResult |
    #  | NEW          | APPROVED    | AUTHORISATION | NA         |

  @invalid @guest @hd @ipay
  Scenario: Checkout with guest and credit card, ipay cancels
    Given I am on country "SA"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Junior"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Cancelled Response"
    Then user is taken back from ipay page to the checkout page
    And I can see "HD" details for the user
    And in BM last order for "Junior" is:
      | order_status | adyen_status  |eventcode     | authResult |
      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |

  @invalid @registered @cnc @ipay
  Scenario: Checkout with registered and credit card, ipay cancels
    Given I am on country "SA"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Neil"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And order total is recorded
    And user selects the payment type as "ipay"
    And the user clicks Continue to Payment button on the Checkout page
    And user clicks on "Test Cancelled Response"
    Then user is taken back from ipay page to the checkout page
    And I can see "CNC" details for the user
    And in BM last order for "Neil" is:
      | order_status | adyen_status  |eventcode     | authResult |
      | FAILED       | CANCELLED     |CANCELLED     | CANCELLED    |
