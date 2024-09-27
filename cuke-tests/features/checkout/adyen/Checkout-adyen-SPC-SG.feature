@adyen_checkout @single-page_checkout
Feature: Checkout - Adyen - SPC - COG-SG

  As a user I want to check out using a credit card where Adyen is the payment provider
  In SG, we have these products
  | sku           | promo     | price | product_promotion_price | order_discount             | shipping_discount                            |
  | 9351785572260 |           | 44.95 |                         |                            |                                              |
  | 9350486078750 |  Y        | 29.95 | 28.95                   | 47.92(on buying 2 of this) |                                              |
  | 9351533642344 |  Y        | 11.99 |                         |                            | $1 off on shipping price on buying 3 of this |
  | 5555555555011 | Multipack | 90.00 | SAVE $9.85 off RRP      |                            |                                              |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $5
  Particular card details cause approve or reject
  Assume configured payment method is Adyen
  HD is $5, cnc is $2

  @guest @hd
  Scenario: Checkout with guest and credit card, Adyen approves for Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @cnc
  Scenario: Checkout with guest, multipack product and credit card, CNC Adyen approves for Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 5555555555011 |  1  |
    And the order total in the Order Summary section on My Bag page is "80.00"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.36"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @cnc
  Scenario: Checkout with guest user and credit card, CNC, product promotion, Adyen accepts for Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486078750 | 1   |
    And the price of product before any promotion is "29.95"
    And the order total in the Order Summary section on My Bag page is "34.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "28.95"
    And the order total in the Order Summary section on My Bag page is "33.95"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.02"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @cnc
  Scenario: Checkout with guest user and credit card, CNC, order promotion, Adyen accepts for Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486078750 | 2   |
    And the price of product before any promotion is "59.90"
    And the order total in the Order Summary section on My Bag page is "59.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "11.98"
    And the order total in the Order Summary section on My Bag page is "52.92"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @hd
  Scenario: Checkout with guest user and credit card, HD, shipping promotion, Adyen accepts for Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And the price of product before any promotion is "35.97"
    And the order total in the Order Summary section on My Bag page is "40.97"
    And promo code added on bag "autotest_shipping"
    And the order total in the Order Summary section on My Bag page is "39.97"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.61"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @cnc
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion, Adyen accepts for Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And the price of product before any promotion is "35.97"
    And the order total in the Order Summary section on My Bag page is "40.97"
    And promo code added on bag "autotest_shipping"
    And the order total in the Order Summary section on My Bag page is "39.97"
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.41"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @cnc
  Scenario: Checkout with guest and 3DS credit card, Adyen approves CNC order with Single Page Checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 |  1  |
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_3DS_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user enters the password as "password"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.07"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode     | authResult | 3ds_status      |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | threeDS2 : true |

  @guest @hd @invalid
  Scenario: Checkout with guest and credit card, Adyen rejects for invalid CVC for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then "invalid_cvc" error message is displayed for the "HD" order as "Sorry there has been a problem with your payment and your order could not be placed (CVC Declined). Please check your details or try a different payment method if the problem persists."
    And user is redirected to refused single page checkout url
    And in BM last order for "Don" is:
      | order_status | adyen_status|eventcode     | authResult |
      | FAILED       | REFUSED     |AUTHORISATION | REFUSED    |

  @outline @invalid @guest @hd
  Scenario Outline: Checkout with guest and credit card, error code checks for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And the adyen HPP holderName is <response_codes>
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then based on the <response_codes>, error message is displayed for the "HD" order
    And user is redirected to refused single page checkout url
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode     | authResult |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    |


    Examples:
      | response_codes       |
      | BLOCK_CARD           |
#      | CANCELLED            |
#      | CARD_EXPIRED         |
#      | REFERRAL             |
#      | NOT_3D_AUTHENTICATED |
#      | NOT_ENOUGH_BALANCE   |
#      | NOT_SUPPORTED        |

  @invalid @guest @hd
  Scenario: Checkout with guest and 3DS credit card, error code checks for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_3DS_invalid_error" for response code as "UNKNOWN"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user enters the password as "password"
    Then based on the "UNKNOWN", error message is displayed for the "HD" order
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode     | authResult | authResult_3DS |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    | Acquirer Error |

  @guest @hd
  Scenario: Checkout with guest and 3DS credit card, browser back from 3DS with single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_3DS_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user clicks browser back
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode | authResult | authResult_3DS | 3ds             |
      | FAILED       | CANCELLED    | CANCELLED |            | ACCEPT         | threeDS2 : true |

  @guest @hd
  Scenario: Checkout with guest user with UK address and credit card, Adyen approves for single page checkout
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUkuser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "4.31"
    And in BM last order for "SGUkuser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @guest @hd
  Scenario: Checkout with guest user with JP address and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGJPuser | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "4.31"
    And in BM last order for "SGJPuser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @chinesechar @hd
  Scenario: Attempt to checkout with guest user with Chinese characters address and credit card with single page checkout
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGChina | guest        | home-page    | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And user navigates to "checkout" page
    And "guest" enters details in signin section
    And user enters "first_name" in contact details
    Then I validate the error message "Sorry! The characters entered are not supported."
    And user enters "last_name" in contact details
    And I validate the error message "Sorry! The characters entered are not supported."
    And user enters "phone_number" in contact details
    And user enters the details for the following combination:
      | delivery_type | address | error_message                                    |
      | HD            | house   | Sorry! The characters entered are not supported. |
    And user enters the following payment information:
      | payment_type | error_message                                    |
      | credit_card  | Sorry! The characters entered are not supported. |

  @guest @hd
  Scenario: Checkout with guest and credit card, review error code checks for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | SG      | SGUser | guest        | sign-in      | not_logged_in |
    And the adyen HPP holderName is "Review123"
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | REVIEW       | AUTHORISATION | NA         |

  @registered @hd
  Scenario: Checkout with registered user and credit card, Adyen approves with single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @product_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, product promotion, Adyen accepts for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9350486078750 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the price of product before any promotion is "29.95"
    And the order total in the Order Summary section on My Bag page is "34.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "28.95"
    And the order total in the Order Summary section on My Bag page is "33.95"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.02"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @order_promo @cnc @smoke_test
  Scenario: Checkout with registered user and credit card, CNC, order promotion, Adyen accepts for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9350486078750 | 2   |
    And user selects the "Next Day" shipping method on bag page
    And the price of product before any promotion is "59.90"
    And the order total in the Order Summary section on My Bag page is "59.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "11.98"
    And the order total in the Order Summary section on My Bag page is "52.92"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @order_promo @hd
  Scenario: Checkout with registered user and credit card, HD, order promotion, Adyen accepts for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9350486078750 | 2   |
    And user selects the "Next Day" shipping method on bag page
    And the price of product before any promotion is "59.90"
    And the order total in the Order Summary section on My Bag page is "59.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "11.98"
    And the order total in the Order Summary section on My Bag page is "52.92"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.47"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @shipping_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, shipping promotion, Adyen accepts for single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And user selects the "Next Day" shipping method on bag page
    And the price of product before any promotion is "35.97"
    And the order total in the Order Summary section on My Bag page is "40.97"
    And promo code added on bag "autotest_shipping"
    And the order total in the Order Summary section on My Bag page is "39.97"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.41"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @ukaddress @hd
  Scenario: Checkout with registered user with UK address and credit card, Adyen approves for single page checkout
#    same billing and shipping address
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state |
      | COG  | SG      | SGUkuser | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "4.90"
    And in BM last order for "SGUkuser" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @jpaddress @hd
  Scenario: Checkout with registered user with JP address and credit card, Adyen approves for single page checkout
    #    same billing and shipping address
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state |
      | COG  | SG      | SGJPuser | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "4.90"
    And in BM last order for "SGJPuser" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @registered @hd
  Scenario: Checkout with registered user and 3DS credit card, Adyen approves HD order with single page checkout
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_3DS_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user enters the password as "password"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode     | authResult | 3ds_status      |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | threeDS2 : true |

  @invalid @registered @hd
  Scenario: Checkout with registered and 3DS credit card, error code checks for single page checkout(ERROR)
    Given I log on to the site with the following:
      | site | country | user        | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGerrorUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_3DS_invalid_error" for response code as "ERROR"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user enters the password as "password"
    Then based on the "ERROR", error message is displayed for the "HD" order
    And in BM last order for "SGerrorUser" is:
      | order_status | adyen_status | eventcode     | authResult | authResult_3DS |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    | Acquirer Error |

  @invalid @registered @hd
  Scenario: Checkout with registered and 3DS credit card, error code checks for single page checkout(DECLINED)
    Given I log on to the site with the following:
      | site | country | user        | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGerrorUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_3DS_invalid_error" for response code as "DECLINED"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user enters the password as "password"
    Then based on the "DECLINED", error message is displayed for the "HD" order
    And in BM last order for "SGerrorUser" is:
      | order_status | adyen_status | eventcode     | authResult | authResult_3DS |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    | Refused        |

  @registered @hd
  Scenario: Checkout with registered and 3DS credit card, browser back from 3DS with single page checkout
    Given I log on to the site with the following:
      | site | country | user        | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGerrorUser | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351533642344 | 3   |
    And checkout button is pressed
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_3DS_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    And on 3DS page user clicks browser back
    And in BM last order for "SGUser" is:
      | order_status | adyen_status | eventcode | authResult | authResult_3DS | 3ds             |
      | FAILED       | CANCELLED    | CANCELLED |            | ACCEPT         | threeDS2 : true |


  @registered @hd @savedcards
  Scenario: Checkout with registered user using saved credit card, Adyen approves with single page checkout
    Given I log on to the site with the following:
      | site | country | user        | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGsavedcard | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And user selects the saved card ending with "1111" on single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGsavedcard" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |


  @registered @hd @savedcards
  Scenario: Checkout with registered user using saved address and saved credit card, Adyen approves with single page checkout
    Given I log on to the site with the following:
      | site | country | user           | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGsavedaddcard | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    Then user changes to the address "2" from the saved delivery addresses for single page checkout
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user selects same as shipping checkbox for billing address
    And user selects the saved card ending with "1111" on single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with "second address" details for the user
    And "HD second" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGsavedaddcard" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @hd @savedcards
  Scenario: Checkout with registered user using new credit card and new add, Adyen approves with single page checkout
    Given I log on to the site with the following:
      | site | country | user           | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGsavedaddcard | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When registered user fills in details for home delivery by adding new address
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user selects same as shipping checkbox for billing address
    And user adds a new card on single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGsavedaddcard" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @hd @savedcards
  Scenario: Checkout with registered user using saved credit card and new add, Adyen approves with single page checkout
    Given I log on to the site with the following:
      | site | country | user           | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGsavedaddcard | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    When registered user fills in details for home delivery by adding new address
    And user selects the payment type as "adyen_valid_creditcard"
    And user selects the saved card ending with "1111" on single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGsavedaddcard" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  Scenario: Checkout with registered user using saved address and new credit card, Adyen approves with single page checkout
    Given I log on to the site with the following:
      | site | country | user           | type_of_user | landing_page | user_state | cart_page |
      | COG  | SG      | SGsavedaddcard | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects the "Next Day" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "49.95"
    And user selects to checkout from their bag
    Then user changes to the address "2" from the saved delivery addresses for single page checkout
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user selects same as shipping checkbox for billing address
    And user adds a new card on single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with "second address" details for the user
    And "HD second" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.27"
    And in BM last order for "SGsavedaddcard" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  Scenario: Verifying the deletion of one saved credit card with registered user and then checkout with single page checkout,Adyen approves
    Given I log on to the site with the following:
      | site | country | user         | type_of_user | landing_page | user_state |
      | COG  | SG      | SGdeletecard | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user selects same as shipping checkbox for billing address
    And user deletes the saved card ending with "1111" on single page checkout form
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Saving Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "SGdeletecard" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  Scenario: Verifying the deletion of one saved card out of two saved cards with registered user and then checkout with new card and single page checkout
    Given I log on to the site with the following:
      | site | country | user            | type_of_user | landing_page | user_state |
      | COG  | SG      | SGdelsavedcards | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785572260 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user selects same as shipping checkbox for billing address
    And user deletes the saved card ending with "1111" on single page checkout form
    And user adds a new card on single page checkout form
    And the user places order on the Checkout page for "Saving Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "SGdelsavedcards" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
