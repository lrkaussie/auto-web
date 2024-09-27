@perks_points @au
Feature: Perks Points on Checkout
  As a Cotton On Business,
  I want to display the amount of points earnt in a transaction,
  so PERKS customers are aware of how many points they will receive
  and non PERKS customers will be shown the points they could earn if they join.

  Assumption:-

  The following users exist in CC with Perks account status in RMS

  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account |
  | cottononqa+lila@gmail.com     | Lila       | Love      | No                     | Yes           |
  | cottononqa+monica@gmail.com   | Monica     | Belluci   | No                     | No            |
  | cottononqa+lynn@gmail.com     | Lynn       | Ladlee    | Yes                    | Yes           |
  | cottononqa+jessica@gmail.com  | Jessica    | Alba      | Yes                    | No            |
  | cottononqa+sophia@gmail.com   | Sophia     | Laura     | Yes                    | Yes           |
  | cottononqa+samantha@gmail.com | Samantha   | Foxx      | No                     | No            |

  | Product       | markdown | sale |
  | 9351785100975 | yes      | yes  |

  @guest
  Scenario: Perks points info on Checkout page for a Guest customer who is not a Perks member
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state    |
      | COG  | AU      | Samantha | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+samantha@gmail.com"
    When the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section

  @guest
  Scenario: Perks points info on Checkout page for a Guest customer who is a Perks member
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Sophia | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+sophia@gmail.com"
    When the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed             |
      | This order will earn you 20 points |
      | How are points & rewards calculated?      |
    And clicking on How are my points calculated link reveals text
      | line                                                                    |
      | Reach 100 points and receive a $10 reward voucher via email             |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And clicking again on How are my points calculated link hides the text

  @adyen @guest
  Scenario: Non perks customer signs up for PERKS on Checkout page
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | AU      | Monica | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    And the user navigates away from the email field
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    And the Join CottonOn & Co. Perks section has content
      | line                                                                         |
      | Members receive via email                                                    |
      | $10 welcome voucher                                                          |
      | $10 reward voucher for every $100 spent                                      |
      | Pressies, previews & exclusive offers                                        |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And the user selects the preferences "Typo"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And in BM the loyalty subscription data for "Monica" has correct email, interests and brands

  @guest
  Scenario: Guest customer selects 'Already a member' on Checkout page
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state    |
      | COG  | AU      | Samantha | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+samantha@gmail.com"
    And the user navigates away from the email field
    When the user clicks "Already a member" link
    Then the message "Enter your Perks registered email above" appears

  @registered @smoke_test
  Scenario: Perks points info for a registered customer who doesn't have a Perks account
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    When checkout button is pressed
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section

  @guest
  Scenario: Perks points info for a guest customer on checkout page who doesn't have a Perks account
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jessica | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+jessica@gmail.com"
    When the user clicks on Sign In Here Link
    And the user logs in to online account with password "radiation123"
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    And the "Join Perks" checkbox is displayed on Perks section
    And "Already a member?" link is displayed on Perks section

  @registered
  Scenario: Perks points info for a registered customer who is also a Perks member
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    When checkout button is pressed
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed         |
      | Spend $5 more and earn a $10 reward! |
      | Find out more     |
    And clicking on Find out more link reveals text
      | line                                                                    |
      | Reach 100 points and receive a $10 reward voucher via email             |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And clicking again on Find out more link hides the text

  @guest
  Scenario: Registered customer who is also a perks member signs in at checkout
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lynn@gmail.com"
    When the user clicks on Sign In Here Link
    And the user logs in to online account with password "radiation123"
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed         |
      | Spend $5 more and earn a $10 reward! |
      | Find out more     |
    And clicking on Find out more link reveals text
      | line                                                                    |
      | Reach 100 points and receive a $10 reward voucher via email             |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And clicking again on Find out more link hides the text


  @adyen @registered
  Scenario: Registered customer signs up for PERKS on Checkout page
    Given an user "Jessica"
    And I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And user selects the join perks checkbox
    And the "Join CottonOn & Co. Perks" checkbox gets selected
    And the Join CottonOn & Co. Perks section has content
      | line                                                                         |
      | Members receive via email                                                    |
      | $10 welcome voucher                                                          |
      | $10 reward voucher for every $100 spent                                      |
      | Pressies, previews & exclusive offers                                        |
      | *Points will not be earned on shipping charges or the purchase of Gift Cards |
    And the user selects the preferences "Typo"
    When the user fills in details for a home delivery order
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And in BM the loyalty subscription data for "Jessica" has correct email, interests and brands

  @registered
  Scenario: Registered customer selects 'Already a member' on Checkout page
    Given an user "Jessica"
    And I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    When the user clicks "Already a member" link
    Then the message "If you think you’ve signed up to Perks with a different email address, you can update your email address in My Account" appears
    And the user clicks on "My Account" link
    And the user lands on My Account page with details prefilled
      | Firstname | Lastname | Email                        |
      | Jessica   | Alba     | cottononqa+jessica@gmail.com |

  @registered
  Scenario: Perks points are refreshed when the user applies/removes perks vouchers
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
    And checkout button is pressed
    And the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 40 points  |
      | How are points & rewards calculated?|
    When user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    Then the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 30 points  |
      | How are points & rewards calculated?|
    And the customer removes the perks voucher from Checkout Page
      | voucher_id       |
      | 9840150120702065 |
    And the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 40 points  |
      | How are points & rewards calculated?|

  @registered
  Scenario: Verify Perks message at Checkout after Perks member places Order with Perks threshold approached value as registered
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 4   |
    And checkout button is pressed
    And the perks section is displayed on Checkout page
      | perks_member_section                         |
      | Perks membership confirmed                   |
      | This order will earn you a $10 Perks Voucher!|
      | Find out more                                |
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 5   |
    When checkout button is pressed
    Then the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 100 points!|
      | Find out more                       |

  @guest
  Scenario: Verify Perks message at Checkout after Perks member places Order with Perks threshold approaching value as guest
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state     |
      | COG  | AU      | John | guest        | sign-in      | not_logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 3   |
    And checkout button is pressed
    And the user enters email on checkout "john.smith@cottonon.com.au"
    And the user navigates away from the email field
    And the perks section is displayed on Checkout page
      | perks_member_section                 |
      | Perks membership confirmed           |
      | Spend $20 more and earn a $10 reward!|
      | Find out more                        |
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 4   |
    And checkout button is pressed
    And the user enters email on checkout "john.smith@cottonon.com.au"
    When the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | perks_member_section               |
      | Perks membership confirmed         |
      | This order will earn you 80 points!|
      | Find out more                      |

   @registered
   Scenario: Verify Perks message at Checkout after Perks member places Order with Perks threshold approaching value as registered
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 3   |
    And checkout button is pressed
    And the perks section is displayed on Checkout page
      | perks_member_section                 |
      | Perks membership confirmed           |
      | Spend $20 more and earn a $10 reward!|
      | Find out more                        |
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 4   |
    When checkout button is pressed
    Then the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 80 points! |
      | Find out more                       |

  @guest
  Scenario: Verify Perks message at Checkout after Non-Perks member places Order as guest
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jessica | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+jessica@gmail.com"
    And the user navigates away from the email field
    And the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 4   |
    When checkout button is pressed
    And the user enters email on checkout "john.smith@cottonon.com.au"
    And the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | perks_member_section                         |
      | Perks membership confirmed                   |
      | This order will earn you a $10 Perks Voucher!|
      | Find out more                                |

  @guest
  Scenario: Verify Non-Perks message at Checkout after Perks member Places Order as registered
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state     |
      | COG  | AU      | John | guest        | sign-in      | not_logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 3   |
    And checkout button is pressed
    And the user enters email on checkout "john.smith@cottonon.com.au"
    And the user navigates away from the email field
    And the perks section is displayed on Checkout page
      | perks_member_section                 |
      | Perks membership confirmed           |
      | Spend $20 more and earn a $10 reward!|
      | Find out more                        |
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+jessica@gmail.com"
    When the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |


  @registered
  Scenario: Verify Non-Perks Message at Checkout after Non-Perks User places order as registered
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    When checkout button is pressed
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |

  @guest
  Scenario: Verify Non-Perks Message at Checkout after Non-Perks User places order as guest
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lynn@gmail.com"
    And the user navigates away from the email field
    And the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    When checkout button is pressed
    And the user enters email on checkout "cottononqa+lynn@gmail.com"
    And the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 20 reward points         |
      | (100 points = $10 reward voucher)    |

  Scenario: Verify Non-Perks member rewards points on checkout page as guest user with markdown product and normal product
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state    |
      | COG  | AU      | Jessica | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785100975 | 1   |
      | 9351785586557 | 1   |
    When checkout button is pressed
    And the user enters email on checkout "cottononqa+jessica@gmail.com"
    And the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 24 reward points         |
      | (100 points = $10 reward voucher)    |

  Scenario: Verify Non-Perks member rewards points on checkout page as registered user after order promotion is applied on the cart with markdown product and normal product
    Given I log on to the site with the following:
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785100975 | 1   |
      | 9351785586557 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | autotest_order |
    And checkout button is pressed
    Then the perks section is displayed on Checkout page
      | nonperks_member_section              |
      | Looks like you’re not a Perks member |
      | You’ll miss 22 reward points         |
      | (100 points = $10 reward voucher)    |

  Scenario: Verify Perks member rewards points on checkout page as registered user after voucher is applied on order with markdown product and normal product
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586557 | 2   |
      | 9351785100975 | 1   |
    And checkout button is pressed
    And the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 48 points  |
      | How are points & rewards calculated?|
    When user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    Then the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 41 points  |
      | How are points & rewards calculated?|

  Scenario: Verify Perks member rewards points on checkout page as guest user after order promotion and voucher is applied on the cart with markdown product and normal product
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | John | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785100975 | 1   |
      | 9351785586557 | 2   |
    And customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | autotest_order |
    When checkout button is pressed
    And the user enters email on checkout "john.smith@cottonon.com.aum"
    And the user navigates away from the email field
    Then the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 45 points  |
      | How are points & rewards calculated?|
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    And the perks section is displayed on Checkout page
      | perks_member_section                |
      | Perks membership confirmed          |
      | This order will earn you 38 points  |
      | How are points & rewards calculated?|
