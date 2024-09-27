@checkout @au
Feature: Checkout page - COG-AU

  As a user I want to check the behaviour of checkout page
  In AU, we have these products
  | sku           | promo | price |product_promotion_price|order_discount|comments    |
  | 9351785509303 | Y     | 12.95 |11.95                  |5.18          |            |
  | 9351785092140 | N     | 49.99 |NA                     |NA            |            |
  | 9351785851327 | N     | 39.95 |NA                     |              |personalised|
  | 9351785851242 | N     | 39.95 |NA                     |              |personalised|

  default shipping is $6
  HD is $6, cnc is $3

  @perf @guest
  Scenario: Automatic selection of shipping method as CnC when navigated from PDP to Checkout page for the first time with CnC store selected on PDP
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9351785092140"
    And I select my preferred store as "GEELONG" and store code is "3002"
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    When checkout button is pressed
    Then I see that the default delivery is "Home Delivery" on Checkout page

  @perf @guest
  # add @perf tag back once the issue on dev env is resolved due to which it is blocked
  Scenario: Automatic selection of shipping method as CnC when Navigating back from Checkout page to My bag page (changing from HD to CnC on CO page)
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9351785509303"
    And I select my preferred store as "GEELONG" and store code is "3002"
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And checkout button is pressed
    When I select "CNC" on the checkout page
    And user navigates to "bag" page
    Then I validate mybag page:
      |delivery|
      |Click & Collect|

  @coupon_CO
  Scenario: Error message when apply coupon on CO page which is already in the bag
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_shipping |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    And promo or voucher is applied on the Checkout page
      | promos_vouchers   |
      | autotest_shipping |
    Then the customer sees the error message "Already applied in bag" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting empty coupon on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers |
      |                 |
    Then the customer sees the error message "Promo code not provided" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting unknown coupon on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers |
      | unknown         |
    Then the customer sees the error message "Promo code not recognised" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting disabled coupon on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers   |
      | autotest_disabled |
    Then the customer sees the error message "Promo code is not currently active" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting a coupon, with inactive promo, on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers         |
      | autotest_disabled_promo |
    Then the customer sees the error message "No active promotions related to coupon code" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting a coupon, for which the product is not qualified, on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 141114 | 1   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers  |
      | autotest_product |
    Then the customer sees the error message "Products not applicable for promotion" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting a coupon, which is already redeemed, on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers   |
      | autotest_redeemed |
    Then the customer sees the error message "Has been redeemed / exceeded overall redemption limit" below the voucher input box on Checkout page

  @coupon_CO
  Scenario: Error message when submitting a coupon, with maximum redemptions per customer exceeded, on CO Page
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state   |
      |COG |AU     |Don  |guest       |sign-in     |not_logged_in|
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    And checkout button is pressed
    And "guest" user fills in details for "home" delivery
    When promo or voucher is applied on the Checkout page
      | promos_vouchers   |
      | autotest_redeemed_customer1 |
    And the customer sees the success message "Success 'autotest_redeemed_customer1' Added!" below the voucher input box on Checkout page
    And user selects the payment type as "adyen_invalid_cvc_creditcard"
    When the user hits on the Continue to Payment button on the Checkout page
    Then the the user lands on My Bag page with global error message "We've removed the coupon code you entered, as it's been redeemed already / exceeded overall redemption limit"
    And the customer cannot see the voucher applied in the Applied codes section
