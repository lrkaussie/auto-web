@SMS_optin_perks_guest
Feature: SMS OPT IN Functionality for Perks Guest user - COG-AU

  As a user I want to check the behaviour of SMS opt in Functionality on checkout page for different types of users
  In AU, we have these products
  | sku           | promo | price | product_promotion_price | order_discount | comments     |
  | 9351785509303 | Y     | 12.95 | 11.95                   | 5.18           |              |
  | 9351785092140 | N     | 49.99 | NA                      | NA             |              |
  | 9351785851327 | N     | 39.95 | NA                      |                | personalised |
  | 9351785851242 | N     | 39.95 | NA                      |                | personalised |
  egift card used : EGIFT DESIGN 02

  Users Used (Perks but not CC):
  lila - cottononqa+lila@gmail.com (SMS opt in as N and No Number)
  lncc1 - cottononqa+lncc1@gmail.com (SMS opt in as N but with Number)
  lncc2 - cottononqa+lncc2@gmail.com (SMS opt in as Y)
  *Returning scenarios covered as basket was persistent in CI env. for guest users unlike registered users.
  #GUEST USER - PERKS MEMBER SCENARIOS

  Scenario: Verify for Guest User, the bluebox UI with the user which has SMS opt in as No and No number
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lila | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    And verify the presence of SMS opt in checkbox in the bluebox is "true"
    And verify the value of phone number field in the bluebox is "+61" on focus

  Scenario: Verify for Guest User, the bluebox UI with the user which has SMS opt in as No and with number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    Then verify the presence of SMS opt in checkbox in the bluebox is "true"
    And verify the masked number in the bluebox is "XXXXXXXX5555"
    And verify the presence of change link in the bluebox is "true"
    And user clicks the change link in the bluebox
    And verify the value of phone number field in the bluebox is "+61" on focus

  Scenario: Verify for Guest User, the bluebox UI with the user which has SMS opt in as yes
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc2 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc2@gmail.com"
    Then verify the presence of SMS opt in checkbox in the bluebox is "false"

  Scenario: Placing HD order after changing the number and sending sms opt in as true with a new number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+61413275638"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Placing HD order after changing the number and sending sms opt in as true with invalid number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+614"
    And an error message as "Please specify a valid mobile number." is displayed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | false                    |

  Scenario: Placing CNC order after clicking change link of the number but sending sms opt in as true without any number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as ""
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED    | AUTHORISATION | NA         | "sms_opt_in":true | false                    |

  Scenario: Placing HD mixed cart order after changing the number but sending sms opt in as false with a new number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And the user navigates to PDP of the product "9354233660489"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+61413275638"
    And user checks the SMS opt in checkbox for "Perks" user
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED    | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order after changing the number but sending sms opt in as false and with no number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as ""
    And user checks the SMS opt in checkbox for "Perks" user
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order by adding a valid number with sms opt in as yes for a user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lila | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    And user enters the mobile number in the bluebox as "+61413275638"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Placing CNC order by adding invalid number with sms opt in as yes for a user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lila | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    And user enters the mobile number in the bluebox as "+61413"
    And an error message as "Please specify a valid mobile number." is displayed
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC            |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order by adding NO number with sms opt in as yes for a user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lila | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    And user enters the mobile number in the bluebox as ""
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |

  Scenario: Returning and placing HD order for a user which has SMS opt in as No but had number at first
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+61413275638"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
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
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED    | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Returning and placing CNC order for a user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lila | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    And user enters the mobile number in the bluebox as "+61413275638"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "CNC" details
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lila" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Returning (unchecking the SMS opt in) and placing HD order for a user which has SMS opt in as No but had number at first
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page       | user_state    |
      | COG  | AU      | Lncc1 | guest        | 9351785092140.html | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lncc1@gmail.com"
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+61413275638"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user checks the SMS opt in checkbox for "Perks" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lncc1" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |