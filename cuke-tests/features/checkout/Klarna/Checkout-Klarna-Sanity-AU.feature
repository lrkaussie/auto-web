@klarna
Feature: Checkout - Klarna - COG-AU

  As a user I want to check out with klarna on AU site
  In AU, we have these products
  | sku           | type         |
  | 5555555555011 | multipack    |
  | 9351785509303 | normal       |
  | 9351785851327 | personalised |

  Scenario: Checkout with klarna as a guest user with mixed product for an approved order
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351785851327 |  1  |XX                  |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
      | 5555555555011 | 1   |
    When user selects to checkout from their bag
    And "guest" user fills in details for "home" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And user selects the payment type as "klarna"
    Then the first installment amount for klarna is "AU$26.73" on "AU" site
    And the user clicks Continue to Payment button on the Checkout page of "AU" site for klarna
    And on "AU" klarna page "guest" user places an order of "106.90"
    Then "klarna" Thankyou page is shown with details for the user
    And in BM last klarna order for "Don" is:
      | klarna_order_status | klarna_processor | klarna_transaction | klarna_fraud_status |
      | OPEN                | KLARNA_PAYMENTS  | Transaction        | ACCEPTED            |
