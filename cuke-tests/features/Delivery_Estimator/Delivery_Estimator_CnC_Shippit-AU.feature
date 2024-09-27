Feature: Delivery Estimator - CnC - Shippit - COG AU

  Assumption
  BM Configuration:
  *The site preference are in the Delivery_Estimator group, feature toggles and Shippit service auth token.
  *CnC Shipping method custom attributes:*
  a. dcProcessingTime - DC processing time in hours
  The current config on CI is 72
  b. cutoffTime - 0-23 hour of the day.
  The current config on CI is 12
  c. carrierDeliveryMode - New field for service level to map to Shippit quote response entries, pre-defined values (standard)
  d. shippingMethodNamePrefix - Used to prefix the shipping method name in the checkout, UI only. Not changed in this implementation.
  e. Shippit delivery days are returned by a job and get filled up for each store which set as Yes for CnC active and Is CnC.
     The shippit days return value for stores under test have been pre-filled as follows:
     a. Geelong Store, PC: 3220 and Store_id: 3002 -- 3 days.
     b. Werribee store, PC: 3030 and Store_id: 3074 -- 2 days.
  f. The CnC shipping method price is set as 0 to have free text for delivery estimated date.
  *Order custom attributes:*
  a. estimatedDeliveryDate - Final estimated delivery date, displayed to the customer. ISO date string.
  b. carrierEstimatedDelivery - Shippit delivery estimate response used for this order, will be used mainly for monitoring and debugging.
  NOTE: You can monitor the estimated delivery calculations in the “custom-DeliveryEstimator-*” log file.
  NOTE: The format of order date and time in the url is as "Order Date(yyyy_mm_dd) and Time(hh_mm)".

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Tuesday' before cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_03_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Tue 10th Sep - FREE"

  @registered
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Tuesday' before cut-off for Geelong store
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_03_11_30"
    When "registered" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Wed 11th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Tuesday' after cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_03_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Wed 11th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Tuesday' after cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_03_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Thu 12th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Wednesday' before cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_04_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Wed 11th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Wednesday' before cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_04_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Thu 12th Sep - FREE"

  @registered
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Wednesday' after cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |cart_page |
      |COG |AU     |AUsavedaddress |registered |sign-in     |logged_in    | empty |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_04_18_30"
    When "registered" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Wed 11th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Wednesday' after cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_04_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Thu 12th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Thursday' before cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_05_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Wed 11th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Thursday' before cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_05_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Thu 12th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Thursday' after cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_05_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Wed 11th Sep - FREE"

  @registered
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Thursday' after cut-off for Geelong store
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Don  | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_05_18_30"
    When "registered" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Thu 12th Sep - FREE"

  @registered
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Friday' before cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |cart_page |
      |COG |AU     |AUsavedaddress |registered |sign-in     |logged_in    | empty |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_06_11_30"
    When "registered" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Wed 11th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Friday' before cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_06_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Thu 12th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Friday' after cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_06_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Thu 12th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Friday' after cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_06_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Fri 13th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Saturday' before cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_07_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Thu 12th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Saturday' before cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_07_11_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Fri 13th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Saturday' after cut-off for Werribee store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |AUsavedaddress |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_07_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3074" is displayed as "Est. Fri 13th Sep - FREE"

  @guest
  Scenario: Verify the estimated delivery date for a CNC order being placed on 'Saturday' after cut-off for Geelong store
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And the user navigate to the checkout URL with Order Date and Time as "2019_09_07_18_30"
    When "guest" user fills in details for "cnc" delivery
    Then estimated delivery date for the CnC store with store id as "3002" is displayed as "Est. Mon 16th Sep - FREE"