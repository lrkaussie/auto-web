@paypal_checkout @au
Feature: Checkout - Paypal - COG-AU

  As a user I want to check out where Paypal is the payment provider
  In AU, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|
  | 130664        | Y     | 12.95 |11.95                  |5.18          |
  | 141114        | N     | 49.99 |NA                     |NA            |

  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $9
  Particular card details cause approve or reject
  Assume configured payment method is paypal
  HD is $6, cnc is $3

  @valid @guest @hd @jenkins @paypal
  Scenario: Checkout with guest and paypal, Paypal approves
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "55.99"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "5.09"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @guest @cnc @paypal
  Scenario: Checkout with guest and paypal, CNC Paypal approves
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "49.99"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "4.54"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @guest @product_promo @cnc @paypal
  Scenario: Checkout with guest user and paypal, CNC, product promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 1   |
    And the price of product before any promotion is "12.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.95"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "11.95"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "1.09"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @guest @order_promo @cnc @paypal
  Scenario: Checkout with guest user and paypal, CNC, order promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.18"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "20.72"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "1.88"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @guest @shipping_promo @hd @paypal
  Scenario: Checkout with guest user and paypal, HD, shipping promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "43.85"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "3.99"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @registered @hd @paypal
  Scenario: Checkout with registered user and paypal, Paypal approves
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Mark     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 9351785092140 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "55.99"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "HD_Registered" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "5.09"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @registered @product_promo @cnc @paypal
  Scenario: Checkout with registered user and paypal, CNC, product promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Mark     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 1   |
    And the price of product before any promotion is "12.95"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "11.95"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "11.95"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "1.09"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @registered @order_promo @cnc @paypal
  Scenario: Checkout with registered user and paypal, CNC, order promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Mark     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.18"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "20.72"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "1.88"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |


  @valid @registered @order_promo @hd @paypal
  Scenario: Checkout with registered user and paypal, HD, order promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Mark     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.90"
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "5.18"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "26.72"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "HD_Registered" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "2.43"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |

  @valid @registered @shipping_promo @cnc @paypal @smoke_test
  Scenario: Checkout with registered user and paypal, CNC, shipping promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Mark     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "38.85"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "3.53"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |


  @valid @guest @shipping_promo @cnc @paypal
  Scenario: Checkout with guest user and paypal, CNC, shipping promotion, Paypal accepts
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     |guest         | sign-in      |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.85"
    And promo code added on bag "autotest_shipping"
    And the price of product after shipping promotion applied is "43.85"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | CNC            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "38.85"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And tax amount is "3.53"
    And in BM last order for "Mark" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | Completed    | verified | NA         |


