Feature: Applying Promocodes and vouchers scenarios on checkout page for US

  As a Cotton On business, I want to provide customers with the ability to apply both promocodes and vouchers on checkout page
  Assumption:-
  The following users exist in CC with Perks account status in RMS:-

  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account |
  | cottononqa+USnick1@gmail.com  | Nick       | US        | Yes                    | No            |
  | cottononqa+USmatt@gmail.com   | Matt       | US        | Yes                    | No            |
  | cottononqa+USsteve@gmail.com  | Steve      | US        | Yes                    | Yes           |
  | cottononqa+USfilip@gmail.com  | Filip      | US        | Yes                    | No            |
  | cottononqa+USvincy@gmail.com  | Vincy      | US        | No                     | Yes           |
  | cottononqa+UShima@gmail.com   | Hima       | US        | No                     | No            |
  | cottononqa+USMyAcc@gmail.com  | My Acc     | US        | Yes                    | Yes           |

  Steve US has the following vouchers in RMS:-
  | voucher_id       | reward_type          | value | redeemed | days_since_expired |
  | 984              | Perks Payday Voucher | $10   | yes      |                    |
  | 984              | Perks Payday Voucher | $10   | no       | 10                 |
  | 9840000000000003 | Perks Payday Voucher | $10   | no       |                    |
  | 9840000000000004 | Perks Payday Voucher | $10   | no       |                    |
  | 9840000000000005 | Perks Payday Voucher | $10   | no       |                    |

  My Acc US has the following vouchers in RMS:-
  | voucher_id       | reward_type            | value | redeemed | days_since_expired |
  | 9500000000000005 | Perks Welcome Voucher  | $10   | no       |                    |
  | 9400000000000004 | Perks Birthday Voucher | $10   | no       |                    |
  | 9840000000000002 | Perks Payday Voucher   | $10   | no       |                    |
  | 9840000000000003 | Perks Payday Voucher   | $10   | no       |                    |
  It also has a payday voucher(984 prefix) expiring today.
  Myacc also has a payday voucher(984 prefix) which is already presented in RMS and therefore locked.
  NOTE: The error scenarios for promos applied on Co page are done in AU are present in checkout-AU feature file

  @coupon_CO
  Scenario: Validate the functionality of applying product promotion on checkout page for guest user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And order total on checkout page "before" promotion applied is "188.74"
    And the product price "before" product promotion applied is "169.99"
    Then promo or voucher is applied on the Checkout page
      | promos_vouchers  |
      | autotest_product |
    Then the customer sees the success message "Success 'autotest_product' Added!" below the voucher input box on Checkout page
    And the product price "after" product promotion applied is "168.99"
    And order total on checkout page "after" promotion applied is "187.66"
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And tax amount is "12.67"

  @coupon_CO
  Scenario: Validate the functionality of applying order promotion on checkout page for registered user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state |
      |COG |US     |Thomas|registered  |sign-in     |logged_in  |
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "registered" user fills in details for "cnc" delivery
    And order total on checkout page "before" promotion applied is "15.88"
    When promo or voucher is applied on the Checkout page
      | promos_vouchers |
      | autotest_order  |
    Then the customer sees the success message "Success 'autotest_order' Added!" below the voucher input box on Checkout page
    And the "order" discount applied is "2.60"
    And order total on checkout page "after" promotion applied is "13.10"
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And tax amount is "0.71"

  @coupon_CO
  Scenario: Validate the functionality of applying shipping promotion on checkout page for guest user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And order total on checkout page "before" promotion applied is "188.74"
    When promo or voucher is applied on the Checkout page
      | promos_vouchers   |
      | autotest_shipping |
    Then the customer sees the success message "Success 'autotest_shipping' Added!" below the voucher input box on Checkout page
    And order total on checkout page "after" promotion applied is "187.74"
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And tax amount is "12.75"

  @coupon_CO
  Scenario: Validate the functionality of applying product promotion and voucher on checkout page for guest user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |US     |Steve|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And order total on checkout page "before" promotion applied is "185.00"
    And the product price "before" product promotion applied is "169.99"
    Then promo or voucher is applied on the Checkout page
      | promos_vouchers  |
      | autotest_product |
      | 9840000000000003 |
    And the "order" discount applied is "10.00"
    And the product price "after" product promotion applied is "168.99"
    And order total on checkout page "after" promotion applied is "173.42"
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And tax amount is "8.43"

  @coupon_CO
  Scenario: Validate the functionality of applying order promotion and voucher on checkout page for registered user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state |
      |COG |US     |Steve|registered  |sign-in     |logged_in  |
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "registered" user fills in details for "cnc" delivery
    And order total on checkout page "before" promotion applied is "15.88"
    When promo or voucher is applied on the Checkout page
      | promos_vouchers  |
      | autotest_order   |
      | 9840000000000003 |
    Then the "order" discount applied is "10.60"
    And order total on checkout page "after" promotion applied is "4.55"
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And tax amount is "0.16"

  @coupon_CO
  Scenario: Validate the functionality of applying shipping promotion and voucher on checkout page for guest user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |US     |Steve|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And order total on checkout page "before" promotion applied is "185.00"
    When promo or voucher is applied on the Checkout page
      | promos_vouchers   |
      | autotest_shipping |
      | 9840000000000003  |
    Then the "order" discount applied is "10.00"
    And order total on checkout page "after" promotion applied is "173.47"
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And tax amount is "8.48"

  @coupon_CO
  Scenario: Validate the functionality of applying and removing shipping promotion and voucher on checkout page for guest user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |US     |Steve|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 4   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 60.71       | 6.00     |
    When promo or voucher is applied on the Checkout page
      | promos_vouchers        |
      | autotest_free_shipping |
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 54.71       | FREE     |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840000000000003 |
    Then promo code and perks voucher section displays "vouchers" as:
      | promos_vouchers  |
      | 9840000000000003 |
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 50.18       | 6.00     |
    And the "order" discount applied is "10.00"
    And I remove the "vouchers" from CO page
      | promos_vouchers  |
      | 9840000000000003 |
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 54.71       | FREE     |
    Then promo code and perks voucher section displays "promo codes" as:
      | promos_vouchers        |
      | autotest_free_shipping |

  @coupon_CO
  Scenario: Error message when trying to apply voucher when the min. spend threshold is not met on Checkout Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |US     |Steve|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | autotest_product |
      | 9840000000000003 |
      | 9840000000000004 |
    Then the customer sees the error message "Please spend 10 to qualify for use of your Perks Reward." below the voucher input box on Checkout page

  @coupon_CO
  Scenario: The promo codes and perks voucher applied on My Bag are displayed correctly on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |US     |Steve|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And customer enters the voucher and coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | 9840000000000003 |
      | autotest_order   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    Then promo code and perks voucher section displays "both" as:
      | promos_vouchers  |
      | 9840000000000003 |
      | autotest_order   |
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 8.52        | 6.00     |

  @coupon_CO
  Scenario: Validate the functionality of retaining data on CO page once returned from payment page for guest user
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | US      | Steve | guest        | sign-in      | not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And order total on checkout page "before" promotion applied is "185.00"
    And the product price "before" product promotion applied is "169.99"
    And promo or voucher is applied on the Checkout page
      | promos_vouchers  |
      | autotest_product |
      | 9840000000000003 |
    And the "order" discount applied is "10.00"
    And the product price "after" product promotion applied is "168.99"
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And I click on browser back button
    Then promo code and perks voucher section displays "both" as:
      | promos_vouchers  |
      | 9840000000000003 |
      | autotest_product |
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 173.42      | 6.00     |
    Then I validate the selected delivery method:
      | selected_delivery_method                                             |
      | Standard Shipping (US)USD 6.00FREE on orders over $55 - UPS SurePost |

  @coupon_CO
  Scenario: Validate the functionality of free gift promotion on CO page for guest user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |US     |Steve|guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku       | qty |
      | 417871-12 | 1   |
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 42.80       | 6.00     |
    And promo or voucher is applied on the Checkout page
      | promos_vouchers |
      | GiftBonus       |
    And the customer sees the error message "Return to the bag page to choose your bonus product" below the voucher input box on Checkout page
    And user clicks on bonus product message
    Then user should navigate to the bag page with "Select Your Free Gift" carousel displayed
    And user adds the product from the free gift carousel
    And checkout button is pressed
    When "guest" user fills in details for "home" delivery
    And promo code and perks voucher section displays "promo codes" as:
      | promos_vouchers |
      | GiftBonus       |
    And I validate the order summary section in checkout page:
      | order_total | delivery |
      | 42.80       | 6.00     |

