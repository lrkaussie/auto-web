@klarna
Feature: Checkout - Klarna - COG-UK

  As a user I want to check out with klarna on UK site
  In UK typo, we have these products
  | sku           | type   | PID       | Price |
  | 9351785509549 | normal | 131741-00 | 6 P   |
  | 9351533811818 | normal | 140122-02 | 15 P  |

  Scenario: Checkout with klarna as a guest user for an approved order
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | UK      | DonUK | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509549 | 1   |
      | 9351533811818 | 1   |
      | 9351533811818 | 1   |
    When user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And user selects the payment type as "klarna"
    Then the first installment amount for klarna is "£13.33" on "GB" site
    And the user clicks Continue to Payment button on the Checkout page of "GB" site for klarna
    And on "GB" klarna page "guest" user places an order of "£40.00"
    Then "klarna" Thankyou page is shown with details for the user
    And in BM last klarna order for "DonUK" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |

