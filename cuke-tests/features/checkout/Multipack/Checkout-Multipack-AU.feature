Feature: Checkout - Multipack - COG-AU

  As a user I want to check out with Multipack in the cart with different payment methods
  In AU, we have these multipack products
  | sku           |
  | 5555555555011 |
  | 4444444444011 |
  | 5555555555012 |
  | 4444444444021 |
  non-promotional product will be used in standard cart

  @guest @hd
  Scenario: Checkout with guest, multipack product and credit card, Adyen approves
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
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
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @registered @product_promo @cnc
  Scenario: Checkout with registered user, multipack product and credit card, CNC, Adyen accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  | cart_page |
      |COG   |AU       |Mark    |registered    | sign-in      | logged_in   | empty     |
    And a bag with products:
      | sku           | qty |
      | 5555555555012 | 2   |
      | 4444444444021 | 2   |
    And user selects the "standard" shipping method on bag page
    And the order total in the Order Summary section on My Bag page is "170.00"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "15.46"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  Scenario: Checkout with guest user, multipack product and Paypal
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 5555555555013 | 1   |
      | 4444444444011 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "85.00"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "7.73"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode | authResult |
      | OPEN         | Completed    | verified  | NA         |

  Scenario: Checkout with guest user, multipack product, CNC, and Paypal
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state  |
      | COG  | AU      | Don  | guest        | sign-in      |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 5555555555013 | 1   |
      | 4444444444011 | 2   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "105.00"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "9.55"
    And in BM last order for "Don" is:
      | order_status | adyen_status| eventcode | authResult |
      | OPEN         | Completed   | verified  | NA         |

  Scenario: Checkout with registered user, multipack and Afterpay, HD
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark   | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 5555555555013 | 1   |
      | 4444444444011 | 1   |
    And I change delivery method to "Standard"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "7.73"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode       | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  Scenario: Checkout with registered user, multipack and Afterpay, CNC order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark   | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 5555555555013 | 1   |
      | 4444444444011 | 2   |
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "9.55"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode       | authResult |
      | OPEN         | APPROVED    | AFTERPAY_CREDIT | NA         |

  @wip @zip
  Scenario: Checkout with guest user, multipack and CNC for an approved zip order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jesse  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 5555555555013 | 1   |
      | 4444444444011 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "cnc" delivery
    And "guest" user fills in billing address details for "zip"
    And the user clicks on the Continue to Payment button on the Checkout page for "zip"
    And on zip page user places an order with new "Random" user
    Then zip Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the zip Thankyou page
    And placed order total is verified and payment type is "ZIP Pay Over Time"
    And tax amount is "7.73"
    And in BM last zip order for "Jesse" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_receipt_trsct_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                   |

  @wip
  Scenario: Checkout with latpay as payment method and as a registered user with mixed cart(multipack) for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
      | 5555555555013 | 1   |
      | 4444444444011 | 2   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "146.90"
    And "registered" user fills in billing address details for "latpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "latpay"
    And on "latpay" page user places an order with a random user
    Then "latpay" Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the latpay Thankyou page
    And placed split order total is verified and payment type is "LatitudePay"
    And tax amount is "15.18"
    And in BM last "latpay" order for "Don" is:
      | latpay_order_status | latpay_processor | latpay_transaction | latpay_invoice | latpay_personalised_order_true |
      | OPEN                | LATITUDE         | true               | true           | true                           |

  Scenario: Checkout with adyen as payment method and as a guest user with mixed cart(multipack) for an approved order with split payment
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
      | 5555555555013 | 1   |
      | 4444444444011 | 2   |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |30    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "176.90"
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "15.18"
    And in BM last order for "Don" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @wip
  # No longer required after PDP updates release
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Tuesday' before cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "5555555555013" with Date and Time as "2019_08_13_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Fri 16th Aug" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tomorrow" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  Scenario: Validate bnpl tagline on bag page with mixed cart(normal+personlised+egift+multipack) and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9351785092140 | 1   |
      | 4444444444011 | 2   |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |adam           |abc@abc.com    |abc@abc.com        |gilli       |msg2       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    Then bnpl tagline with text as "Or buy now from AU$39.74 per week" is displayed on My bag page

  @wip
  #waiting for wishlist update on PLP due to pdp updates release
  Scenario: Add Products to Wishlist via PLP as guest user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When user navigates to "gifts/gifts-for-everyone/gifts-for-teens/" page
    And I click on Wishlist icon of the product "444444-01" in PLP
    Then I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 444444-01 |

  @wip
  #waiting for wishlist update on PLP due to pdp updates release
  Scenario: Remove Product from Wishlist by unchecking Wishlist Icon of a Product on PLP as guest user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When user navigates to "gifts/gifts-for-everyone/gifts-for-teens/" page
    And I click on Wishlist icon of the product "444444-01" in PLP
    And I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 444444-01 |
    And user navigates to "gifts/gifts-for-everyone/gifts-for-teens/" page
    Then I remove the product "444444-01" from Wishlist in PLP
    And I navigate to Wishlist page
    And there are no products on the Wishlist page

  Scenario: Adding Physical-giftcards to Wishlist page from PDP
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the products to Wishlist from PDP page
      | sku           |
      | 4444444444011 |
    When I navigates to Wishlist page
    Then the products displayed on Wishlist page are
      | product    |
      | 444444-01 |

  Scenario: As a guest user with empty wishlist move all items from My Bag to wishlist
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the following products to cart
      | sku           | qty |
      | 9351533603802 | 1   |
      | 9351533840603 | 1   |
      | 4444444444011 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And I add the product to Wishlist from bag page
      | products  |
      | 444444-01 |
    And the message "Pack of 3 stationary items moved to your wishlist." is displayed on My Bag page
    Then I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product   |
      | 444444-01 |

  Scenario: Verify the Save text on the PDP for a Multipack with RRP config ON for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "5555555555013"
    Then "Save RRP" text is displayed for Multipack on the PDP

  Scenario: Verify the Save percent on the PLP for a Multipack with RRP config ON for guest user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    When user navigates to "gifts/gift-ideas/gaming-gift-ideas/" page
    Then "Save RRP" text is displayed for Multipack on the PLP

  Scenario: Verify the Save text on the PDP for a Multipack with RRP config ON for registered user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state | cart_page |
      |COG |AU     |Don  |registered  |sign-in     |logged_in  | empty     |
    When the user navigates to PDP of the product "5555555555013"
    Then "Save RRP" text is displayed for Multipack on the PDP

  Scenario: Verify the Save percent on the PLP for a Multipack with RRP config ON for registered user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state | cart_page |
      |COG |AU     |Don  |registered  |sign-in     |logged_in  | empty     |
    When user navigates to "gifts/gift-ideas/gaming-gift-ideas/" page
    Then "Save RRP" text is displayed for Multipack on the PLP

  Scenario: Verify the Save text on My Bag pg for a Multipack with RRP config ON for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 5555555555013 | 1   |
    Then I navigate to bag page by clicking the minicart icon
    And I validate "Save RRP" text for qty "1" on My bag page
    And I add "2" more to the qty from the My Bag page
    And I validate "Save RRP" text for qty "2" on My bag page
    And user selects to checkout from their bag
    And I validate "Save RRP" text for qty "2" on checkout page

  Scenario: Verify the Save text on My Bag pg for a Multipack with RRP config ON for registered user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state | cart_page |
      |COG |AU     |Don  |registered  |sign-in     |logged_in  | empty     |
    When I add the following products to cart
      | sku           | qty |
      | 5555555555013 | 1   |
    Then I navigate to bag page by clicking the minicart icon
    And I validate "Save RRP" text for qty "1" on My bag page
    And I add "2" more to the qty from the My Bag page
    And I validate "Save RRP" text for qty "2" on My bag page
    And user selects to checkout from their bag
    And I validate "Save RRP" text for qty "2" on checkout page