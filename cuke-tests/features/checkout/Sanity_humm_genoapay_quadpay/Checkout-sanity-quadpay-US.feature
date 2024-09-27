Feature: Checkout - quadpay - COG-US

  Scenario: Checkout with quadpay as a guest user with normal product for an approved order
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "quadpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And on quadpay page user places an order with a "random approved" user
    Then "quadpay" Thankyou page is shown with details for the user
    And in BM last zip order for "Robert" is:
      | zip_order_status | zip_processor | zip_transaction | zip_receipt | zip_trsct_number_same |
      | OPEN             | Processor     | Transaction     | Receipt     | True                  |

  @wip
  Scenario: Declined scenario with quadpay as a guest user with normal product
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "quadpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And on quadpay page user places an order with a "declined" user
    Then on quadpay page declined message is displayed and user navigates back to CO page
    And in BM last zip order for "Robert" is:
      | zip_order_status | zip_processor | zip_transaction | zip_notes_status |
      | FAILED           | Processor     | Transaction     | Blank            |

  Scenario: Failed order scenario with quadpay as a guest user with normal product on clicking crss icon
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "quadpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And on quadpay page user clicks the cross icon
    And in BM last zip order for "Robert" is:
      | zip_order_status | zip_processor | zip_transaction | zip_notes_status |
      | FAILED           | Processor     | Transaction     | Blank            |

  Scenario: Verify the error for quadpay as a guest user with international delivery and billing addresses
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "GB" international delivery address
    And user selects the payment type as "quadpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And user sees the global error message:
      | error_message |
      | Quadpay is not available for delivery and billing addresses outside of United States |

  Scenario: Verify the error for quadpay as a guest user with national delivery and international billing addresses
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "quadpay"
    And "guest" user fills in billing details for "quadpay" with "AU" international address
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And user sees the global error message:
      | error_message |
      | Quadpay is not available for delivery and billing addresses outside of United States |

  Scenario: Verify the error for quadpay as a guest user with international delivery and national billing addresses
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Robert | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "AU" international delivery address
    And "guest" user fills in billing address details for "quadpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "quadpay"
    And user sees the global error message:
      | error_message |
      | Quadpay is not available for delivery and billing addresses outside of United States |