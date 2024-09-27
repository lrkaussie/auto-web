@perks_bag @au
Feature: Ability to apply vouchers on My Bag
  As a CottonOn business
  I want to allow customers to apply PERKS vouchers in My Bag
  So that it's easier for customers to use their PERKS vouchers

  Assumption

   User John has vouchers in RMS:
    | voucher_no         | status     | expires   | amount | currency |
    | 9840150120702065   | valid      | 9  days   | 10     | AU       |
    | 9840150120702066   | valid      | 9  days   | 10     | AU       |
    | 9920150120702065   | presented  |           |        | AU       |
    | 9910150120702065   | redeemed   |           |        | AU       |
    | 9930150120702065   | cancelled  |           |        | AU       |
    | 9940150120702065   | expired    |           |        | AU       |

  Demandware has the following coupons
    | coupon_id                   | type                                      |
    | autotest_product            | Product Promo                             |
    | autotest_order              | Order Promo                               |
    | autotest_shipping           | Shipping Promo                            |
    | autotest_disabled           | Disabled Coupon                           |
    | autotest_disabled_promo     | Promotion Disabled                        |
    | autotest_redeemed           | Redeemed Coupon                           |
    | autotest_redeemed_customer1 | Max redemption limit reached for customer |

  Demandware has following products
    | sku           | qty | unit price   |
    | 141114        | 2   | 49.99        |
    | 130664        | 4   | 12.95        |

  Background:
    Given I am on country "AU"
    And site is "COG"

  @perks1
  Scenario: Successful validation of voucher when customer applies voucher code in My Bag
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And the order total in the Order Summary section on My Bag page is "55.99"
    When customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
    Then the customer sees the message Success "Perks Welcome Voucher" Added! below the voucher input box
    And the customer can see the voucher applied in the Applied codes section
    And the customer can see Remove link against the PERKS voucher
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And the order total in the Order Summary section on My Bag page is "45.99"
    And checkout button is pressed
    And the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the total on checkout is "45.99"

  @perks1
  Scenario: Voucher applied on My Bag is reflected on the checkout page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    When customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
    And checkout button is pressed
    Then the order discount after perks voucher applied is "10.00"
    And the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the total on checkout is "45.99"


  Scenario: Voucher applied on Checkout Page is reflected on My Bag page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    When user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the user edits the bag from Checkout Page
    Then the customer can see the voucher applied in the Applied codes section
    And the customer can see Remove link against the PERKS voucher
    And the order discount in the Order Summary section on My Bag page is "20.00"
    And the order total in the Order Summary section on My Bag page is "35.99"

  @perks1
  Scenario: Voucher applied on Bag Page is removed from Checkout page and is reflected back on My Bag page
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
    And the customer can see the voucher applied in the Applied codes section
    And the order total in the Order Summary section on My Bag page is "45.99"
    And checkout button is pressed
    When the customer removes the perks voucher from Checkout Page
      | voucher_id       |
      | 9840150120702065 |
    And the user edits the bag from Checkout Page
    Then the order total in the Order Summary section on My Bag page is "55.99"
    And the customer cannot see the voucher applied in the Applied codes section

  @adyen @smoke_test @perks1
  Scenario: Apply two vouchers on bag and user successfully places the order
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the customer can see the voucher applied in the Applied codes section
    And the customer can see Remove link against the PERKS voucher
    And the order discount in the Order Summary section on My Bag page is "20.00"
    And the order total in the Order Summary section on My Bag page is "35.99"
    And checkout button is pressed
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
      | NEW          | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"
    And price adjustment for voucher 2 is "10.00"

  @adyen @cta_voucher @perks1
  Scenario: Apply a click to activate voucher and another voucher on bag and user successfully places the order
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
    And customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702066 |
    And the customer can see the voucher applied in the Applied codes section
    And the customer can see Remove link against the PERKS voucher
    And the order discount in the Order Summary section on My Bag page is "20.00"
    And the order total in the Order Summary section on My Bag page is "35.99"
    And checkout button is pressed
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
      | NEW          | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"
    And price adjustment for voucher 2 is "10.00"

  @adyen @perks1
  Scenario: Apply voucher on bag and place a HD order and Adyen Rejects
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
    And the customer sees the message Success "Perks Welcome Voucher" Added! below the voucher input box
    And the customer can see the voucher applied in the Applied codes section
    And the customer can see Remove link against the PERKS voucher
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And the order total in the Order Summary section on My Bag page is "45.99"
    And checkout button is pressed
    And the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the order discount after perks voucher applied is "10.00"
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
      | NEW          | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

  @adyen @perks1
  Scenario: Apply voucher on bag and place a HD order and User Cancels payment on Adyen Payment Gateway
    And an user "John"
    And a bag with products:
      | sku           | qty |
      | 141114        | 1   |
    And customer enters the voucher in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
    And the customer sees the message Success "Perks Welcome Voucher" Added! below the voucher input box
    And the customer can see the voucher applied in the Applied codes section
    And the customer can see Remove link against the PERKS voucher
    And the order discount in the Order Summary section on My Bag page is "10.00"
    And the order total in the Order Summary section on My Bag page is "45.99"
    And checkout button is pressed
    And the voucher is applied on the checkout page under the PERKS voucher section
    And the customer can see the Remove link against the PERKS voucher
    And the order discount after perks voucher applied is "10.00"
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
      | NEW          | APPROVED    | AUTHORISATION | NA         |
    And price adjustment for voucher 1 is "10.00"

   @perks1
   Scenario: Error message when trying to apply voucher, which is already presented, on Bag Page
     And an user "John"
     And a bag with products:
       | sku           | qty |
       | 141114        | 1   |
     When customer enters the voucher in the Perks Voucher section on My Bag page
       | voucher_id       |
       | 9920150120702065 |
     Then the customer sees the error message "The voucher you entered is already applied" below the voucher input box

  @perks1
  Scenario: Error message when trying to apply voucher, which is already redeemed, on Bag Page
    And an user "John"
    And a bag with products:
     | sku           | qty |
     | 141114        | 1   |
   When customer enters the voucher in the Perks Voucher section on My Bag page
     | voucher_id       |
     | 9910150120702065 |
   Then the customer sees the error message "The voucher is already redeemed" below the voucher input box

 @perks1
 Scenario: Error message when trying to apply voucher, which is already cancelled, on Bag Page
   And an user "John"
   And a bag with products:
     | sku           | qty |
     | 141114        | 1   |
   When customer enters the voucher in the Perks Voucher section on My Bag page
     | voucher_id       |
     | 9930150120702065 |
   Then the customer sees the error message "The voucher you entered is already cancelled" below the voucher input box

  @perks1
 Scenario: Error message when trying to apply voucher, which is already expired, on Bag Page
   And an user "John"
   And a bag with products:
     | sku           | qty |
     | 141114        | 1   |
   When customer enters the voucher in the Perks Voucher section on My Bag page
     | voucher_id       |
     | 9940150120702065 |
   Then the customer sees the error message "The voucher you entered is already expired" below the voucher input box

  @perks2
  Scenario: Apply coupon for product promo
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And the price of product before any promotion is "12.95"
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | autotest_product |
    And the price of product after product promotion applied is "11.95"
    Then the customer sees the message Success "autotest_product" Added! below the voucher input box
    And the customer can see the coupon applied in the Applied codes section
    And the customer can see Remove link against the coupon
    And the order total in the Order Summary section on My Bag page is "17.95"

  @coupon @perks2
  Scenario: Apply coupon for order promo
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 2   |
    And the price of product before any promotion is "25.90"
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id     |
      | autotest_order |
    And the order discount in the Order Summary section on My Bag page is "5.18"
    Then the customer sees the message Success "autotest_order" Added! below the voucher input box
    And the customer can see the coupon applied in the Applied codes section
    And the customer can see Remove link against the coupon
    And the order total in the Order Summary section on My Bag page is "26.72"

  @coupon @perks2
  Scenario: Apply coupon for shipping promo
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And the price of product before any promotion is "38.85"
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_shipping |
    Then the customer sees the message Success "autotest_shipping" Added! below the voucher input box
    And the customer can see the coupon applied in the Applied codes section
    And the customer can see Remove link against the coupon
    And the order total in the Order Summary section on My Bag page is "43.85"

  @coupon @perks2
  Scenario: Error message when apply coupon which is already in the bag
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_shipping |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_shipping |
    Then the customer sees the error message "Already applied in bag" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting empty coupon on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id |
      |            |
    Then the customer sees the error message "Promo code not provided" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting unknown coupon on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id |
      | unknown    |
    Then the customer sees the error message "Promo code not recognised" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting disabled coupon on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_disabled |
    Then the customer sees the error message "Promo code is not currently active" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting a coupon, with inactive promo, on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id              |
      | autotest_disabled_promo |
    Then the customer sees the error message "No active promotions related to coupon code" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting a coupon, for which the product is not qualified, on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 141114 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | autotest_product |
    Then the customer sees the error message "Products not applicable for promotion" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting a coupon, which is already redeemed, on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_redeemed |
    Then the customer sees the error message "Has been redeemed / exceeded overall redemption limit" below the voucher input box

  @coupon @perks2
  Scenario: Error message when submitting a coupon, with maximum redemptions per customer exceeded, on Bag Page
    And an user "Don"
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id                  |
      | autotest_redeemed_customer1 |
    And the customer sees the message Success "autotest_redeemed_customer1" Added! below the voucher input box
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    When the user hits on the Continue to Payment button on the Checkout page
    Then the the user lands on My Bag page with global error message "We've removed the coupon code you entered, as it's been redeemed already / exceeded overall redemption limit"
    And the customer cannot see the voucher applied in the Applied codes section

  @oder_promo @perks2
  Scenario: Apply PERKS voucher and promo codes on My Bag, remove both and verify order total
    And an user "John"
    And a bag with products:
      | sku    | qty |
      | 130664 | 4   |
    And the order total in the Order Summary section on My Bag page is "57.80"
    And customer enters the voucher and coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840150120702065 |
      | autotest_order |
    And the customer can see the voucher and coupon applied in the Applied codes section
    And the customer can see Remove link against the voucher and coupon
    And the order discount in the Order Summary section on My Bag page is "18.36"
    When the customer removes the coupons/vouchers from Bag Page
      | voucher_id       |
      | 9840150120702065 |
      | autotest_order   |
    Then the customer cannot see the vouchers or coupons applied in the Applied codes section
    And the order total in the Order Summary section on My Bag page is "57.80"


