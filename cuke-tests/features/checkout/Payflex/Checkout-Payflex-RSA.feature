Feature: Checkout - Payflex - COG-ZA

  As a user I want to check out with Payflex as the payment provider
  In ZA, we have these products
  | VG-ID      | sku           | size  | price  |
  | 5180001-04 | 9351533621158 | S     | 149.00 |
  | 5180001-04 | 9351533621165 | M     | 149.00 |
  | 138405-00  | 9344943628084 | SOLID | 299.99 |
  | 140423-23  | 9351785584669 | SOLID | 99.99  |
  Users used are Neil and Junior
  non-promotional product will be used in standard cart
  Jira Tickets number are CO-4952 and CO-5009
  Assume configured payment method is Payflex
  Payflex : Test Data
  | Mobile Number | Id Number     | OTP    | Card Number      |
  | 7832837000    | 7703275020081 | 911911 | 4111111111111111 |

  @payflex
  Scenario: Checkout with payflex as a guest user with normal product for an approved HD order
  Given I log on to the site with the following:
  | site | country | user | type_of_user | landing_page | user_state    |
  | COG  | SA      | Neil | guest        | sign-in      | not_logged_in |
  And a bag with products:
  | sku           | qty |
  | 9351785584669 | 1   |
  And user selects to checkout from their bag
  When "guest" user fills in details for "home" delivery
  And user selects the payment type as "payflex"
  And the user clicks on the Continue to Payment button on the Checkout page for "payflex"
  And on payflex page user places an order with a "random approved" user
  Then "payflex" Thankyou page is shown with details for the user
  And in BM last zip order for "Neil" is:
  | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
  | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  @payflex
  Scenario: Checkout with payflex as a guest user with normal product for an approved CNC order
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | SA      | Neil | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785584669 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And "guest" user fills in billing address details for "payflex"
    And the user clicks on the Continue to Payment button on the Checkout page for "payflex"
    And on payflex page user places an order with a "random approved" user
    Then "payflex" Thankyou page is shown with details for the user
    And in BM last zip order for "Neil" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  @payflex
  Scenario: Failed order with payflex as a guest user with normal product by clicking cancel transaction on payflex hpp
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | SA      | Neil | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785584669 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "payflex"
    And the user clicks on the Continue to Payment button on the Checkout page for "payflex"
    And user click cancel transaction on payflex page
    And in BM last zip order for "Neil" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_notes_status |
      | FAILED           | Processor     | Transaction     |             | Blank            |

