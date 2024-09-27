Feature: Checkout - LatitudePay - COG-AU

  As a user I want to check out with LatitudePay as the payment provider
  In AU, we have these products
  | sku             | promo | price |product_promotion_price|order_discount|
  | 9351785509303   | Y     | 12.95 | 11.95                 | 5.18         |
  | 9351785092140   | N     | 49.99 | NA                    | NA           |
  | 9351785851327   | N     | NA    | NA                    | NA           |
  | EGIFT DESIGN 02 | N     | NA    | NA                    | NA           |
  | 9351785824550   | N     | 12.95 | NA                    | NA           |

  2790030163867647149 - 1234 - Gift card
  Users used are Jesse and Don
  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9
  Particular card details OR user cause approve or reject
  Jira ticket numbers are CO-5072 and CO-5073
  Assume configured payment method is Latpay

  @Laybuy @guest @hd
  Scenario: Checkout with latitude pay as a guest user with normal product for an approved order
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 4   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the latpay Thankyou page
    And placed order total is verified and payment type is "LatitudePay"
    And tax amount is "5.26"
    And in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_order_true |
      | OPEN                | LATITUDE         | true               | true           | true              |

  Scenario: Checkout as a registered user with personalised product for an approved latpay order
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351533909324 | 2   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And "registered" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the latpay Thankyou page
    And placed order total is verified and payment type is "LatitudePay"
    And tax amount is "8.99"
    And in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_personalised_order_true |
      | OPEN                | LATITUDE         | true               | true           | true                           |

  Scenario: Checkout with guest user and credit card, CNC, shipping promotion for an approved latpay order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 |  4 |
    And the price of product before any promotion is "51.80"
    And the order total in the Order Summary section on My Bag page is "57.80"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "56.80"
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the latpay Thankyou page
    And placed order total is verified and payment type is "LatitudePay"
    And tax amount is "4.71"
    And in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_order_true |
      | OPEN                | LATITUDE         | true               | true           | true              |

  Scenario: Checkout with latpay as payment method and as a registered user with mixed cart for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785824550 | 3   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "67.80"
    And "registered" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the latpay Thankyou page
    And placed split order total is verified and payment type is "LatitudePay"
    And tax amount is "7.98"
    And in BM last "latpay" order for "Don" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_personalised_order_true |
      | OPEN                | LATITUDE         | true               | true           | true                           |

  Scenario: Checkout with latpay as payment method and as a registered user with personalised product for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 2   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "68.90"
    And "registered" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the latpay Thankyou page
    And placed split order total is verified and payment type is "LatitudePay"
    And tax amount is "8.08"
    And in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_personalised_order_true |
      | OPEN                | LATITUDE         | true               | true           | true                           |

  Scenario: Checkout with guest user and credit card, CNC, shipping promotion for an approved latpay order with split payment
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 4   |
    And the price of product before any promotion is "51.80"
    And the order total in the Order Summary section on My Bag page is "57.80"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "56.80"
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "31.80"
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the latpay Thankyou page
    And placed split order total is verified and payment type is "LatitudePay"
    And tax amount is "4.71"
    And in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_order_true |
      | OPEN                | LATITUDE         | true               | true           | true              |

  Scenario: Verify latpay is not present on the CO page as a registered user with mixed cart
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    Then "latpay" payment method is not present on the checkout page

  Scenario: Verify that latpay is not displayed as a guest user with egift card only cart
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |adam           |abc@abc.com    |abc@abc.com        |gilli       |msg2       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    Then "latpay" payment method is not present on the checkout page

  Scenario: Verify that latpay payment method is not available as a guest user with international delivery and billing addresses
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "US" international delivery address
    And user selects the payment type as "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And user sees the global error message:
      | error_message |
      | LatitudePay is not available for billing addresses outside of Australia |

  Scenario: Verify the error for latpay payment method as a guest user with national delivery and international billing addresses
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 3   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing details for "latpay" with "US" international address
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And user sees the global error message:
      | error_message |
      | LatitudePay is not available for billing addresses outside of Australia |

  Scenario: Verify the order with latpay as payment method and user as a guest user with international delivery and national billing addresses
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "US" international delivery address
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "International" delivery address is shown on the "latpay" Thankyou page
    And placed order total is verified and payment type is "LatitudePay"
    And tax amount is "2.18"
    And in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_order_true |
      | OPEN                | LATITUDE         | true               | true           | true              |

  Scenario: Verify latpay failed order as a guest user with mixed cart for a Browser back scenario before logging in
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user clicks browser back
    Then in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor |  latpay_invoice | latpay_personalised_order_true |
      | FAILED              | LATITUDE         |  false          | true                           |


  Scenario: Verify latpay failed order as a registered user and credit card, CNC, shipping promotion for a Browser back scenario after logging in
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "38.85"
    And user selects the "standard" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "44.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When "registered" user fills in details for "cnc" delivery
    And "registered" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with an existing user
    And on "latpay" page user clicks browser back
    Then in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor |  latpay_invoice | latpay_order_true |
      | FAILED              | LATITUDE         |  false          | true              |

  Scenario: Verify the failed order as a guest user with normal product by clicking cross link on latpay page after logging in
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with an existing user
    And on "latpay" page user clicks on the cross link after login
    Then in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor |  latpay_invoice | latpay_order_true |
      | FAILED              | LATITUDE         |  false          | true              |

  Scenario: Verify the failed order as a guest user with normal product by clicking return to merchant link on latpay page while signing up
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user clicks on the return to merchant link while signing up
    Then in BM last "latpay" order for "Jesse" is:
      | latpay_order_status | latpay_processor |  latpay_invoice | latpay_order_true |
      | FAILED              | LATITUDE         |  false          | true              |

  Scenario: Verify latpay minimum order threshold as $20 as a guest user with normal product
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And user sees the global error message:
      | error_message |
      | LatitudePay is only available on orders above AU$20.00 |

  Scenario: Verify latpay minimum order threshold as $20 as a registered user with normal product and split payment
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 2   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "19.90"
    And "registered" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And user sees the global error message:
      | error_message |
      | LatitudePay is only available on orders above AU$20.00 |
