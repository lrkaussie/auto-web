@perks @us
Feature: Loyalty Benefit Amount and Order Total verification with US tax and Loyalty vouchers.
  As a Cottonon Customer
  I want to know the Order Total at Checkout after Perks Voucher and US Tax is applied
  I want to see the same Order Total in Thankyou Page
  I want to see how many benefit points I earned of this Order

Assumption:

  Demandware has following products (US site):
  | sku           | qty | promo | unit price |
  | 9351785092140 | 2   | N     | 49.99      |

  The following users exist in CC with Perks account status in RMS
  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account | voucher_no         | status     | expires   | amount | currency |
  | cottononqa+USsteve@gmail.com  | Steve      | US        | Yes                    | Yes           | 9500150120702065   | valid      | 9  days   | 10     | US       |
  | cottononqa+USsteve@gmail.com  | Steve      | US        | Yes                    | Yes           | 9500150120702066   | valid      | 9  days   | 10     | US       |
  | cottononqa+USvincy@gmail.com  | Vincy      | US        | No                     | Yes           | 9500150120702067   | valid      | 9  days   | 10     | US       |
  | cottononqa+USfilip@gmail.com  | Filip      | US        | Yes                    | No            |
  | cottononqa+UShima@gmail.com   | Hima       | US        | No                     | No            |

Background:
   Given I am on country "US"
   And site is "COG"

@registered @hd @adyen @perks
Scenario: Order total verification at Checkout, Thankyou page and Benefit amount having Tax included in Perks Points after Loyalty Voucher's deducted-"CC user with Perks subscription"
    And an user "Steve"
    And cart is "Standard cart"
    And user checks out with details:
    | user  | user_type  | address | delivery_type |
    | Steve | registered | house   | HD            |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9500150120702065 |
      | 9500150120702066 |
    And the voucher is applied on the checkout page under the PERKS voucher section
    And the total on checkout is "37.58"
    When user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And I validate the order summary section in thankyou page:
      | order_total |
      | 37.58       |
    And in BM last order for "Steve" is:
      | order_status | adyen_status| benefit_amount |
      | OPEN         | APPROVED    | 32             |

@guest @hd @adyen @perks
Scenario: Order total verification at Checkout, Thankyou page and Benefit amount having Tax included in Perks Points after Loyalty Voucher's deducted-"Not a CC user but an Perks User"
  And an user "Vincy"
  And cart is "Standard cart"
  And user checks out with details:
    | user  | user_type  | address | delivery_type |
    | Vincy | guest      | house   | HD            |
  And user enters the voucher in the perks section on the checkout page
    | voucher_id       |
    | 9500150120702067 |
  And the voucher is applied on the checkout page under the PERKS voucher section
  And the total on checkout is "49.09"
  When user selects the payment type as "adyen_valid_creditcard"
  And the user enters adyen details for "Credit Card" for single page checkout form
  And the user places order on the Checkout page for "Credit Card"
  Then Adyen Thankyou page is shown for the SPC with details for the user
  And I validate the order summary section in thankyou page:
    | order_total |
    | 49.09       |
  And in BM last order for "Vincy" is:
    | order_status | adyen_status| benefit_amount |
    | OPEN         | APPROVED    | 44             |

@registered @hd @adyen @perks
Scenario: Order total verification at Checkout, Thankyou page and Benefit amount having No Tax applied-"Registered CC user but Not a Perks User"
  And an user "Filip"
  And cart is "Standard cart"
  And user checks out with details:
    | user  | user_type  | address | delivery_type |
    | Filip | registered | house   | HD            |
  And the total on checkout is "55.99"
  When user selects the payment type as "adyen_valid_creditcard"
  And the user enters adyen details for "Credit Card" for single page checkout form
  And the user places order on the Checkout page for "Credit Card"
  Then Adyen Thankyou page is shown for the SPC with details for the user
  And I validate the order summary section in thankyou page:
    | order_total |
    | 55.99       |
  And in BM last order for "Filip" is:
    | order_status | adyen_status| benefit_amount |
    | OPEN         | APPROVED    | 50             |

@guest @hd @adyen @perks
Scenario: Order total verification at Checkout, Thankyou page and Benefit amount having Tax included and No Loyalty voucher deducted in Perks Points-"Non-CC&Perks Users"
  And an user "Hima"
  And cart is "Standard cart"
  And user checks out with details:
    | user  | user_type  | address | delivery_type |
    | Hima  | guest      | house   | HD            |
  And the total on checkout is "59.74"
  When user selects the payment type as "adyen_valid_creditcard"
  And the user enters adyen details for "Credit Card" for single page checkout form
  And the user places order on the Checkout page for "Credit Card"
  Then Adyen Thankyou page is shown for the SPC with details for the user
  And I validate the order summary section in thankyou page:
    | order_total |
    | 59.74       |
  And in BM last order for "Hima" is:
    | order_status | adyen_status| benefit_amount |
    | OPEN         | APPROVED    | 54             |

  @Under13
  Scenario: Validate DOB field with checkbox presence on Subscription page
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    When I navigate to the loyalty subscription page
    Then DOB heading is present
    And DOB copy under the field is present with correct text on "subscription" page
    And save DOB checkbox is present with correct text

  @Under13
  Scenario: Validate the functionality of under 13 overlay being displayed after under 13 DOB entry on subscription page with DOB checkbox not checked
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Steve |guest       |sign-in     |not_logged_in|
    And I navigate to the loyalty subscription page
    And my email is "cottononqa+USsteve@gmail.com"
    And I fill all the details with under allowed age DOB while joining perks
    And I enter the password on subscription page
    When I join for perks
    Then the customer sees the under age overlay popup message

  @Under13
  Scenario: Validate the functionality of under 13 overlay being displayed after under 13 DOB entry on subscription page with DOB checkbox checked
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Filip |guest       |sign-in     |not_logged_in|
    And I navigate to the loyalty subscription page
    And my email is "cottononqa+USfilip@gmail.com"
    And I fill all the details with under allowed age DOB while joining perks
    And I select the save DOB checkbox
    And I enter the password on subscription page
    When I join for perks
    Then the customer sees the under age overlay popup message

  @Under13
  Scenario: Validate the functionality of under 13 overlay being displayed after under 13 DOB entry on subscription page with registered user
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state|
      |COG |US     |Filip |registered  |sign-in     |logged_in |
    And I navigate to the loyalty subscription page
    And my email is "cottononqa+USfilip@gmail.com"
    And I fill all the details with under allowed age DOB while joining perks
    And I select the save DOB checkbox
    When I join for perks
    Then the customer sees the under age overlay popup message

  @Under13
  Scenario: Validate DOB field with checkbox presence on Registeration page
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    When I navigate directly to the register page
    And I select the Join Cotton On & Perks checkbox
    Then DOB heading is present
    And DOB copy under the field is present with correct text on "registeration" page
    And save DOB checkbox is present with correct text

  @Under13
  Scenario: Validate the functionality of under 13 overlay being displayed after under 13 DOB entry on registeration page with DOB checkbox not checked
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    And I navigate directly to the register page
    And my email is "vincy.bedi@due1.com"
    And I fill all the details for creating an account
    And I select the Join Cotton On & Perks checkbox
    And I enter DOB under allowed age on Registeration page
    When I create the account
    Then the customer sees the under age overlay popup message

  @Under13
  Scenario: Validate the functionality of under 13 overlay being displayed after under 13 DOB entry on registeration page with DOB checkbox checked
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    And I navigate directly to the register page
    And my email is "vincy.bedi@due1.com"
    And I fill all the details for creating an account
    And I select the Join Cotton On & Perks checkbox
    And I enter DOB under allowed age on Registeration page
    And I select the save DOB checkbox
    When I create the account
    Then the customer sees the under age overlay popup message