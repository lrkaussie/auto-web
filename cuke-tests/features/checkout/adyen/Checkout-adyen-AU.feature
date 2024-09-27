@adyen_checkout @au
Feature: Checkout - Adyen - COG-AU
  
  As a user I want to check out using a credit card where Adyen is the payment provider
  In AU, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|
  | 9351785509303 | Y     | 12.95 |11.95                  |5.18          |
  | 9351785092140 | N     | 49.99 |NA                     |NA            |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9
  Particular card details cause approve or reject
  Assume configured payment method is Adyen
  HD is $20, cnc is $3

  @jenkins @guest @hd
    Scenario: Checkout with guest and credit card, Adyen approves
      Given I log on to the site with the following:
        | site | country | user | type_of_user | landing_page | user_state    |
        | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
      And a bag with products:
        | sku           | qty |
        | 9351785092140 | 1   |
      And the order total in the Order Summary section on My Bag page is "55.99"
      And user selects to checkout from their bag
      When "guest" user fills in details for "home" delivery
      And user selects the payment type as "adyen_valid_creditcard"
      And "guest" user fills in billing address details for "adyen_valid_creditcard"
      And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
      And on adyen HPP user places an order
      Then Adyen Thankyou page is shown with details for the user
      And "HD" delivery address is shown on the Adyen Thankyou page
      And placed order total is verified and payment type is "Credit Card"
      And tax amount is "5.09"
      And in BM last order for "Don" is:
        | order_status | adyen_status | eventcode     | authResult |
        | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @guest @cnc
  Scenario: Checkout with guest and credit card, CNC Adyen approves
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 |  1  |
    And the order total in the Order Summary section on My Bag page is "55.99"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "4.54"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @guest @product_promo @cnc
  Scenario: Checkout with guest user and credit card, CNC, product promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And the price of product before any promotion is "12.95"
    And the order total in the Order Summary section on My Bag page is "18.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.95"
    And the order total in the Order Summary section on My Bag page is "17.95"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.09"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @guest @order_promo @cnc
  Scenario: Checkout with guest user and credit card, CNC, order promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And the price of product before any promotion is "25.90"
    And the order total in the Order Summary section on My Bag page is "31.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.18"
    And the order total in the Order Summary section on My Bag page is "26.72"
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.88"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @guest @shipping_promo @hd
  Scenario: Checkout with guest user and credit card, HD, shipping promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "38.85"
    And the order total in the Order Summary section on My Bag page is "44.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And the order total in the Order Summary section on My Bag page is "43.85"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.99"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @registered @hd
  Scenario: Checkout with registered user and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects the "standard" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "55.99"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.09"
    And in BM last order for "Mark" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @registered @product_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, product promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects the "standard" shipping method on bag page
    And the price of product before any promotion is "12.95"
    And the order total in the Order Summary section on My Bag page is "18.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.95"
    And the order total in the Order Summary section on My Bag page is "17.95"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.09"
    And in BM last order for "Mark" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @registered @order_promo @cnc @smoke_test
  Scenario: Checkout with registered user and credit card, CNC, order promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And user selects the "standard" shipping method on bag page
    And the price of product before any promotion is "25.90"
    And the order total in the Order Summary section on My Bag page is "31.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.18"
    And the order total in the Order Summary section on My Bag page is "26.72"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "1.88"
    And in BM last order for "Mark" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @registered @order_promo @hd
  Scenario: Checkout with registered user and credit card, HD, order promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And user selects the "standard" shipping method on bag page
    And the price of product before any promotion is "25.90"
    And the order total in the Order Summary section on My Bag page is "31.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.18"
    And the order total in the Order Summary section on My Bag page is "26.72"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "2.43"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @shipping_promo @cnc
  Scenario: Checkout with registered user and credit card, CNC, shipping promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And user selects the "standard" shipping method on bag page
    And the price of product before any promotion is "38.85"
    And the order total in the Order Summary section on My Bag page is "44.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And the order total in the Order Summary section on My Bag page is "43.85"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.53"
    And in BM last order for "Mark" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |

  @guest @shipping_promo @cnc
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "38.85"
    And the order total in the Order Summary section on My Bag page is "44.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "3.53"
    And in BM last order for "Don" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @invalid @guest @hd
  Scenario: Checkout with guest and credit card, Adyen rejects
    Given I am on country "AU"
    And site is "COG"
    And an user "Don"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And customer will land on the checkout page with "HD" details and the error message "We're sorry, your payment has been declined."
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    |

  @invalid @guest @hd
  Scenario: Checkout with guest and credit card, user cancels from top back button
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode | authResult |
      | FAILED       | CANCELLED    | CANCELLED | CANCELLED  |

  @invalid @registered @cnc
  Scenario: Checkout with registered and credit card, user cancels from bottom back button
    Given I am on country "AU"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Mark"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Bottom Back"
    Then user is taken back to My Bag page with "Cancelled" details
#   Then user is taken back to checkout page with "CNC" details
    And in BM last order for "Mark" is:
      | order_status | adyen_status | eventcode | authResult |
      | FAILED       | CANCELLED    | CANCELLED | CANCELLED  |

  @invalid @guest @hd
     #to_do need to code the BM part later as the response url on checkout lacks the order number
  Scenario: Checkout with guest and credit card, user cancels from browser back button
    Given I am on country "AU"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Don"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Browser Back"
    Then user is taken back to checkout page with "HD" details if browser back it hit
    #And in BM last order for "Robin" is:
    #  | order_status | eventcode | authResult |
    #  | FAILED | CANCELLED | CANCELLED |

  @outline @invalid @guest @hd
  Scenario Outline: Checkout with guest and credit card, error code checks
    Given I am on country "AU"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Don"
    And the adyen HPP holderName is <response_codes>
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And customer will land on the checkout page with "HD" details and the error message "We're sorry, your payment has been declined."
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | FAILED       | REFUSED      | AUTHORISATION | REFUSED    |


    Examples:
      | response_codes |
      #| INVALID_CARD  |
      #| NOT_3D_AUTHENTICATED|
      #| REFERRAL     |
      | ERROR        |
      | BLOCK_CARD   |
      | CARD_EXPIRED |
      | DECLINED     |
      #| INVALID_AMOUNT|
      #| NOT_SUPPORTED |
      #| NOT_ENOUGH_BALANCE  |

  @valid @guest @ukaddress @hd
  Scenario: Checkout with guest user with UK address and credit card, Adyen approves
    Given I am on country "AU"
    And site is "COG"
    And an user "Tony"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "6.36"
    And in BM last order for "Tony" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @guest @jpaddress @hd
  Scenario: Checkout with guest user with JP address and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state    |
      | COG  | AU      | Masaomi | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "6.36"
    And in BM last order for "Masaomi" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @ukaddress @hd
  Scenario: Checkout with registered user with UK address and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Alec | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "6.36"
    And in BM last order for "Alec" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid @registered @jpaddress @hd
  Scenario: Checkout with registered user with JP address and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Yuina | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "6.36"
    And in BM last order for "Yuina" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @invalid @ukaddress @hd
  Scenario Outline: Validate phone number field on checkout page for registered user(GB country)
    Given I am on country "AU"
    And site is "COG"
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    And an user "Mark" navigates to the checkout
    And user selects "HD" on the checkout page
    And selects country as "GB"
    When the user enters the <inv_phone_number>
    Then the user sees the <error_message>

    Examples:
      | inv_phone_number       | error_message                                     |
      | 4781564746413154647847 | Please enter 20 or less characters for this field |
      | 1483604%^&%(*781       | Please specify a valid phone number               |

  @invalid @jpaddress @hd
  Scenario Outline: Validate phone number field on checkout page for registered user(JP country)
    Given I am on country "AU"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Mark" navigates to the checkout
    And user selects "HD" on the checkout page
    And selects country as "JP"
    When the user enters the <inv_phone_number>
    Then the user sees the <error_message>

    Examples:
      | inv_phone_number       | error_message                                     |
      | 4781564746413154647847 | Please enter 20 or less characters for this field |
      | 1483604%^&%(*781       | Please specify a valid phone number               |


  @valid @guest @chinesechar @hd
  Scenario: Attempt to checkout with guest user with Chinese characters address and credit card
  Given I log on to the site with the following:
    | site | country | user     | type_of_user | landing_page | user_state    |
    | COG  | AU      | DonChina | guest        | home-page    | not_logged_in |
  When I add the following products to cart
    | sku           | qty |
    | 9351785092140 | 1   |
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

  @invalid @guest @hd
  Scenario: Checkout with guest and credit card, review error code checks
    Given I am on country "AU"
    And site is "COG"
    And an user "Don"
    And the adyen HPP holderName is "Review123"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | REVIEW       | AUTHORISATION | NA         |

  @registered @hd
  Scenario: Checkout with guest, multipack product and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 5555555555011 | 1   |
      | 4444444444011 | 1   |
    And the order total in the Order Summary section on My Bag page is "85.00"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "7.73"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |
