@SMS_optin_perks_registered
Feature: SMS OPT IN Functionality for Perks Registered user - COG-AU

  As a user I want to check the behaviour of SMS opt in Functionality on checkout page for different types of users
  In AU, we have these products
  | sku           | promo | price | product_promotion_price | order_discount | comments     |
  | 9351785509303 | Y     | 12.95 | 11.95                   | 5.18           |              |
  | 9351785092140 | N     | 49.99 | NA                      | NA             |              |
  | 9351785851327 | N     | 39.95 | NA                      |                | personalised |
  | 9351785851242 | N     | 39.95 | NA                      |                | personalised |
  egift card used : EGIFT DESIGN 02

  Users Used (Perks but not CC):
  Sophia - cottononqa+sophia@gmail.com (SMS opt in as N and No Number)
  Lynn - cottononqa+lynn@gmail.com (SMS opt in as N but with Number)
  Julia - cottononqa+julia@gmail.com (SMS opt in as Y)
  *Return scenarios couldn't cover as the basket for registered users is not persistent in CI environment.
  #REGISTERED USER - PERKS MEMBER SCENARIOS

  Scenario: Verify for Registered User, the bluebox UI with the user which has SMS opt in as No and No number
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And verify the presence of SMS opt in checkbox in the bluebox is "true"
    And verify the value of phone number field in the bluebox is "+61" on focus

  Scenario: Verify for registered User, the bluebox UI with the user which has SMS opt in as No and with number
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    When checkout button is pressed
    Then verify the presence of SMS opt in checkbox in the bluebox is "true"
    And verify the masked number in the bluebox is "XXXXXXXX5555"
    And verify the presence of change link in the bluebox is "true"
    And user clicks the change link in the bluebox
    And verify the value of phone number field in the bluebox is "+61" on focus

  Scenario: Verify for registered User, the bluebox UI with the user which has SMS opt in as yes
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Julia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    When checkout button is pressed
    Then verify the presence of SMS opt in checkbox in the bluebox is "false"

  Scenario: Placing HD order after changing the number and sending sms opt in as true with a new number for registered user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+61413275638"
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lynn" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Placing HD order after changing the number and sending sms opt in as true with invalid number for registered user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+614"
    And an error message as "Please specify a valid mobile number." is displayed
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lynn" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | false                    |

  Scenario: Placing CNC order after clicking change link of the number but sending sms opt in as true without any number for registered user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as ""
    And "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lynn" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | false                    |

  Scenario: Placing HD mixed cart order after changing the number but sending sms opt in as false with a new number for registered user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as "+61413275638"
    And user checks the SMS opt in checkbox for "Perks" user
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lynn" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED    | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order after changing the number but sending sms opt in as false and with no number for registered user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user clicks the change link in the bluebox
    And user enters the mobile number in the bluebox as ""
    And user checks the SMS opt in checkbox for "Perks" user
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Lynn" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order by adding a valid number with sms opt in as yes for a registered user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user enters the mobile number in the bluebox as "+61413275638"
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Sophia" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in        | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | "sms_opt_in":true | true                     |

  Scenario: Placing CNC order by adding invalid number with sms opt in as yes for a registered user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And user enters the mobile number in the bluebox as "+61413"
    And an error message as "Please specify a valid mobile number." is displayed
    And "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Sophia" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |

  Scenario: Placing HD order by adding NO number with sms opt in as yes for a registered user which has SMS opt in as No and No number at first
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    And user enters the mobile number in the bluebox as ""
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Sophia" is:
      | order_status | adyen_status| eventcode     | authResult | sms_opt_in | mobile_number_validation |
      | OPEN         | APPROVED   | AUTHORISATION | NA         | false      | false                    |