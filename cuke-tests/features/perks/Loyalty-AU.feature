@perks @au
Feature: Loyalty features for manual and click to activate vouchers
  As a user
  I can add products to bag
  And manually apply perks vouchers at Check out
  Or click to activate perks voucher from email
  So I can get a discount

  Assumption

  User John has vouchers in RMS:
  | voucher_no         | status     | expires   | amount | currency |
  | 9840150120702065   | valid      | 9  days   | 10     | AU       |
  | 9840150120702066   | valid      | 9  days   | 10     | AU       |
  | 9850150120702066   | valid      | 9  days   | 10     | AU       |
  | 9920150120702065   | presented  |           |        | AU       |
  | 9910150120702065   | redeemed   |           |        | AU       |
  | 9930150120702065   | cancelled  |           |        | AU       |
  | 9940150120702065   | expired    |           |        | AU       |

  Site has following products
  | sku           | qty | price   |
  | 9351785586540 | 2   | 19.95   |
  | 141114        | 2   | 49.99   |
  | 9350486827327 | 2   | 7       |

  Background:
    Given I am on country "AU"
    And site is "COG"

  @valid_voucher @manual_voucher @registered @hd @adyen
  Scenario: Apply one manual voucher and place a home delivery order as registered user
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order total in the Order Summary section on My Bag page is "55.99"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    Then the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the total on checkout is "45.99"
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
     | order_status | adyen_status| eventcode     | authResult |
     | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"


  @valid_voucher @manual_voucher @registered @cnc @adyen
  Scenario: Apply one manual voucher and place a CnC order as a registered user
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order total in the Order Summary section on My Bag page is "55.99"
    And checkout button is pressed
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    Then the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the total on checkout is "39.99"
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"


  @valid_voucher @multiple_voucher @manual_voucher @guest @hd @adyen @smoke_test
  Scenario: Apply two manual vouchers and place a HD order as a guest user
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    Then the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the total on checkout is "35.99"
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"
    And price adjustment for voucher 2 is "10.00"

  @valid_voucher @cta_voucher @guest @hd @adyen
  Scenario: Apply one click to activate voucher and place a HD order as guest user
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And the order total in the Order Summary section on My Bag page is "45.99"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "45.99"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @valid_voucher @cta_voucher @registered @cnc @adyen
  Scenario: Apply one click to activate voucher and place a CnC order as registered user
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And the order total in the Order Summary section on My Bag page is "45.99"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "45.99"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @valid_voucher @multiple_voucher @cta_voucher @guest @hd @adyen @smoke_test
  Scenario: Apply two click to activate vouchers and place a HD order as guest user
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And the user clicks on activate voucher email link for "9840150120702066"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order discount in the Order Summary section on My Bag page is "20.00"
    And the order total in the Order Summary section on My Bag page is "35.99"
    And checkout button is pressed
    And the order discount after perks voucher applied is "20.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "35.99"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"
    And price adjustment for voucher 2 is "10.00"

    @invalid_voucher @cta_voucher
    Scenario: Error scenario when customer tries to apply a click to activate voucher when is already presented
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9920150120702065 |
    When the user clicks on activate voucher email link for "9920150120702065"
    Then the customer sees the overlay popup message "Voucher code 9920150120702065 is currently locked. Please try after some time."

  @invalid_voucher @cta_voucher
  Scenario: Error scenario when customer tries to apply a click to activate voucher when is already redeemed
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9910150120702065 |
    When the user clicks on activate voucher email link for "9910150120702065"
    Then the customer sees the overlay popup message "Voucher code 9910150120702065 is already redeemed."

  @invalid_voucher @cta_voucher
  Scenario: Error scenario when customer tries to apply a click to activate voucher when is already cancelled
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9930150120702065 |
    When the user clicks on activate voucher email link for "9930150120702065"
    Then the customer sees the overlay popup message "The voucher you entered has been cancelled"

  @invalid_voucher @cta_voucher
  Scenario: Error scenario when customer tries to apply a click to activate voucher when has expired
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9940150120702065 |
    When the user clicks on activate voucher email link for "9940150120702065"
    Then the customer sees the overlay popup message "The voucher you entered has expired"


  @invalid @guest @cta_voucher @guest @hd @adyen
  Scenario: Apply one click to activate voucher and Adyen Rejects on placeing a HD order
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "45.99"
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And customer will land on the checkout page with "HD" details and the error message "We're sorry, your payment has been declined."
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @invalid @guest @cta_voucher @guest @hd @adyen
  Scenario: Apply one click to activate voucher and cancel payment on Adyen payment gateway while placeing a HD order
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "45.99"
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    And user is taken back to checkout page with "HD" details
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @valid_voucher @manual_voucher @cta_voucher @guest @hd @adyen
  Scenario: Place order with a click to activate voucher and voucher applied on Checkout page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    And the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702066 |
    And the user clicks on activate voucher email link for "9840150120702066"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And the order discount in the Order Summary section on My Bag page is "20.00"
    And checkout button is pressed
    And the order discount after perks voucher applied is "20.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "45.85"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"
    And price adjustment for voucher 2 is "10.00"


  @valid_voucher @hd @session_status @cta_voucher @adyen
  Scenario: Session status, Add products as guest and apply a click to activate voucher as same guest user
    And an user "John"
    And a bag with products:
      | sku            | qty |
      | 9351785586540  | 1   |
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku            | qty |
      | 9351785586540  | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "35.9"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @session_status @valid_voucher @hd @cta_voucher @adyen
  Scenario: Session status, add products as registered user and apply a click to activate voucher as a different guest user.
    And an user "Don"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    And user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "45.99"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @session_status @valid_voucher @hd @cta_voucher @adyen
  Scenario: Session status, add products as guest user and apply click to activate voucher as a different guest user.
    And an user "Don"
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guesst    | house   | HD            |
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the order discount after perks voucher applied is "10.00"
    #And the user expands the voucher section
    And the click to activate voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the click to activate voucher
    And the total on checkout is "35.9"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @valid_voucher @guest @hd @cta_voucher @adyen
  Scenario: My bag minimum spend threshold message for click to activate welcome voucher and bag value less than minimum spend threshold
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9350486827327 | 1   |
    And the user sees overlay popup message
      | message                                                               |
      | Sorry!                                                                |
      | Your Perks Welcome Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 25.00 and over                           |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the total on checkout is "13"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN         | APPROVED    | AUTHORISATION | NA         |

  @valid_voucher @guest @hd @cta_voucher
  Scenario: My bag minimum spend threshold message for click to activate payday voucher and bag value less than minimum spend threshold
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9850150120702065 |
    And the user clicks on activate voucher email link for "9850150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9350486827327 | 1   |
    And the user sees overlay popup message
      | message                                                               |
      | Sorry!                                                                |
      | Your Perks Payday Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 10.00 and over                           |
    And the order discount in the Order Summary section on My Bag page is "10.00"

  @valid_voucher @guest @hd @cta_voucher
  Scenario: My bag minimum spend threshold message for click to activate Birthday voucher and bag value less than minimum spend threshold
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9900150120702065 |
    And the user clicks on activate voucher email link for "9900150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9350486827327 | 1   |
    And the user sees overlay popup message
      | message                                                                |
      | Sorry!                                                                 |
      | Your Perks Birthday Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 10.00 and over                            |
    And the order discount in the Order Summary section on My Bag page is "10.00"

  @valid_voucher @guest @hd @cta_voucher @adyen
  Scenario: My bag minimum spend threshold message for click to activate Welcome voucher and modification of bag to less than minimum spend threshold
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
      | 9350486827327 | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the total on checkout is "42.90"
    And the user edits the bag from Checkout Page
    And the bag is modified such that the order total goes below minimum spend threshold
      | sku           | qty |
      | 9351785586540 | 0   |
    And the user sees overlay popup message
      | message                                                               |
      | Sorry!                                                                |
      | Your Perks Welcome Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 25.00 and over                           |
    And checkout button is pressed
    And the total on checkout is "13"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "John" is:
      | order_status | adyen_status| eventcode     | authResult |
      | OPEN        | APPROVED    | AUTHORISATION | NA         |

  @valid_voucher @guest @hd @cta_voucher
  Scenario: My bag minimum spend threshold message for click to activate Payday voucher and modification of bag to less than minimum spend threshold
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9850150120702065 |
    And the user clicks on activate voucher email link for "9850150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
      | 9350486827327 | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the total on checkout is "42.90"
    And the user edits the bag from Checkout Page
    And the bag is modified such that the order total goes below minimum spend threshold
      | sku           | qty |
      | 9351785586540 | 0   |
    And the user sees overlay popup message
      | message                                                              |
      | Sorry!                                                               |
      | Your Perks Payday Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 10.00 and over                          |

  @valid_voucher @guest @hd @cta_voucher
  Scenario: My bag minimum spend threshold message for click to activate Birthday voucher and modification of bag to less than minimum spend threshold
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9900150120702065 |
    And the user clicks on activate voucher email link for "9900150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
      | 9350486827327 | 1   |
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And checkout button is pressed
    And the total on checkout is "42.90"
    And the user edits the bag from Checkout Page
    And the bag is modified such that the order total goes below minimum spend threshold
      | sku           | qty |
      | 9351785586540 | 0   |
    And the user sees overlay popup message
      | message                                                                |
      | Sorry!                                                                 |
      | Your Perks Birthday Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 10.00 and over                            |

  @cta_voucher @egiftcard @rerun
  Scenario: Overlay message on Bag page on adding a click to activate Welcome voucher and a cart of only e-gift card product
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |John |guest       |sign-in|not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user adds the eGiftcard to cart
    And user navigates to bag page by clicking the minicart icon
    And the user sees overlay popup message
      | message                                                               |
      | Sorry!                                                                |
      | Your Perks Welcome Voucher will be removed if you proceed to checkout |
      | Rewards cannot be redeemed or earned on e-gift cards                  |

  @cta_voucher @egiftcard @rerun
  Scenario: Overlay message on Bag page on adding a click to activate Birthday voucher and a cart of only e-gift card product
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9900150120702065 |
    And the user clicks on activate voucher email link for "9900150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |John |guest       |sign-in|not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user adds the eGiftcard to cart
    And user navigates to bag page by clicking the minicart icon
    And the user sees overlay popup message
      | message                                                                |
      | Sorry!                                                                 |
      | Your Perks Birthday Voucher will be removed if you proceed to checkout |
      | Rewards cannot be redeemed or earned on e-gift cards                   |

  @cta_voucher @egiftcard @rerun
  Scenario: Overlay message on Bag page on adding a click to activate Payday voucher and a cart of only e-gift card product
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9850150120702065 |
    And the user clicks on activate voucher email link for "9850150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | John | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      | design          | amount | recipient_name | recipient_email | recipient_email_conf | senders_name | senders_msg |
      | EGIFT DESIGN 02 | 10     | abc            | abc@abc.com     | abc@abc.com          | xyz          | msg1        |
    And the user adds the eGiftcard to cart
    And user navigates to bag page by clicking the minicart icon
    And the user sees overlay popup message
      | message                                                              |
      | Sorry!                                                               |
      | Your Perks Payday Voucher will be removed if you proceed to checkout |
      | Rewards cannot be redeemed or earned on e-gift cards                 |


  @cta_voucher @egiftcard @rerun
  Scenario: Overlay message on Bag page on adding a click to activate Payday voucher and a cart of normal and e-gift card products
    And an user "John"
    And the user has received click to activate emails for vouchers
      | voucher_id       |
      | 9850150120702065 |
    And the user clicks on activate voucher email link for "9850150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | John | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9350486827327 | 1   |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      | design          | amount | recipient_name | recipient_email | recipient_email_conf | senders_name | senders_msg |
      | EGIFT DESIGN 02 | 10     | abc            | abc@abc.com     | abc@abc.com          | xyz          | msg1        |
    And the user adds the eGiftcard to cart
    And user navigates to bag page by clicking the minicart icon
    And the user sees overlay popup message
      | message                                                              |
      | Sorry!                                                               |
      | Your Perks Payday Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 10.00 and over                          |
    And checkout button is pressed
    And the total on checkout is "23"

  @cta_voucher @egiftcard @rerun
  Scenario: Apply eGift card after adding a click to activate voucher
    And an user "John"
    And the user has received click to activate emails for vouchers
    | voucher_id       |
    | 9840150120702065 |
    And the user clicks on activate voucher email link for "9840150120702065"
    And the customer sees the overlay popup message "$10 reward activated"
    And the message has the text "Expires in 10 days."
    And I log on to the site with the following:
    |site|country|user|type_of_user|landing_page       |user_state   |
    |COG |AU     |John |guest       |sign-in|not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user adds the eGiftcard to cart
    And user navigates to "checkout" page
    Then the user is presented with the error message "Sorry, your Perks Voucher has been removed.This reward is only available on orders AUD 25.00 and over. Rewards cannot be redeemed or earned on e-gift cards." on the checkout global overlay
    And the perks voucher section is hidden
    And the total on checkout is "10"

    @manual_voucher
  Scenario: Error message when trying to apply voucher, which is already presented, on Checkout Page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9920150120702065 |
    Then the customer sees the error message "This voucher is currently locked. Please try after some time" below the voucher input box on Checkout page

    @manual_voucher
  Scenario: Error message when trying to apply voucher, which is already redeemed, on Checkout Page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9910150120702065 |
    Then the customer sees the error message "Voucher code 9910150120702065 is already redeemed." below the voucher input box on Checkout page

    @manual_voucher
  Scenario: Error message when trying to apply voucher, which is already cancelled, on Checkout Page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9930150120702065 |
    Then the customer sees the error message "The voucher you entered has been cancelled" below the voucher input box on Checkout page

    @manual_voucher
  Scenario: Error message when trying to apply voucher, which is already expired, on Checkout Page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9940150120702065 |
    Then the customer sees the error message "The voucher you entered has expired" below the voucher input box on Checkout page