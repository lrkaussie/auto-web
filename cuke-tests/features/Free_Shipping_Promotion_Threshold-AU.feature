@au @free_shipping
Feature: Free shipping promotion threshold - COG-SA
  As a Cotton On Customer
  I want to know how much more I need to spend to reach the free shipping threshold
  So that I can add additional items to my basket and order with free shipping

  Designs: https://app.zeplin.io/project/59e6e0cc4a802d34184fe409/dashboard

  Assumption
  BM Configuration:- Merchant Tools / Online Marketing / Promotions
  | Site        | Promotion                                   | Spend   | Alert Enabled | Alert Threshold |
  | COG-AU      | autotest - ship-standard-free-au-threshold  | $55.00  | Yes           | $30.00          |
  | COG-NZ      | autotest-ship-standard-free-nz-threshold    | $60.00  | Yes           | $30.00          |
  | COG-US      | autotest-ship-standard-free-us-threshold    | $55.00  | Yes           | $20.00          |
  | COG-My      | autotest-ship-standard-free-my-threshold    | $150.00 | Yes           | $150.00         |
  | COG-HK      | autotest-ship-standard-free-hk-threshold    | $300.00 | Yes           | $240.00         |
  | COG-SG      | autotest-ship-standard-free-sg-threshold    | $50.00  | Yes           | $20.00          |
  | COG-SA      | autotest-ship-standard-free-za-threshold    | $500.00 | Yes           | $300.00         |
  | Typo-UK     | autotest-ship-standard-free-uk-threshold    | $25.00  | No            |                 |
  | Supre-AU    | autotest-free-shipping-threshold-supre      | $50.00  | Yes           | $30.00          |
  | Factorie-AU | autotest-free-shipping-threshold-factorie   | $50.00  | Yes           | $50.00          |

  In AU, we have these products

  | sku           | price |
  | 9351785572239 | 24.95 |
  | 9351785122199 | 29.95 |
  | 9351785267944 | 44.95 |
  | 9351533037683 | 10.00 |
  | 9351533806142 | 05.00 |
  | 9350486768316 | 10.00 |
  | 9350486426872 | 03.00 |
  | 9351785572239 | 24.95 |
  | 9350486768316 | 10.00 |

  @registered @pdp
  Scenario: Verify No Free shipping Threshold message in PDP success message for a product and merchandise total is "$24.95"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Mark|registered  |sign-in     |logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 9351785572239 | 1 |
    Then "Size XL added to bag" message should be displayed in PDP success message


  @registered @pdp
  Scenario: Verify Free Shipping Threshold message in PDP Success message for a product and merchandise total is "$29.95"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Mark|registered  |sign-in     |logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 9351785122199 | 1 |
    Then "Want Free Shipping? Spend AU$25.05 more" message should be displayed in PDP success message


  @wip @registered @pdp
  Scenario: Verify Free Shipping Threshold message in PDP Success message for a product and merchandise total is "$55.00"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Mark|registered  |sign-in     |logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 9351533037683 | 5 |
      | 9351533806142 | 1 |
    Then "Awesome! You've qualified for FREE SHIPPING!" message should be displayed in PDP success message

  @guest @pdp
  Scenario: Verify Free shipping Threshold message in PDP Success message for a Product and merchandise total is "$28.00"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Don|guest  |sign-in     |not_logged_in|
    When I add the following products to cart
      | sku | qty |
      | 9350486768316 | 1 |
      | 9351533037683 | 1 |
      | 9351533806142 | 1 |
      | 2075004944719 | 1 |
#      | 9350486426872 | 1 |
    Then "Want Free Shipping? Spend AU$26.05 more" message should be displayed in PDP success message

  @guest @pdp
  Scenario: Verify Free Shipping Threshold message in PDP Success message for a Product and merchandise total is "$54.95"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Don|guest  |sign-in     |not_logged_in|
    When I add the following products to cart
      | sku | qty |
      | 9351785267944 | 1 |
      | 9350486768316 | 1 |
    Then "Want Free Shipping? Spend AU$0.05 more" message should be displayed in PDP success message

  @wip @guest @pdp
  Scenario: Verify Free Shipping Threshold message in PDP Success message for a Product and merchandise total is "$55.00"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Don|guest  |sign-in     |not_logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 9351533037683 | 5 |
      | 9351533806142 | 1 |
    Then "Awesome! You've qualified for FREE SHIPPING!" message should be displayed in PDP success message

  @registered @mybag
  Scenario: Verify Free Shipping Threshold message in My Bag for a product without any Promotions and merchandise total is "$54.99"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Mark|registered  |sign-in     |logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 9351785267944 | 1 |
      | 9350486768316 | 1 |
    Then "Want Free Shipping? Spend AU$0.05 more" message should be displayed in My Bag

  @guest @mybag
  Scenario: Verify Free shipping Threshold message in My Bag for a Product without any Promotions and merchandise total is "$28.00"
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Don|guest  |sign-in     |not_logged_in|
    When I add the following products to cart
      | sku | qty |
      | 9350486768316 | 1 |
      | 9351533037683 | 1 |
      | 9351533806142 | 1 |
      | 2075004944719 | 1 |
#      | 9350486426872 | 1 |
    Then "Want Free Shipping? Spend AU$26.05 more" message should be displayed in My Bag

