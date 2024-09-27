Feature: Checkout - zip - COG-AU

  As a user I want to check out with zip as the payment provider
  In AU, we have these products
  | sku             | promo | price |product_promotion_price|order_discount|
  | 9351785509303   | Y     | 12.95 |11.95                  |5.18          |
  | 9351785092140   | N     | 49.99 |NA                     |NA            |
  | 9351785851327   | N     | NA    | NA                    | NA           |
  | EGIFT DESIGN 02 | N     | NA    | NA                    | NA           |

  2790030163867647149 - 1234 - Gift card
  Users used are Jesse and Don
  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9
  Particular last name in new user cause approve or reject
  Jira Tickets number are CO-4952 and CO-5009
  Assume configured payment method is zip

  @zip
  Scenario: Checkout with zip as a registered user with mixed cart for an approved order
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And "registered" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the zip Thankyou page
    And placed order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "8.99"
    And in BM last zip order for "Don" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_receipt_trsct_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                   |

  @zip
  Scenario: Checkout with zip as a registered user with personalised product for an approved zip order
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And "registered" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the zip Thankyou page
    And placed order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "4.45"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_receipt_trsct_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                   |

  @zip
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion for an approved zip order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "38.85"
    And the order total in the Order Summary section on My Bag page is "44.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the zip Thankyou page
    And placed order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "3.53"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_receipt_trsct_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                   |

  @zip
  Scenario: Checkout with zip as a registered user with mixed cart for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And "registered" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the zip Thankyou page
    And placed split order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "8.99"
    And in BM last zip order for "Don" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  @zip
  Scenario: Checkout with zip as a registered user with personalised product for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And "registered" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the zip Thankyou page
    And placed split order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "4.45"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  @zip
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 3   |
    And the price of product before any promotion is "38.85"
    And the order total in the Order Summary section on My Bag page is "44.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the zip Thankyou page
    And placed split order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "3.53"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |


  @zip @guest @hd
  Scenario: Checkout with zip as a guest user with normal product for an approved order
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with an existing user
    Then zip Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the zip Thankyou page
    And placed order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "0.73"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_receipt_trsct_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                   |

  @zip
  Scenario: Verify that zip is not available as a guest user with egift card only cart
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
    Then zip payment method is not available on the "CO" page

  @zip
  Scenario: Checkout with zip as a guest user with normal product for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places a split order with an existing user
    Then zip Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the zip Thankyou page
    And placed split order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "9.09"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  @zip
  Scenario: Verify the error for zip as a guest user with international delivery and billing addresses
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "US" international delivery address
    And user selects the payment type as "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And user sees the global error message:
      | error_message |
      | Zip is not available for delivery and billing addresses outside of Australia |

  @zip
  Scenario: Verify the error for zip as a guest user with national delivery and international billing addresses
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing details for "zip" with "US" international address
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And user sees the global error message:
      | error_message |
      | Zip is not available for delivery and billing addresses outside of Australia |

  @zip
  Scenario: Verify the error for zip as a guest user with international delivery and national billing addresses
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "US" international delivery address
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And user sees the global error message:
      | error_message |
      | Zip is not available for delivery and billing addresses outside of Australia |

  @zip
  Scenario: Checkout with zip as a guest user with mixed cart for a Browser back scenario
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
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user clicks browser back
    Then user is taken back to checkout page with "HD" details if browser back it hit
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_notes_status |
      | FAILED           | Processor     | Transaction     |             | Blank            |

  @zip
  Scenario: Checkout with guest user and credit card, CNC, shipping promotion for a Browser back scenario
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
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
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user clicks browser back
    Then user is taken back to checkout page with "CNC" details if browser back it hit
    And in BM last zip order for "Don" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_notes_status |
      | FAILED           | Processor     | Transaction     |             | Blank            |

  @zip
  Scenario: Checkout with zip as a guest user with normal product with click to return to sandbox lin on zip HPP
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user clicks on the link as return to sandbox
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_notes_status |
      | FAILED           | Processor     | Transaction     |             | Blank            |

  @zip
  Scenario: Checkout with zip as a guest user with mixed cart for a Referral order
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Referral" user
    And in BM last zip order for "Don" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_notes_status |
      | FAILED           | Processor     | Transaction     |             | DECLINED         |

  @zip
  Scenario: Checkout with zip as a guest user with normal product for a Declined order
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486356827 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Declined" user
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_notes_status |
      | FAILED           | Processor     | Transaction     |             | DECLINED         |

