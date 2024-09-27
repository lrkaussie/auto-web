@SMS_optin_notperks_registered
Feature: SMS OPT IN Functionality for Not a Perks user- COG-AU

  As a user I want to check the behaviour of SMS opt in Functionality on checkout page for different types of users
  In AU, we have these products
  | sku           | promo | price | product_promotion_price | order_discount | comments     |
  | 9351785509303 | Y     | 12.95 | 11.95                   | 5.18           |              |
  | 9351785092140 | N     | 49.99 | NA                      | NA             |              |
  | 9351785851327 | N     | 39.95 | NA                      |                | personalised |
  | 9351785851242 | N     | 39.95 | NA                      |                | personalised |

  Users Used (Not a perks but CC):
  Jesse cottononqa+jesse@gmail.com
  egift card used : EGIFT DESIGN 02

  Scenario: Verify for Registered User, the SMS opt in check box and mobile number field in bluebox is only available when Join perks is selected
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    And verify the presence of SMS opt in checkbox in the bluebox is "true"
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And verify the value of phone number field in the bluebox is "+61" on focus

  Scenario: Placing HD order with registered user with SMS opted in as yes and with mobile number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as "+61413275638"
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED    | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Placing CNC order with registered user with SMS opted in as yes and with mobile number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as "+61413275638"
    And "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED    | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Placing mixed cart HD order with registered user with SMS opted in as yes and with mobile number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as "+61413275638"
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                    |

  Scenario: Placing HD order as registered user with SMS opted in as yes and invalid mobile number
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as "+614032"
    And an error message as "Please specify a valid mobile number." is displayed
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order as registered user with SMS opted in as yes and blank mobile field
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as ""
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in |mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      |false                    |


  Scenario: Placing HD order as registered user with SMS opted in as yes first with valid mobile number and then unchecking the sms opt in
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as "+61432345656"
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in |mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false       |false                    |

  Scenario: Returning Scenario with joining perks but not checking SMS opt in on return and then placing order successfully without changing anything on return
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user enters the mobile number in the bluebox as "+61432345656"
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status | eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Returning Scenario with joining perks and checking SMS opt in at first go and then placing order successfully by unchecking the SMS opt in only on return
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status | eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | false      | false                    |

  Scenario: Returning Scenario with joining perks and checking SMS opt in at first go and then placing order successfully by not joining the perks on return
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jesse | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And user checks the SMS opt in checkbox for "Non perks registered" user
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user selects "Top Back"
    Then user is taken back to checkout page with "HD" details
    And user selects the join perks checkbox
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Jesse" is:
      | order_status | adyen_status | eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED     | AUTHORISATION | NA         | false      | false                    |