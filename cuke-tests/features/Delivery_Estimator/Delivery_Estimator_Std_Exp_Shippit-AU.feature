Feature: Delivery Estimator - Shippit - COG AU

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

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Tuesday' before cut-off with std/exp delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_13_11_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Fri 16th Aug" for Standard delivery
    And estimated delivery date is displayed as "Est. Tomorrow" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Tuesday' after cut-off with std/exp delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_13_18_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Mon 19th Aug" for Standard delivery
    And estimated delivery date is displayed as "Est. Thu 15th Aug" for Express delivery

  @registered
  Scenario: Verify the estimated delivery date for an order day as 'Tuesday' before cut-off with std/exp delivery mode(registered user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user| landing_page | user_state   |cart_page|
      |COG |AU     |AUsavedaddress |registered  | sign-in      |logged_in    |empty    |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_13_11_30"
    And user clicks the Home Delivery method tab
    Then estimated delivery date is displayed as "Est. Fri 16th Aug" for Standard delivery
    And estimated delivery date is displayed as "Est. Tomorrow" for Express delivery

  @registered
  Scenario: Verify the estimated delivery date for an day as 'Tuesday' after cut-off with std/exp delivery mode(registered user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |cart_page|
      |COG |AU     |AUsavedaddress |registered  |sign-in     |logged_in    |empty    |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_13_18_30"
    And user clicks the Home Delivery method tab
    Then estimated delivery date is displayed as "Est. Mon 19th Aug" for Standard delivery
    And estimated delivery date is displayed as "Est. Thu 15th Aug" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Wednesday' before cut-off with std/exp delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_28_11_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Mon 2nd Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tomorrow" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Wednesday' after cut-off with std/exp delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_28_18_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Tue 3rd Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Fri 30th Aug" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Thursday' before cut-off with std/exp delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_29_11_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Tue 3rd Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tomorrow" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Thursday' after cut-off with std/exp delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_29_18_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Wed 4th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Mon 2nd Sep" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Friday' before cut-off with std delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_30_11_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Wed 4th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Mon 2nd Sep" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Friday' after cut-off with std delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_30_18_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Thu 5th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tue 3rd Sep" for Express delivery


  @registered
  Scenario: Verify the estimated delivery date for an order day as 'Friday' before cut-off with std delivery mode(registered user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |cart_page|
      |COG |AU     |AUsavedaddress |registered  |sign-in     |logged_in    |empty    |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_30_11_30"
    And user clicks the Home Delivery method tab
    Then estimated delivery date is displayed as "Est. Wed 4th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Mon 2nd Sep" for Express delivery

  @registered
  Scenario: Verify the estimated delivery date for an order day as 'Friday' after cut-off with std delivery mode(registered user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |cart_page|
      |COG |AU     |AUsavedaddress |registered  |sign-in     |logged_in    |empty    |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_08_30_18_30"
    And user clicks the Home Delivery method tab
    Then estimated delivery date is displayed as "Est. Thu 5th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tue 3rd Sep" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Sunday' before cut-off with std delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_01_11_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Thu 5th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tue 3rd Sep" for Express delivery

  @guest
  Scenario: Verify the estimated delivery date for an order day as 'Sunday' after cut-off with std delivery mode(guest user)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_01_18_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Thu 5th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tue 3rd Sep" for Express delivery

  @registered
  Scenario: Verify the estimated delivery date for an order day as 'Sunday' before cut-off with std delivery mode(registered user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |cart_page|
      |COG |AU     |AUsavedaddress |registered  |sign-in     |logged_in    |empty    |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_01_11_30"
    And user clicks the Home Delivery method tab
    Then estimated delivery date is displayed as "Est. Thu 5th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tue 3rd Sep" for Express delivery

  @registered
  Scenario: Verify the estimated delivery date for an order day as 'Sunday' after cut-off with std delivery mode(registered user)
    Given I log on to the site with the following:
      |site|country|user           |type_of_user|landing_page|user_state   |cart_page |
      |COG |AU     |AUsavedaddress |registered  |sign-in     |logged_in    |empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_01_18_30"
    And user clicks the Home Delivery method tab
    Then estimated delivery date is displayed as "Est. Thu 5th Sep" for Standard delivery
    And estimated delivery date is displayed as "Est. Tue 3rd Sep" for Express delivery

  @guest
  Scenario: Verify that estimated delivery date is displayed for an order with personalised product
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And I add the following personalised products:
      |       sku     | qty | personalised_message |
      | 9351785851242 |  1  | ms                  |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_01_18_30"
    When "guest" user fills in details for "home" delivery
    Then estimated delivery date is displayed as "Est. Wed 11th Sep" for Personalised delivery

  @guest
  Scenario: Verify that no estimated delivery date is displayed for an order with egift card only
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    When the user navigate to the checkout URL with Order Date and Time as "2019_09_01_18_30"
    Then no estimated delivery date is displayed for "FREE" Email delivery