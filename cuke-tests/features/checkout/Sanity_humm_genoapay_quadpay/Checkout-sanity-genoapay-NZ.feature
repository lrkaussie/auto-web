Feature: Checkout - genopay - COG-NZ

  As a user I want to check out with genopay as the payment provider
  In NZ, we have these products
  | sku           |  price |
  | 9351785722986 |  7.99  |
  | 9352403005290 |  36.96 |

  users used are Robin and Bob
  non-promotional product will be used in standard cart
  product promotion - autotest_product - Buy 1 get $1 discount where applies
  order promotion - autotest_order - Buy 2 get 20% discount where applies
  shipping promotion - autotest_shipping - Buy 3 get $1 discount on shipping where applies
  default shipping is $6
  Assume configured payment method is genopay

  Scenario: Checkout with Genopay as a guest user with normal product for an approved order
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | NZ      | Bob  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785722986 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "genoapay"
    And the user clicks on the Continue to Payment button on the Checkout page for "genoapay"
    And on "genoapay" page user places an order with a random user
    Then "genoapay" Thankyou page is shown with details for the user
    And in BM last "genoapay" order for "Bob" is:
      | genoapay_order_status | genoapay_processor | genoapay_transaction | genoapay_invoice | genoapay_order_true |
      | OPEN                  | GENOAPAY           | true                 | true             | true                |

  @wip
  Scenario: Verify the failed order as a guest user with normal product by clicking cross link on genoapay page after logging in
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | NZ      | Bob  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785722986 | 2   |
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "genoapay"
    And the user clicks on the Continue to Payment button on the Checkout page for "genoapay"
    And on "genoapay" page user places an order with an existing user
    And on "genoapay" page user clicks on the cross link after login
    Then in BM last "genoapay" order for "Jesse" is:
      | genoapay_order_status | genoapay_processor |  genoapay_invoice | genoapay_order_true |
      | FAILED                | Genoapay           |  false            | true                |

  Scenario: Verify genoapay failed order as a guest user with mixed cart for a Browser back scenario before logging in
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | NZ      | Bob  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785722986 | 1   |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9352403005290 | 1   | XX                   |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "genoapay"
    And the user clicks on the Continue to Payment button on the Checkout page for "genoapay"
    And on "genoapay" page user clicks browser back
    Then in BM last "genoapay" order for "Jesse" is:
      | genoapay_order_status | genoapay_processor |  genoapay_invoice | genoapay_order_true |
      | FAILED                | Genoapay           |  false            | true                |


