Feature: Checkout - Multipack - COG-US

  As a user I want to check out with Multipack in the cart with different payment methods
  In US, we have these multipack products
  | sku           |
  | 5555555555011 |
  | 4444444444011 |
  | 5555555555012 |
  | 4444444444021 |
  non-promotional product will be used in standard cart

  Scenario: Checkout with guest, multipack and credit card, Adyen approves
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |US     |Thomas|guest       |sign-in            |not_logged_in|
    And a bag with products:
      | sku           | qty |
      | 5555555555011 | 1   |
      | 4444444444011 | 1   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.25"

  Scenario: Checkout with guest, multipack and credit card, CNC Adyen approves
    Given I am on country "US"
    And site is "COG"
    And an user "Thomas"
    And a bag with products:
      | sku           | qty |
      | 5555555555012 | 2   |
      | 4444444444021 | 2   |
    And user selects to checkout from their bag
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | CNC           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "CNC" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "9.59"

  Scenario: Checkout with registered user, multipack and adyen, HD with product promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 5555555555011 | 2   |
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "98.00"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "7.35"

  Scenario: Checkout with registered user, multipack and afterpay, HD with product promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 1   |
      | 4444444444011 | 1   |
    And promo code added on bag "autotest_product"
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "US" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "14.17"
    And in BM last order for "Thomas" is:
      | order_status | adyen_status | eventcode       | authResult |
      | OPEN         | APPROVED     | AFTERPAY_CREDIT | NA         |

  Scenario: Checkout with registered user, multipack and afterpay, CNC with order promotion
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in   |
    And a bag with products:
      | sku           | qty |
      | 9351785454856 | 2   |
      | 4444444444011 | 2   |
    And promo code added on bag "autotest_order"
    And the discount price after order promotion applied is "76.00"
    And user selects to checkout from their bag
    When "registered" user fills in details for "cnc" delivery
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "US" site
    Then Afterpay Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Afterpay Thankyou page
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And tax amount is "20.82"
    And in BM last order for "Thomas" is:
      | order_status | adyen_status | eventcode       | authResult |
      | OPEN         | APPROVED     | AFTERPAY_CREDIT | NA         |

  @wip
  Scenario: Checkout with quadpay as a guest user with normal and multipack products for an approved order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
      | 5555555555011 | 1   |
      | 4444444444011 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "quadpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And on quadpay page user places an order with a "random approved" user
    Then "quadpay" Thankyou page is shown with details for the user
    And in BM last zip order for "Robert" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  Scenario: Checkout with mixed products cart on Checkout page as a Guest User
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | US      | Matt | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "9354233659087"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku           | qty |
      | 9351533812327 | 1   |
      | 9352855089992 | 1   |
      | 5555555555011 | 1   |
      | 4444444444011 | 1   |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty |
      | 9351533812327 |  1  |
      | 9352855089992 |  1  |
      | 5555555555011 |  1  |
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    When checkout button is pressed
    And "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.09"

  Scenario: Verify the Save percent on the PDP for a Multipack with Percent config ON for guest user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "4444444444011"
    Then "Save Percent" text is displayed for Multipack on the PDP

  Scenario: Verify the Save percent on the PLP for a Multipack with Percent config ON for guest user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    When user navigates to "men/mens-workout-clothes/mens-workout-t-shirts/" page
    Then "Save Percent" text is displayed for Multipack on the PLP

  Scenario: Verify the Save percent on the PDP for a Multipack with Percent config ON for registered user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state |
      |COG |US     |Thomas|registered  |sign-in     |logged_in  |
    When the user navigates to PDP of the product "4444444444011"
    Then "Save Percent" text is displayed for Multipack on the PDP

  Scenario: Verify the Save percent on the PLP for a Multipack with Percent config ON for registered user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state |
      |COG |US     |Thomas|registered  |sign-in     |logged_in  |
    When user navigates to "men/mens-workout-clothes/mens-workout-t-shirts/" page
    Then "Save Percent" text is displayed for Multipack on the PLP

  Scenario: Verify the Save Percent on My Bag pg for a Multipack with RRP config ON for guest user
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |US     |Thomas |guest       |sign-in     |not_logged_in|
    When I add the following products to cart
      | sku           | qty |
      | 4444444444011 | 1   |
    Then I navigate to bag page by clicking the minicart icon
    And I validate "Save Percent" text for qty "1" on My bag page
    And I add "2" more to the qty from the My Bag page
    And I validate "Save Percent" text for qty "2" on My bag page
    And user selects to checkout from their bag
    And I validate "Save Percent" text for qty "2" on checkout page

  Scenario: Verify the Save Percent on My Bag pg for a Multipack with RRP config ON for registered user
    Given I log on to the site with the following:
      |site|country|user |type_of_user|landing_page|user_state |
      |COG |US     |Thomas  |registered  |sign-in     |logged_in  |
    When I add the following products to cart
      | sku           | qty |
      | 4444444444011 | 1   |
    Then I navigate to bag page by clicking the minicart icon
    And I validate "Save Percent" text for qty "1" on My bag page
    And I add "2" more to the qty from the My Bag page
    And I validate "Save Percent" text for qty "2" on My bag page
    And user selects to checkout from their bag
    And I validate "Save Percent" text for qty "2" on checkout page

  Scenario: Validating that no save text is displayed on multipack on My bag page when product promo is applied
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | US      | Thomas | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 5555555555011 | 1   |
    Then I navigate to bag page by clicking the minicart icon
    And I validate "Save RRP" text for qty "1" on My bag page
    And promo code added on bag "autotest_product"
    And I validate that the save text is no longer visible for multipack
    And user selects to checkout from their bag
    And I validate that the save text is no longer visible for multipack