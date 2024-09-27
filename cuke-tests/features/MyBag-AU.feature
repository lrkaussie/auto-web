@mybag @au
Feature: MyBag - COG-AU

  As a user I want to check the behaviour of mybag page
  In AU, we have these products
  | sku           | vg_id     | promo | price | product_promotion_price | order_discount | comments     |
  | 9351785509303 | 141114-00 | Y     | 12.95 | 11.95                   | 5.18           |              |
  | 9351785586526 | 270882-03 | N     | 24    | NA                      | NA             |              |
  | 9351785092140 |           | N     | 49.99 | NA                      | NA             |              |
  | 9351785851327 |           | N     | 39.95 | NA                      |                | personalised |
  | 9351785851242 |           | N     | 39.95 | NA                      |                | personalised |
  | 9354233660489 | EGIFT DESIGN 02   | N     | NA    | NA              | NA             | Egift Card   |
  | 130664        | 130664    | N     | 12.95 | NA    |

  Promotions used autotest_product, autotest_order, autotest_shipping
  default shipping is $6
  HD is $6, cnc is $3

  @perf @guest
  Scenario: Update quantity on mybag with nonpromotional products and check order total on mybag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785092140 | 2   |
    Then I validate mybag page:
      | order_total |
      | 99.98       |

  @perf @registered @rerun @wip
  Scenario: Remove items on mybag and check order total on mybag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785509303 | 0   |
    Then I validate mybag page:
      | order_total |
      | 55.99       |

  @perf @guest
  Scenario: Change Delivery methods on mybag and check order total on mybag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When I change delivery method to "Express"
    Then I validate mybag page:
      | order_total |
      | 63.99       |

  @perf @registered
  Scenario: Update quantity on mybag with nonpromotional products and check order total on checkout page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  |empty      |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785092140 | 2   |
    And the order total in the Order Summary section on My Bag page is "99.98"
    When user selects to checkout from their bag
    Then I validate the order summary section in checkout page:
      | order_total | delivery |
      | 99.98       | FREE     |

  @perf @guest
  Scenario: Remove items on mybag and check order total on mybag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785509303 | 0   |
    When user selects to checkout from their bag
    Then I validate the order summary section in checkout page:
      | order_total | delivery |
      | 55.99       | 6.00     |

  @perf @registered
  Scenario: Change Delivery methods on mybag and check order total on checkout page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And a bag with products:
      | sku           | qty |
      | 9351785509303 | 1   |
    And I click on View Cart button
    When I change delivery method to "Express"
    And I click on Checkout button on My Bag page
    Then I validate the order summary section in checkout page:
      | order_total | delivery |
      | 26.95       | 14.00    |

  @perf @personalisation
  Scenario: Validate mybag page for personalised product
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
      | 9351785851242 | 1   | YY                   |
    When I click on View Cart button
    Then I validate mybag page:
      | order_total |
      | 88.90       |

  @perf @personalisation
  Scenario: Validate mybag page for personalised product after removal of personalised product
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
      | 9351785851242 | 1   | YY                   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785851327 | 0   |
    Then I validate mybag page:
      | order_total |
      | 48.95       |

  @perf @personalisation
  Scenario: Automatic selection of shipping method when personalised product is in the cart
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    When I click on View Cart button
    Then I validate mybag page:
      | delivery                             |
      | Standard Delivery (AU)- Personalised |

  @perf @guest
  Scenario: Validate empty cart page text scenario
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And user navigates to "gifts/novelty-gifts" page
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785092140 | 0   |
    Then I validate mybag page:
      | text_on_page      | continue_shopping_button |
      | Your bag is empty | true                     |
    And I click on Continue Shopping link
    Then the user stays on PLP of "gifts/novelty-gifts"

  @perf @guest
  Scenario: Validate continue shopping not present on empty cart page scenario
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When the bag is modified
      | sku           | qty |
      | 9351785092140 | 0   |
    Then I validate mybag page:
      | text_on_page      | continue_shopping_button |
      | Your bag is empty | false                    |

  @perf @registered
  Scenario: Add products to Wishlist from MyBag page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the following products to cart
      | sku           | qty |
      | 9351785092140 | 1   |
      | 9351785586526 | 1   |
    And I click on View Cart button
    When I add the product to Wishlist from bag page
      | products  |
      | 141114-00 |
      | 270882-03 |
    And I navigate to Wishlist page
    Then the products displayed on Wishlist page are
      | product   |
      | 141114-00 |
      | 270882-03 |

  @perf @registered
  Scenario: Remove products from Wishlist which are added through MyBag page
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the following products to cart
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    When I add the product to Wishlist from bag page
      | products  |
      | 141114-00 |
    And I navigate to Wishlist page
    When I remove the products from Wishlist page
      | product   |
      | 141114-00 |
    Then the message "You have no saved items." is displayed on Wishlist page

  @perf @guest
  Scenario: Validate Free returns configurable text in My Bag page as Guest
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the following products to cart
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    Then the title of the Free Returns section on My Bag page displays "Free Returns Cart page"
    And the description of the Free Returns section on My Bag page displays "Online & In-Store"

  @perf @register
  Scenario: Validate Free Returns configurable text in MyBag page as Register
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I add the following products to cart
      | sku           | qty |
      | 9351785092140 | 1   |
    And I click on View Cart button
    Then the title of the Free Returns section on My Bag page displays "Free Returns Cart page"
    And the description of the Free Returns section on My Bag page displays "Online & In-Store"

  @zip
  Scenario: Validate bnpl logos and bnpl tagline on bag page with normal product and with no. of weeks config
      Given I log on to the site with the following:
        | site | country | user | type_of_user | landing_page | user_state    |
        | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
      When I add the following products to cart
        | sku           | qty |
        | 9351785092140 | 1   |
      And I click on View Cart button
      Then bnpl logos are displayed on My Bag page
      And bnpl tagline with text as "Or buy now from AU$14.00 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl logos and bnpl tagline on bag page with personalised product and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And I click on View Cart button
    Then bnpl tagline with text as "Or buy now from AU$12.24 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl tagline on bag page with egift card only and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |adam           |abc@abc.com    |abc@abc.com        |gilli       |msg2       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    Then bnpl tagline with text as "Or buy now from AU$5.00 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl tagline on bag page with mixed cart(normal+personlised+egift) and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9351785092140 | 1   |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851327 | 1   | XX                   |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |adam           |abc@abc.com    |abc@abc.com        |gilli       |msg2       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    Then bnpl tagline with text as "Or buy now from AU$29.74 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl tagline on bag page with product promotion and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku    | qty |
      | 130664 | 1   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id       |
      | autotest_product |
    And the price of product after product promotion applied is "11.95"
    Then bnpl tagline with text as "Or buy now from AU$4.49 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl tagline on bag page with order promotion and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku    | qty |
      | 130664 | 2   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id     |
      | autotest_order |
    And the order discount in the Order Summary section on My Bag page is "5.18"
    Then bnpl tagline with text as "Or buy now from AU$6.68 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl tagline on bag page with shipping promotion and with no. of weeks config
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku    | qty |
      | 130664 | 3   |
    When customer enters the coupon in the Perks Voucher section on My Bag page
      | voucher_id        |
      | autotest_shipping |
    And the order total in the Order Summary section on My Bag page is "43.85"
    Then bnpl tagline with text as "Or buy now from AU$10.96 per week" is displayed on My bag page

  @zip
  Scenario: Validate bnpl tagline on bag page on US site
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    And a bag with products:
      | sku           | qty |
      | 9351785334462 | 3   |
    Then bnpl tagline with text as "Or pay in 4 installments of US$5.00" is displayed on My bag page