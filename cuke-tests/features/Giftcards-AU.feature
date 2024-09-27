Feature: Apply Gift cards at Checkout

  As a customer,
  when I navigate to the checkout page after adding products to my basket,
  I want to apply my gift card
  So that I can use my gift card to pay for my order.

  Assumption

  User John has vouchers in RMS:
  | voucher_no         | status     | expires   | amount | currency |
  | 9840150120702065   | valid      | 9  days   | 10     | AU       |
  | 9840150120702066   | valid      | 9  days   | 10     | AU       |

  The following gift cards exist in RMS:
  | voucher_code        | pin  | status    | expires    | currency | amount   |
  | 2790030163867647149 | 1234 | issued    | 9999-12-31 | AUD      | 20.0000  |
  | 2790030169169063156 | 2043 | issued    | 9999-12-31 | AUD      | 100.0000 |
  | 2790030163809876543 | 0265 | redeemed  | 9999-12-31 | AUD      | 100.0000 |
  | 2790030161235645536 | 4096 | created   | 9999-12-31 | AUD      | 0.0000   |
  | 2790030173847295567 | 1111 | cancelled | 9999-12-31 | AUD      | 0.0000   |

  COG-AU Site has following products
  | sku           | price   |
  | 9351785586526 | $14.00  |
  | 9351785586533 | $4.00   |
  | 9351785586557 | $24.00  |
  | 9351785586519 | $150.00 |
  | 9351785586564 | $100.00 |
  | 9351785586571 | $20.00  |
  | 9351785673554 | $10.00  |
  | 9351785673561 | $85.90  |
  | 9351785586540 | $19.95  |

  @giftcard
  Scenario: Apply one gift card at checkout
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
    And checkout button is pressed
    And the total on checkout is "45.90"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |

  @giftcard
  Scenario: Apply two gift cards at checkout
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 2   |
    And checkout button is pressed
    And the total on checkout is "45.90"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
      | ...169169063156 | $25.90       | $74.10      |

  @giftcard
  Scenario: Gift card amount equal to order total and payment tabs are hidden
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586526 | 1   |
    And checkout button is pressed
    And the total on checkout is "20.00"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are hidden
    And Add another gift card link is "hidden"

  @giftcard
  Scenario: Gift card amount less than order total and payment tabs are shown
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586557 | 1   |
    And checkout button is pressed
    And the total on checkout is "30.00"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are visible
    And Add another gift card link is "visible"
    And the order balance remaining is "$10"

  @giftcard
  Scenario: Gift card amount greater than order total and payment tabs are hidden
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586533 | 1   |
    And checkout button is pressed
    And the total on checkout is "10.00"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $10.00       | $10.00      |
    And the payment tabs are hidden

  @giftcard
  Scenario: Error message while applying already redeemed gift card
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586557 | 1   |
    And checkout button is pressed
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163809876543 | 0265 |
    Then the gift card section displays the error "Sorry, this Gift card has already been redeemed"

  @giftcard
  Scenario: Error message when gift card PIN is missing
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586557 | 1   |
    And checkout button is pressed
    When the user applies gift cards
      | gift_card_no        | pin |
      | 2790030163867647149 |     |
    Then the gift card section displays the error "Gift card number or PIN is missing"

  @giftcard
  Scenario: Error message when gift card number is missing
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586557 | 1   |
    And checkout button is pressed
    When the user applies gift cards
      | gift_card_no | pin  |
      |              | 1234 |
    Then the gift card section displays the error "Gift card number or PIN is missing"

  @giftcard
  Scenario: Apply multiple gift cards for payment and verify order balance and order total
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586526 | 1   |
      | 9351785586519 | 1   |
    And checkout button is pressed
    And the total on checkout is "164"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And clicking on Add another card link takes the focus to gift card text field
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    And the payment tabs are visible
    And the order balance remaining is "$44"

  @giftcard
  Scenario: Verify order total already paid off message
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586526 | 1   |
    And checkout button is pressed
    And the total on checkout is "20"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $20.00       | $80.00      |
    And the payment tabs are hidden
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card section displays the error "Order total already paid off"


  @giftcard
  Scenario: Removal of one gift card
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586571 | 1   |
    And checkout button is pressed
    And the total on checkout is "120"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are hidden
    And the user removes gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "$20"
    And the payment tabs are visible

  @giftcard
  Scenario: Removal of two gift cards
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586571 | 1   |
    And checkout button is pressed
    And the total on checkout is "120"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    And the payment tabs are hidden
    And the user removes gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
      | 2790030169169063156 | 2043 |
    Then the giftcard box is expanded
    And the payment tabs are visible

  @giftcard @adyen
  Scenario: Place order with gift cards only
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586571 | 1   |
    And checkout button is pressed
    And the total on checkout is "120"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And the user places order with only gift cards
    Then Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And the Thank You page shows the gift card number and redeemed amount as
      | payment_type                   | payment_amount |
      | Gift Card, ***************3156 | AU$100.00      |
      | Gift Card, ***************7149 | AU$20.00       |
    And in BM the order of "Don" has attributes
      | order_status | confirmation_status | export_status    | shipping_ststus |
      | OPEN         | Confirmed           | Ready for Export | Not Shipped     |
    And the payment section in BM shows the applied gift cards


  @giftcard @adyen @smoke_test
  Scenario: Place order with gift card and credit card
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And the total on checkout is "100"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "$80"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And the Thank You page shows the gift card number and redeemed amount as
      | payment_type                   | payment_amount |
      | Gift Card, ***************7149 | AU$20.00       |
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode     | authResult |
      | OPEN         | APPROVED     | AUTHORISATION | NA         |
    And the payment section in BM shows the applied gift cards


  @giftcard @afterpay
  Scenario: Place order with gift card and afterpay
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And the total on checkout is "100"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "$80"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And the Thank You page shows the gift card number and redeemed amount as
      | payment_type                   | payment_amount |
      | Gift Card, ***************7149 | AU$20.00       |
    And placed order total is verified and payment type is "Afterpay Pay Over Time"
    And in BM last order for "Don" is:
      | order_status | adyen_status | eventcode       | authResult |
      | OPEN         | APPROVED     | AFTERPAY_CREDIT | NA         |
    And the payment section in BM shows the applied gift cards


  @giftcard @paypal
  Scenario: Place order with gift card and paypal
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And the total on checkout is "100"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the order balance remaining is "$80"
    When user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | HD            |
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And paypal page shows order total of "80.00"
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And in BM last order for "Mark" is:
      | order_status | adyen_status | eventcode | authResult |
      | OPEN         | Completed    | verified  | NA         |

  @giftcard
  Scenario: Change shipping method such that order total exceeds gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And the total on checkout is "100"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    And the payment tabs are hidden
    And user changes the delivery method to "Express" so that the order total goes above gift card value
    And the payment tabs are visible
    And the order balance remaining is "$14"


  @giftcard
  Scenario: Change shipping method such that order total goes below gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785673554 | 1   |
    And checkout button is pressed
    And user changes the delivery method to "Express"
    And the total on checkout is "24"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    And the payment tabs are visible
    And the order balance remaining is "$4"
    And user changes the delivery method to "Standard" so that the order total goes above gift card value
    And the total on checkout is "16"
    And the payment tabs are hidden
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $16.00       | $4          |


  @giftcard
  Scenario: Change in delivery method after multiple gift cards are applied and order total goes above gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586571 | 1   |
    And checkout button is pressed
    And the total on checkout is "120"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
      | 2790030169169063156 | 2043 |
    Then the payment tabs are hidden
    And user changes the delivery method to "Express" so that the order total goes above gift card value
    Then the payment tabs are visible
    And the order balance remaining is "$14"


  @giftcard
  Scenario: Change in delivery method after multiple gift cards are applied and order total goes below gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785673554 | 1   |
    And checkout button is pressed
    And user changes the delivery method to "Express"
    And the total on checkout is "124"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $20.00       | 0           |
    Then the payment tabs are visible
    And the order balance remaining is "$4"
    And user changes the delivery method to "Standard" so that the order total goes below gict card value
    Then the payment tabs are hidden
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $10.00       | $10         |


  @giftcard
  Scenario: Change in delivery method after multiple gift cards are applied and order total goes below gift card value and gift card is automatically dropped
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And user changes the delivery method to "Express"
    And the total on checkout is "114"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $14.00       | $6          |
    Then the payment tabs are hidden
    And user changes the delivery method to "Standard" so that the order total goes below gift card value
    Then the payment tabs are hidden
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    And the gift card is automatically dropped from checkout page
      | gift_card_no        |
      | 2790030163867647149 |

  @giftcard
  Scenario: Modify bag by adding products and order total goes above gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And the total on checkout is "100"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    Then the payment tabs are hidden
    And a bag with products:
      | sku           | qty |
      | 9351785586571 | 1   |
    And checkout button is pressed
    And the total on checkout is "120"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    Then the payment tabs are visible
    And the order balance remaining is "$20"

  @giftcard
  Scenario: Product is removed from the bag and order total goes below gift card value and gift card is automatically dropped
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586557 | 1   |
    And checkout button is pressed
    And the total on checkout is "124"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $20.00       | 0           |
    Then the payment tabs are visible
    And the order balance remaining is "$4"
    And the user edits the bag from Checkout Page
    And the bag is modified
      | sku           | qty |
      | 9351785586557 | 0   |
    And checkout button is pressed
    And the total on checkout is "100"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    And the gift card is automatically dropped from checkout page
      | gift_card_no        |
      | 2790030163867647149 |
    And the payment tabs are hidden


  @giftcard
  Scenario: Update quantity and order total goes above gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586571 | 1   |
    And checkout button is pressed
    And the total on checkout is "120"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $20.00       | 0           |
    Then the payment tabs are hidden
    And the user edits the bag from Checkout Page
    And the bag is modified
      | sku           | qty |
      | 9351785586564 | 2   |
    And checkout button is pressed
    And the total on checkout is "220"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are visible
    And the order balance remaining is "$100"

  @giftcard @perks
  Scenario: Apply perks voucher and order total goes below gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
      | 9351785586557 | 1   |
    And checkout button is pressed
    And the total on checkout is "124"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are visible
    And the order balance remaining is "$4"
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    And the total on checkout is "114"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
      | ...163867647149 | $14.00       | $6          |
    And the payment tabs are hidden

  @giftcard @perks
  Scenario: Add two perks vouchers and order total goes below gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586571 | 6   |
    And checkout button is pressed
    And the total on checkout is "120"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    And the payment tabs are visible
    And the order balance remaining is "$20"
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the total on checkout is "100"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    And the payment tabs are hidden

  @giftcard @perks
  Scenario: Remove two perks vouchers and order total goes above gift card value
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586571 | 6   |
    And checkout button is pressed
    And the total on checkout is "120"
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the total on checkout is "100"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    And the payment tabs are hidden
    When the customer removes the perks voucher from Checkout Page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the total on checkout is "120"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $100.00      | 0           |
    And the payment tabs are visible
    And the order balance remaining is "$20"

  @giftcard @perks
  Scenario: Verify order total already paid off message when a perks voucher is applied
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785586564 | 1   |
    And checkout button is pressed
    And the total on checkout is "100"
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
    And the total on checkout is "90"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $90.00       | $10         |
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card section displays the error "Order total already paid off"

  @giftcard
  Scenario: Payment tabs are hidden when there is a balance of $0.10 left on gift card
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785673561 | 1   |
    And checkout button is pressed
    And user changes the delivery method to "Express"
    And the total on checkout is "99.90"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030169169063156 | 2043 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...169169063156 | $99.90       | $0.10       |
    Then the payment tabs are hidden

  @giftcard @perks
  Scenario: Behavior of gift cards when order total goes below perks voucher minimum spend threshold
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | John | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785673554 | 4   |
    And checkout button is pressed
    And the total on checkout is "46"
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9840150120702065 |
      | 9840150120702066 |
    And the total on checkout is "26"
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are visible
    And the order balance remaining is "$6"
    And the user edits the bag from Checkout Page
    And the bag is modified
      | sku           | qty |
      | 9351785673554 | 2   |
    And the user sees overlay popup message
      | message                                                               |
      | Sorry!                                                                |
      | Your Perks Welcome Voucher will be removed if you proceed to checkout |
      | Only available on orders AUD 25.00 and over                           |
    And checkout button is pressed
    And the total on checkout is "26"
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And the payment tabs are visible
    And the order balance remaining is "$6"
