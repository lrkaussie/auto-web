Feature: Delivery Estimator - PDP - Shippit - COG AU

  Assumption
  BM Configuration:
  *The site preference are in the Delivery_Estimator group, feature toggles and Shippit service auth token.
  *Shipping methods custom attributes:*
  a. dcProcessingTime - DC processing time in hours
  The current config on CI for Std = 0 and express = 0
  b. cutoffTime - 0-23 hour of the day.
  The current config on CI for Std = 12 and express = 18
  c. carrierDeliveryMode - New field for service level to map to Shippit quote response entries, pre-defined values (standard and express)
  d. shippingMethodNamePrefix - Used to prefix the shipping method name in the checkout, UI only. Not changed in this implementation.
  e. Shippit delivery days returned by Mock on CI env. are as for Std = 3 and Exp = 1
  *Order custom attributes:*
  a. estimatedDeliveryDate - Final estimated delivery date, displayed to the customer. ISO date string.
  b. carrierEstimatedDelivery - Shippit delivery estimate response used for this order, will be used mainly for monitoring and debugging.
  NOTE: You can monitor the estimated delivery calculations in the “custom-DeliveryEstimator-*” log file.
  NOTE: The format of order date and time in the url is as "Order Date(yyyy_mm_dd) and Time(hh_mm)".

  In Au, we have these products
  | SKU           | Size | Type            |
  | 9351785092140 | NA   | single size     |
  | 9351533119198 | NA   | single size     |
  | 9350486006111 | NA   | Multiple size   |
  | 9354233660489 | NA   |  Egift          |
  | 9351785851327 |NA    | Personalised    |


  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Tuesday' before cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_13_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Fri 16th Aug" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tomorrow" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Tuesday' after cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_13_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Mon 19th Aug" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Thu 15th Aug" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @registered
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Tuesday' before cut-off for registered user
    Given I log on to the site with the following:
      |site|country|user          |type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress|registered |sign-in     |logged_in    |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_13_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Fri 16th Aug" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tomorrow" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @registered
  Scenario:Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Tuesday' after cut-off for registered user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |registered |sign-in     |logged_in    |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_13_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Mon 19th Aug" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Thu 15th Aug" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Wednesday' before cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_28_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Mon 2nd Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tomorrow" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Wednesday' after cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_28_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Fri 30th Aug" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Thursday' before cut-off  for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_29_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tomorrow" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Thursday' after cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_29_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Wed 4th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Mon 2nd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario:Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as'Friday' before cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_30_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Wed 4th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Mon 2nd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Friday' after cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_30_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"


  @registered
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Friday' before cut-off for registered user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |registered |sign-in     |logged_in    |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_30_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Wed 4th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Mon 2nd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @registered
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Friday' after cut-off for registered user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |registered |sign-in     |logged_in    |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_08_30_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Sunday' before cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Sunday' after cut-off for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @registered
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Sunday' before cut-off for registered user
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |registered  |sign-in     |logged_in    |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_11_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @registered
  Scenario: Verify the correct estimated delivery dates are displayed on PDP of a normal product with day and date as 'Sunday' after cut-off for registered user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |registered |sign-in     |logged_in    |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify that correct personalised estimated delivery date is displayed on PDP of a personalised product
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785851327" with Date and Time as "2019_09_01_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Wed 11th Sep" for "Personalised Delivery"
    And price for "Personalised Delivery" is displayed as "$10.00"

  @guest
  Scenario: Verify delivery section is expanded by default on navigating to another pdp.
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351785092140"
    When I search for the postcode as "3029"
    And the user navigates to PDP of the product "9351785851327"
    Then "Change" text should be displayed on the pdp under "Delivery Estimator"

  @guest
  Scenario: Verify lastly visited (Delivery section)is expanded by default on navigating to another pdp.
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351785092140"
    And I select my preferred store as "GEELONG" and store code is "3002"
    When I search for the postcode as "3029"
    And the user navigates to PDP of the product "9350486006111"
    Then "Change" text should be displayed on the pdp under "Delivery Estimator"

  @guest
  Scenario: Verify lasty visited (cnc section)is expanded by default on navigating to another pdp.
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351785092140"
    When I search for the postcode as "3029"
    And I select my preferred store as "GEELONG" and store code is "3002"
    And the user navigates to PDP of the product "9350486006111"
    Then "Change" text should be displayed on the pdp under "cnc"

  @guest
  Scenario: Verify that delivery estimator dates are displayed correctly when only egift is in the cart
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_18_30"
    When I search for the postcode as "3029"
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_18_30"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"

  @guest
  Scenario: Verify that delivery estimator dates are displayed correctly when egift and normal product is in the cart
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigates to PDP of the product "9351533119198"
    And the user clicks on Add to Bag from the PDP
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"


  @guest
  Scenario: Verify that delivery estimator dates are displayed correctly when a mixed cart is created with egift, normal and personalised products
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigates to PDP of the product "9351533119198"
    And the user clicks on Add to Bag from the PDP
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351785851327 |  1  |XX                  |
    And the user navigate to the PDP URL of the product as "9351785092140" with Date and Time as "2019_09_01_18_30"
    When I search for the postcode as "3029"
    Then estimated delivery date on PDP is displayed as "Est. Thu 5th Sep" for "Standard Delivery"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"
    And the user navigate to the PDP URL of the product as "9351785851327" with Date and Time as "2019_09_01_18_30"
    And estimated delivery date on PDP is displayed as "Est. Wed 11th Sep" for "Personalised Delivery"
    And price for "Personalised Delivery" is displayed as "$10.00"
    And the user navigate to the PDP URL of the product as "9351533119198" with Date and Time as "2019_09_01_18_30"
    And price for "Standard Delivery" is displayed as "FREE"
    And estimated delivery date on PDP is displayed as "Est. Tue 3rd Sep" for "Express Delivery"
    And price for "Express Delivery" is displayed as "$7.00"
    And estimated delivery date on PDP is displayed as "Melbourne Metro Same Day" for "Melbourne Metro"
    And price for "Melbourne Metro" is displayed as "$15.00"
