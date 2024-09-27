@points_balance @us
Feature: Perks Points and vouchers on My Account for US

  As a Cotton On business, I want to provide customers with the ability to check their points balance and see their available vouchers
  so that customers can self serve and customer service receive less enquires.

  Assumption:-
  The following users exist in CC with Perks account status in RMS:-

  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account |
  | cottononqa+USnick1@gmail.com  | Nick       | US        | Yes                    | No            |
  | cottononqa+USmatt@gmail.com   | Matt       | US        | Yes                    | No            |
  | cottononqa+USsteve@gmail.com  | Steve      | US        | Yes                    | Yes           |
  | cottononqa+USfilip@gmail.com  | Filip      | US        | Yes                    | No            |
  | cottononqa+USvincy@gmail.com  | Vincy      | US        | No                     | Yes           |
  | cottononqa+UShima@gmail.com   | Hima       | US        | No                     | No            |
  | cottononqa+USMyAcc@gmail.com  | My Acc     | US        | Yes                    | Yes           |

  Steve US has the following vouchers in RMS:-
  | voucher_id       | reward_type          | value | redeemed | days_since_expired |
  | 984              | Perks Payday Voucher | $10   | yes      |                    |
  | 984              | Perks Payday Voucher | $10   | no       | 10                 |
  | 9840000000000003 | Perks Payday Voucher | $10   | no       |                    |
  | 9840000000000004 | Perks Payday Voucher | $10   | no       |                    |
  | 9840000000000005 | Perks Payday Voucher | $10   | no       |                    |

 My Acc US has the following vouchers in RMS:-
  | voucher_id       | reward_type            | value | redeemed | days_since_expired |
  | 9500000000000005 | Perks Welcome Voucher  | $10   | no       |                    |
  | 9400000000000004 | Perks Birthday Voucher | $10   | no       |                    |
  | 9840000000000002 | Perks Payday Voucher   | $10   | no       |                    |
  | 9840000000000003 | Perks Payday Voucher   | $10   | no       |                    |
  It also has a payday voucher(984 prefix) expiring today.
  Myacc also has a payday voucher(984 prefix) which is already presented in RMS and therefore locked.

  Scenario: Display of multiple perks vouchers on Perks Balance Page for a perks member
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | MyAcc | registered   | sign-in      | logged_in  |
    And I land on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |
    And I click the "Points Balance" link on My Account
    Then the point balance on Perks Balance page is "0"
    And the number of rewards is "4 ($40)"
    And the points to reward mapping is "100 points = $10 reward voucher"
    And the following vouchers are displayed
      | voucher_id       | voucher_type           | voucher_value | expiry_days |
      | 9840000000000002 | Perks Payday Voucher   | $10           | (Today)     |
      | 9840000000000003 | Perks Payday Voucher   | $10           | (10 Days)   |
      | 9400000000000004 | Perks Birthday Voucher | $10           | (10 Days)   |
      | 9500000000000005 | Perks Welcome Voucher  | $10           | (10 Days)   |

  Scenario: Verify info on How do Rewards & Points work section
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | MyAcc | registered   | sign-in      | logged_in  |
    And I click the "Points Balance" link on My Account
    And clicking on How do Rewards & Points work "expands" the section
    And the section shows Rewards Info
      | rewards_info                         |
      | How do Rewards work?                 |
      | $1 = 1 point. 100 points = 1 Reward. |
      | When are points added?               |
    And clicking on How do Rewards & Points work "collapses" the section

  Scenario: Non perks members navigates to Perks balance page and try to sign up for Perks
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | Jesse | registered   | sign-in      | logged_in  |
    And I land on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |
    And I click the "Points Balance" link on My Account
    Then I see a message "Looks like you’re not a Perks member" on the Perks Balance page
    And the point to reward mapping is "100 points = $10 reward voucher"
    And the reward history on Perks Balance page is hidden
    And I click the "Sign up and start earning" button
    And I land on Loyalty subscription page

  Scenario: Non perks members clicks on Already a member link
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | Jesse | registered   | sign-in      | logged_in  |
    And I click the "Points Balance" link on My Account
    And I click on Already a member link to expand the section
    And Already a member section shows
      | content                                                                                                                                                         |
      | Already a Cotton On & Co Perks member?                                                                                                                          |
      | In order to see your points balance, make sure the email address in Your Details is the same as the email address you used to sign up for Cotton On & Co Perks. |
      | Update Your Details here.                                                                                                                                       |
    And I click on Update Your Details here link
    And I land on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |

  @smoke_test
  Scenario: Display reward history for a Perks User
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | Steve | registered   | sign-in      | logged_in  |
    And I click the "Points Balance" link on My Account
    And I click the reward history on Perks Balance page
    Then the Perks reward history shows the vouchers
      | reward_type          | value | redeemed | days_since_expired |voucher_locked_message|
      | Perks Payday Voucher | $10   | yes      |                    |                      |
      | Perks Payday Voucher | $10   | no       | 10                 |                      |
      | Perks Payday Voucher | $10   | no       |                    |                      |
      | Perks Payday Voucher | $10   | no       |                    |                      |
      | Perks Payday Voucher | $10   | no       |                    |                      |

#  Scenario: Verify spend threshold message for points balance 75
#    Given I log on to the site with the following:
#      | site | country | user | type_of_user | landing_page | user_state | cart_page |
#      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
#    And I click the "Points Balance" link on My Account
#    Then the point balance on Perks Balance page is "75"
#    And the number of rewards is "1 ($10)"
#    And the points to reward mapping is "100 points = $10 reward voucher"
#    And the spend threshold message is "Spend just $25 to earn your next reward"

  Scenario: Reward History & Points Balance when perks user has presented voucher and voucher expiring today
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | MyAcc | registered   | sign-in      | logged_in  |
    When I click the "Points Balance" link on My Account
    And I click the reward history on Perks Balance page
    Then the Perks reward history shows the vouchers
      | reward_type            | voucher_locked_message | value | redeemed | days_since_expired |
      | Perks Payday Voucher   | temporary locked       | $10   | no       |                    |
      | Perks Payday Voucher   |                        | $10   | no       |                    |
      | Perks Payday Voucher   |                        | $10   | no       |                    |
      | Perks Birthday Voucher |                        | $10   | no       |                    |
      | Perks Welcome Voucher  |                        | $10   | no       |                    |

  @smoke_test
  Scenario: Apply multiple perks vouchers from Points Balance page
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | MyAcc | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I navigate to Points balance page
    And I add the perks voucher to cart from Points Balance page
      | voucher_id       |
      | 9840000000000002 |
      | 9840000000000003 |
    And I navigate to bag page by clicking the minicart icon
    And the vouchers are displayed on bag page
      | voucher_id       |
      | 9840000000000002 |
      | 9840000000000003 |
    And the order total in the Order Summary section on My Bag page is "35.99"

  Scenario: Apply vouchers from Points Balance page and remove the applied vouchers from Bag page
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | MyAcc | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I navigate to Points balance page
    And I add the perks voucher to cart from Points Balance page
      | voucher_id       |
      | 9400000000000004 |
      | 9500000000000005 |
    And I navigate to bag page by clicking the minicart icon
    And I remove the vouchers from bag page
      | voucher_id       |
      | 9400000000000004 |
    And I navigate to Points balance page
    Then the vouchers are available to add on Points Balance page
      | voucher_id       |
      | 9400000000000004 |
    And the vouchers are shown an "Applied" on Points Balance page with the buttons disabled
      | voucher_id       |
      | 9500000000000005 |

  Scenario: Apply multiple vouchers from Points Balance page then buttons are disabled
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state |
      | COG  | US      | MyAcc | registered   | sign-in      | logged_in  |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I navigate to Points balance page
    And I add the perks voucher to cart from Points Balance page
      | voucher_id       |
      | 9840000000000003 |
      | 9400000000000004 |
      | 9500000000000005 |
    And the vouchers are shown an "Applied" on Points Balance page with the buttons disabled
      | voucher_id       |
      | 9840000000000003 |
      | 9400000000000004 |
      | 9500000000000005 |

