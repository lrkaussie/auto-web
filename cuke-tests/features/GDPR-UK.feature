@gdpr @uk

Feature: EU Data Protection Regulations - COG-UK
  As a user I want to check the GDPR (FPN)details on various places for the website

  In UK, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|
  | 9351785092140 | N     | 30.00 |NA                     |NA            |


  @valid @guest
  Scenario: Display FPN on the checkout page for guest user
    Given I am on country "UK"
    And site is "COG"
    And an user "Tony"
    And cart is "Standard cart"
    Then the FPN display is seen on the checkout page:
    |message_line_1|message_line_2|
    |  EU Data Protection Regulations (GDPR)     |We take your privacy seriously. Please refer to our Privacy Policy.|
    And the privacy policy link when expanded shows detailed description


  @valid @registered
  Scenario: Display FPN on the checkout page for registered user
    Given I am on country "UK"
    And site is "COG"
    And an user "Alec"
    And cart is "Standard cart"
    And an user "Alec" navigates to the checkout
    Then the FPN display is seen on the checkout page:
      |message_line_1|message_line_2|
      |  EU Data Protection Regulations (GDPR)     |We take your privacy seriously. Please refer to our Privacy Policy.|
    And the privacy policy link when expanded shows detailed description


  @valid @emailHidden
  Scenario: Remove the textbox to enter email address against Join button in Typo home page
    Given I am on the Cotton On Home Page
    And I am on country "UK"
    And site is "COG"
    Then the textbox to enter email is "hidden"
    And Join button is visible

  @valid @slideDialogHiddenEmail
  Scenario: Hide textbox for email input in the sliding popup on home page
    Given I am on the Cotton On Home Page
    And I am on country "UK"
    And site is "COG"
    And sliding popup is click
    Then the textbox to enter email is "hidden"
    And Join button is visible

  @valid @nonUKsite
  Scenario: The text box for email sign up is still available in all other sites others than Typo UK
    Given I am on the Cotton On Home Page
    And I am on country "AU"
    And site is "COG"
    And sliding popup is click
    Then the textbox to enter email is "visible"
    And Join button is visible

  @valid @nonUKSiteEmailVisible
  Scenario: Remove the textbox to enter email address against Join button in Typo home page
    Given I am on the Cotton On Home Page
    And I am on country "AU"
    And site is "COG"
    Then the textbox to enter email is "visible"
    And Join button is visible



