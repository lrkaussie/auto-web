@SMS_optin_notperks_guest
Feature: SMS OPT IN Functionality for Not a Perks Guest user - COG-AU

  As a user I want to check the behaviour of SMS opt in Functionality on checkout page for different types of users
  In AU, we have these products
  | sku           | promo | price | product_promotion_price | order_discount | comments     |
  | 9351785509303 | Y     | 12.95 | 11.95                   | 5.18           |              |
  | 9351785092140 | N     | 49.99 | NA                      | NA             |              |
  | 9351785851327 | N     | 39.95 | NA                      |                | personalised |
  | 9351785851242 | N     | 39.95 | NA                      |                | personalised |

  Users Used (Not a perks and not CC):
  Monica - cottononqa+monica@gmail.com
  Monique - cottononqa+monique@gmail.com
  *Returning scenarios covered as basket was persistent in CI env. for guest users unlike registered users.
  #GUEST USER - NON PERKS MEMBER SCENARIOS

  @non-perks @guest
  Scenario: Verify for Guest User, the SMS opt in check box is only available when Join perks is selected
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monique | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monique@gmail.com"
    And verify the presence of SMS opt in checkbox is "false"
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    And verify the presence of SMS opt in checkbox is "true"

  Scenario: Validating mobile number feld country code on the checkout page
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monica | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    And I validate the default country code value as '+61'

  Scenario: Validating the error message for the mobile number field min length on the checkout page with country code
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monique | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monique@gmail.com"
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    Then validate the error message as "Please specify a valid mobile number." is displayed for the mobile number field on entering number as "9976" for "minimum length validation with country code"

  Scenario: Validating the error message for the mobile number field min length on the checkout page without county code
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monica | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    Then validate the error message as "Please enter at least 6 characters" is displayed for the mobile number field on entering number as "999" for "minimum length validation without country code"

  Scenario: Placing HD order with SMS opted in as yes and with mobile number with country code
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monica | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And user selects the join perks checkbox
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Monica" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | phone_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                    |

  Scenario: Placing CNC order with SMS opted in as yes and with mobile number with country code
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Monica | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 |  1  |
    And the order total in the Order Summary section on My Bag page is "55.99"
    And user selects to checkout from their bag
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And user selects the join perks checkbox
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Monica" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | phone_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                    |


  Scenario: Returning Scenario with joining perks but not checking SMS opt in on return and then placing order successfully without changing anything on return
#    due to defect CO-5517
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monique| guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monique@gmail.com"
    And user selects the join perks checkbox
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Monique" is:
      | order_status | adyen_status | eventcode     | authResult | sms_opt_in        | phone_number_validation |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | "sms_opt_in":true | true                    |

  Scenario: Returning Scenario with joining perks and checking SMS opt in at first go and then placing order successfully by unchecking the SMS opt in only on return
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monica | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And user selects the join perks checkbox
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the join perks checkbox
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Monica" is:
      | order_status | adyen_status | eventcode     | authResult | sms_opt_in | phone_number_validation |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | false      | false                   |

  Scenario: Returning Scenario with joining perks and checking SMS opt in at first go and then placing order successfully by not joining the perks on return
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Monica | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And user selects the join perks checkbox
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user checks the SMS opt in checkbox for "Non perks guest" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Monica" is:
      | order_status | adyen_status | eventcode     | authResult | sms_opt_in | phone_number_validation |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | false      | false                   |