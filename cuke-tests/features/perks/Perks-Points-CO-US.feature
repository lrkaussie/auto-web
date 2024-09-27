@perks_points @us
Feature: Perks Points on Checkout for US

  As a user I want to verify perks points calculation on the CO page for US site with sales tax
  In US, we have these products
  | sku           | promo | price | Size |
  | 9351533812327 | N     | 19.99 | NA   |
  | 9352855089992 | N     | 20.00 | NA   |
  | 9351785586540 | Y     | 5.00  | M    |
  | 9351785092140 | N     | 49.99 | NA   |

  Assumption:-
  The following users exist in CC with Perks account status in RMS

  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account |
  | cottononqa+USnick1@gmail.com  | Nick       | US        | Yes                    | No            |
  | cottononqa+USmatt@gmail.com   | Matt       | US        | Yes                    | No           |
  | cottononqa+USsteve@gmail.com  | Steve      | US        | Yes                    | Yes           |
  | cottononqa+USfilip@gmail.com  | Filip      | US        | Yes                    | No            |
  | cottononqa+USvincy@gmail.com  | Vincy      | US        | No                     | Yes           |
  | cottononqa+UShima@gmail.com   | Hima       | US        | No                     | No            |

  Information on the Perks points verification with multiple saved addresses on Checkout page:
  The user has 3 saved addresses with default address of IL(tax=0(default-0) then of CA(tax=0.1(default-0.0848) and TX(tax=0.0775(default-0.0775).

  @guest @hd
  Scenario: Perks points verification on Checkout page as a Guest User and non-perks member
    Given I am on country "US"
    And site is "COG"
    And an user "Hima"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 54 reward points         |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section

  @guest @hd
  Scenario: Perks points verification on Checkout page as a Guest User and perks member
    Given I am on country "US"
    And site is "COG"
    And an user "Vincy"
    And cart is "Standard cart"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed              |
      | This order will earn you 54 points |
      | How are points & rewards calculated?    |
    And clicking on How are my points calculated link reveals text
      | line                                                                    |
      | Reach 100 points and receive a $10 reward voucher via email             |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And clicking again on How are my points calculated link hides the text

  @registered @hd
  Scenario: Perks points verification on Checkout page as a Registered User and non-perks member
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Filip"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 50 reward points         |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section

  @registered @hd
  Scenario:  Perks points verification on Checkout page as a Registered User and perks member
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Steve"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed              |
      | This order will earn you 53 points |
      | How are points & rewards calculated?     |
    And clicking on How are my points calculated link reveals text
      | line                                                                    |
      | Reach 100 points and receive a $10 reward voucher via email             |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And clicking again on How are my points calculated link hides the text

 @registered @hd
  Scenario: Perks points are refreshed when the user applies/removes perks vouchers
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Steve"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed              |
      | This order will earn you 53 points |
      | How are points & rewards calculated?     |
    When user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9501557710400200 |
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed              |
      | This order will earn you 43 points |
      | How are points & rewards calculated?    |
    And the customer removes the perks voucher from Checkout Page
      | voucher_id       |
      | 9501557710400200 |
    And the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed         |
      | This order will earn you 53 points |
      | How are points & rewards calculated?    |

 @registered @hd
  Scenario: Perks points verification with mixed products cart on Checkout page as a Guest User and non-perks member
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | US      | Matt | guest        | sign-in      | not_logged_in |
    And the user navigates to PDP of the product "9354233659087"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And a bag with products:
      | sku                | qty |
      | 9351533812327      | 1   |
      | 9352855089992      | 1   |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty |
      | 9351533812327 |  1  |
      | 9352855089992 |  1  |
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    When checkout button is pressed
#    And the user enters email on checkout "cottononqa+USmatt@gmail.com"
    And "guest" user fills in details for "home" delivery
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 28 reward points         |
      | (100 points = $10 reward voucher)    |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 22 reward points         |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section


  @registered @hd
  Scenario: Perks points verification with multiple saved addresses on Checkout page as a Registered User and non-perks member
    And I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state |
      | COG  | US      | Nick    | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
      | 9352855089992 | 1   |
    When checkout button is pressed
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 6 reward points          |
      | (100 points = $10 reward voucher)    |
    Then user changes to the address "2" from the saved addresses
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 6 reward points          |
      | (100 points = $10 reward voucher)    |
    Then user changes to the address "3" from the saved addresses
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 5 reward points          |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section


  @non-perks @guest
  Scenario: Validate DOB field with checkbox presence on checkout page for guest user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | US      | Nick | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+USnick1@gmail.com"
    And user selects the join perks checkbox
    Then DOB heading is present
    And DOB copy under the field is present with correct text on "checkout" page
    And save DOB checkbox is present with correct text

  @non-perks @registered
  Scenario: Validate DOB field with checkbox presence on checkout page for registered user
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state |
      | COG  | US      | Nick    | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    Then DOB heading is present
    And DOB copy under the field is present with correct text on "checkout" page
    And save DOB checkbox is present with correct text

  @non-perks @registered
  Scenario: Validate the functionality of under 13 age entry in DOB field on Checkout page as a Registered User and non perks member
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Filip"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | registered | house   | HD            |
    And user selects the join perks checkbox
    And I enter DOB under allowed age on Checkout page
    And I select the save DOB checkbox
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    Then the correct error message for DOB should be displayed

  @non-perks @guest
  Scenario: Validate the functionality of under 13 age entry in DOB field on Checkout page as a guest user and non perks member
    Given I am on country "US"
    And site is "COG"
    And cart is "Standard cart"
    And an user "Filip"
    When user checks out with details:
      | user_type  | address | delivery_type |
      | guest | house   | HD            |
    And user selects the join perks checkbox
    And I enter DOB under allowed age on Checkout page
    And I select the save DOB checkbox
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    Then the correct error message for DOB should be displayed

