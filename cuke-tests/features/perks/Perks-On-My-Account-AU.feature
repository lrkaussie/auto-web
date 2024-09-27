@points_balance @au
Feature: Perks Points and vouchers on My Account

  As a Cotton On business, I want to provide customers with the ability to check their points balance and see their available vouchers
  so that customers can self serve and customer service receive less enquires.

  Assumption:-
  The following users exist in CC with Perks account status in RMS:-

  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account |
  | cottononqa+lynn@gmail.com     | Lynn       | Ladlee    | Yes                    | Yes           |
  | cottononqa+jessica@gmail.com  | Jessica    | Alba      | Yes                    | No            |
  | cottononqa+sophia@gmail.com   | Sophia     | Laura     | Yes                    | Yes           |
  | cottononqa+julia@gmail.com    | Julia      | Verez     | Yes                    | Yes           |

  Sophia Laura has the following vouchers in RMS:-

  | voucher_id       | reward_type            | value | redeemed | days_since_expired |
  | 9840000000000001 | Perks Welcome Voucher  | $10   | yes      |                    |
  | 9840000000000002 | Perks Welcome Voucher  | $10   | no       | 10                 |
  | 9840000000000003 | Perks Welcome Voucher  | $10   | no       |                    |
  | 9850000000000004 | Perks Payday Voucher   | $10   | no       |                    |
  | 9900000000000005 | Perks Birthday Voucher | $10   | no       |                    |

  Julia Verez has the following vouchers in RMS:-

  | voucher_id       | reward_type            | value  | redeemed     | days_since_expired |
  | 9900000000000001 | Perks Birthday Voucher | $10    | no           |                    |
  | 984000000000000  | Perks Welcome Voucher  | $10    | no           |                    |

  The voucher 984000000000000 is expiring today.
  Julia also has a voucher which is presented in RMS

  Scenario: Display of multiple perks vouchers on Perks Balance Page for a perks member
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And I land on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |
    And I click the "Points Balance" link on My Account
    Then the point balance on Perks Balance page is "0"
    And the number of rewards is "3 ($30)"
    And the points to reward mapping is "100 points = $10 reward voucher"
    And the following vouchers are displayed
      | voucher_id       | voucher_type           | voucher_value | expiry_days |
      | 9840000000000003 | Perks Welcome Voucher  | $10           | (10 Days)   |
      | 9850000000000004 | Perks Payday Voucher   | $10           | (10 Days)   |
      | 9900000000000005 | Perks Birthday Voucher | $10           | (10 Days)   |

  Scenario: Verify info on How do Rewards & Points work section
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
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
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
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
      | site | country | user    | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Jessica | registered   | sign-in      | logged_in  | empty     |
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
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And I click the "Points Balance" link on My Account
    And I click the reward history on Perks Balance page
    Then the Perks reward history shows the vouchers
      | reward_type            | value | redeemed | days_since_expired |voucher_locked_message|
      | Perks Welcome Voucher  | $10   | yes      |                    |                      |
      | Perks Welcome Voucher  | $10   | no       | 10                 |                      |
      | Perks Welcome Voucher  | $10   | no       |                    |                      |
      | Perks Payday Voucher   | $10   | no       |                    |                      |
      | Perks Birthday Voucher | $10   | no       |                    |                      |

  Scenario: Verify spend threshold message for points balance 75
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  | empty     |
    And I click the "Points Balance" link on My Account
    Then the point balance on Perks Balance page is "75"
    And the number of rewards is "1 ($10)"
    And the points to reward mapping is "100 points = $10 reward voucher"
    And the spend threshold message is "Spend just $25 to earn your next reward"

  Scenario: Reward History & Points Balance when perks user has presented voucher and voucher expiring today
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Julia | registered   | sign-in      | logged_in  | empty     |
    When I click the "Points Balance" link on My Account
    Then the point balance on Perks Balance page is "74"
    And the number of rewards is "2 ($20)"
    And the points to reward mapping is "100 points = $10 reward voucher"
    And the following vouchers are displayed
      | voucher_id       | voucher_type           | voucher_value | expiry_days |
      | 9900000000000001 | Perks Birthday Voucher | $10           | (10 Days)   |
      | 984000000000000  | Perks Welcome Voucher  | $10           | (Today)    |
    And I click the reward history on Perks Balance page
    And the Perks reward history shows the vouchers
      | reward_type            | voucher_locked_message | value | redeemed | days_since_expired |
      | Perks Birthday Voucher |                        | $10   | no       |                    |
      | Perks Welcome Voucher  | temporary locked       | $10   | no       |                    |
      | Perks Welcome Voucher  |                        | $10   | no       |                    |

  @smoke_test
  Scenario: Apply multiple perks vouchers from Points Balance page
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586519 | 1   |
    And I navigate to Points balance page
    And I add the perks voucher to cart from Points Balance page
      | voucher_id       |
      | 9840000000000003 |
      | 9850000000000004 |
    And I navigate to bag page by clicking the minicart icon
    And the vouchers are displayed on bag page
      | voucher_id       |
      | 9840000000000003 |
      | 9840000000000003 |
    And the order total in the Order Summary section on My Bag page is "130.00"

    Scenario: Apply vouchers from Points Balance page and remove the applied vouchers from Bag page
      Given I log on to the site with the following:
        | site | country | user   | type_of_user | landing_page | user_state | cart_page |
        | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
      And a bag with products:
        | sku           | qty |
        | 9351785586519 | 1   |
      And I navigate to Points balance page
      And I add the perks voucher to cart from Points Balance page
        | voucher_id       |
        | 9840000000000003 |
        | 9850000000000004 |
      And I navigate to bag page by clicking the minicart icon
      And I remove the vouchers from bag page
        | voucher_id       |
        | 9840000000000003 |
      And I navigate to Points balance page
      Then the vouchers are available to add on Points Balance page
        | voucher_id       |
        | 9840000000000003 |
      And the vouchers are shown an "Applied" on Points Balance page with the buttons disabled
        | voucher_id       |
        | 9850000000000004 |

  Scenario: Apply multiple vouchers from Points Balance page then buttons are disabled
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586519 | 1   |
    And I navigate to Points balance page
    And I add the perks voucher to cart from Points Balance page
      | voucher_id       |
      | 9840000000000003 |
      | 9850000000000004 |
      | 9900000000000005 |
    And the vouchers are shown an "Applied" on Points Balance page with the buttons disabled
      | voucher_id       |
      | 9840000000000003 |
      | 9850000000000004 |
      | 9900000000000005 |
