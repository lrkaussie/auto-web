@cash_on_delivery @my
Feature: Disallow CashOnDelivery on checkout page for CnC and egift card - COG-MY
  As a user I should not be able to place order with COD if CnC or egift card is selected in the cart

Assumption:
  In MY, we have these products
  | Colour     |  SKU          | Size | Type        | Product Type |
  | 2000310-01 | 9350486746666 | S    | Multi size  | Normal       |
  | 000121-01  | 9354233659087 | NA   | NA          | egift card   |

  The following users exist in Commerce Cloud and used for registered user scenarios
  | Email               | First Name | Last Name | Commerce Cloud Account | User    |
  | adam.amin@email.com | Adam       | Amin      | Yes                    | Adam    |
  | adam.amin@email.com | Adam       | Amin      | Yes                    | Adam_AU |

  @guest
  Scenario: Cash on Delivery not available for CnC order on Checkout page
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And I select "CNC" on the checkout page
    And "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "cash_on_delivery"
    Then the "error message" is displayed on Checkout page below Cash On Delivery payment method
    | error_message                                                            |
    | Sorry, Cash On Delivery is not currently available with Click & Collect. |
    | Please change your payment or delivery method.                           |

  @guest
  Scenario: Global error message is displayed on checkout page when try placing order with Cash on Delivery and CnC
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And I select "CNC" on the checkout page
    And "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD"
    Then the user is presented with the error message "Sorry, Cash On Delivery is not currently available with Click & Collect. Please change your payment or delivery method." on the checkout global overlay


  @guest
  Scenario: Cash on Delivery not available for international delivery method on checkout page
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And user selects the payment type as "cash_on_delivery"
    Then the "error message" is displayed on Checkout page below Cash On Delivery payment method
    | error_message                                                                   |
    | Sorry, Cash On Delivery is not currently available with International Delivery. |
    | Please change your payment method.                                              |

  @guest
  Scenario: Global error message is displayed on checkout page when try placing order with international delivery and COD
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam_AU  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then the user is presented with the error message "Sorry, Cash On Delivery is not currently available with International Delivery. Please change your payment method." on the checkout global overlay

  @guest
  Scenario: Cash on Delivery not available for egift card order on checkout page
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9354233659087"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And "guest" user fills in details for "email" delivery
    And user selects the payment type as "cash_on_delivery"
    Then the "error message" is displayed on Checkout page below Cash On Delivery payment method
    | error_message                                                        |
    | Sorry, Cash On Delivery is not currently available for E-Gift Cards. |
    | Please change your payment or delivery method.                       |

  @guest
  Scenario:  Global error message is displayed on checkout page when try placing order with egift card and COD
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9354233659087"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And "guest" user fills in details for "email" delivery
    And "guest" user fills in billing address details for "cod"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then the user is presented with the error message "Sorry, Cash On Delivery is not currently available for E-Gift Cards. Please change your payment or delivery method." on the checkout global overlay


  @guest
  Scenario: Cash on Delivery not available for mixed cart with egift card order on checkout page
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And the user navigates to PDP of the product "9354233659087"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    And user selects the payment type as "cash_on_delivery"
    Then the "error message" is displayed on Checkout page below Cash On Delivery payment method
    | error_message                                                        |
    | Sorry, Cash On Delivery is not currently available for E-Gift Cards. |
    | Please change your payment or delivery method.                       |

  @registered
  Scenario:  Global error message is displayed on checkout page when try placing order with mixed cart with egift card and COD for registered user
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | registered        | sign-in      | logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And the user navigates to PDP of the product "9354233659087"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then the user is presented with the error message "Sorry, Cash On Delivery is not currently available for E-Gift Cards. Please change your payment or delivery method." on the checkout global overlay

  @registered
  Scenario: Cash on Delivery not available for CnC order on Checkout page for registered user
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | MY      | Adam  | registered   | sign-in      | logged_in  |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And I select "CNC" on the checkout page
    And "registered" user fills in details for "cnc" delivery
    And user selects the payment type as "cash_on_delivery"
    Then the "error message" is displayed on Checkout page below Cash On Delivery payment method
    | error_message                                                            |
    | Sorry, Cash On Delivery is not currently available with Click & Collect. |
    | Please change your payment or delivery method.                           |