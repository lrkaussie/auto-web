@cash_on_delivery @my
Feature: Order Placement - CashOnDelivery - COG-MY
  As a user I want to place order using Cash On Delivery as the payment method

Assumption:
  In MY, we have these products
  | Colour     |  SKU          | Size | Type        | Product Type |
  | 2000310-01 | 9350486746666 | S    | Multi size  | Normal       |
  | 419004-02  | 9351785851242 | NA   | single size | Personalised |
  | 130664-00  | 9351785509303 | NA   | single size | Normal       |
  | 260388-06  | 9344943354983 | 10   | Multi size  | Normal       |

  The following users exist in Commerce Cloud and used for registered user scenarios
  | Email                        | First Name | Last Name | Commerce Cloud Account |
  | cottononqa+MYvincy@gmail.com | Adam       | Amin      | Yes                    |

  @guest
  Scenario: Checkout with guest user and Cash on delivery, HD, normal and personalise products w/o promotion
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851242 | 1   | XX                   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "cash_on_delivery"
    And the "message" is displayed on Checkout page below Cash On Delivery payment method
    | message                                                                                           |
    | We will send you an SMS on the day your order is coming and deliver it straight to your doorstep. |
    | You simply pay our delivery driver in cash and collect your order.                                |
    And the user clicks on the Continue to Payment button on the Checkout page for "COD"
    Then cash on delivery Thankyou page is displayed with details for the user
    And placed order total is verified and payment type is "Cash On Delivery"
    And in BM last order for "Adam" is:
      | order_status | payment_method   | order_amount |
      | OPEN         | CASH_ON_DELIVERY | RM231.00     |

  @guest
  Scenario: Checkout with guest user and Cash on delivery, HD, normal product with product promotion
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9351785509303 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And the price of product before any promotion is "30.00"
    And promo code added on bag "autotest_product"
    And the price of product after product promotion applied is "29.00"
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then cash on delivery Thankyou page is displayed with details for the user
    And placed order total is verified and payment type is "Cash On Delivery"
    And in BM last order for "Adam" is:
      | order_status | payment_method   | order_amount |
      | OPEN         | CASH_ON_DELIVERY | RM36.00     |


  @guest
  Scenario: Checkout with guest user and Cash on delivery, HD, normal product with shipping promotion
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart using quantity dropdown
      | sku           | qty |
      | 9344943354983 | 3   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user changes the delivery method to "Next Day Shipping"
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then cash on delivery Thankyou page is displayed with details for the user
    And placed order total is verified and payment type is "Cash On Delivery"
    And in BM last order for "Adam" is:
      | order_status | payment_method   | order_amount |
      | OPEN         | CASH_ON_DELIVERY | RM277.00     |


  @registered
  Scenario: Checkout with registered user and Cash on delivery, HD, normal and personalise products with Order promotion
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | registered   | sign-in      | logged_in |
    When I add the following products to cart using quantity dropdown
      | sku           | qty |
      | 9351785509303 | 2   |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851242 | 1   | XX                   |
    And I navigate to bag page by clicking the minicart icon
    And promo code added on bag "autotest_order"
    And checkout button is pressed
    And "registered" user fills in details for "home" delivery
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then cash on delivery Thankyou page is displayed with details for the user
    And placed order total is verified and payment type is "Cash On Delivery"
    And in BM last order for "Adam" is:
      | order_status | payment_method   | order_amount |
      | OPEN         | CASH_ON_DELIVERY | RM220.00     |


  @guest
  Scenario: Checkout as guest user with payment method as Gift card and Cash on delivery, HD, normal and personalise products w/o promotion
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851242 | 1   | XX                   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030259169063156 | 1234 |
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then cash on delivery Thankyou page is displayed with details for the user
    And the payment section on the Thankyou page shows the details
      | payment_type     | payment_amount |
      | Cash On Delivery | RM181.00       |
    And the Thank You page shows the gift card number and redeemed amount as
      | payment_type                   | payment_amount |
      | Gift Card, ***************3156 | RM50.00        |
    And placed order total is verified and payment type is "Cash On Delivery"
    And in BM last order for "Adam" is:
      | order_status | payment_method   | order_amount |
      | OPEN         | CASH_ON_DELIVERY | RM181.00     |
    And the payment section in BM shows the applied gift cards


  @guest
  Scenario: Checkout as guest user with payment method as Cash on delivery, loyalty voucher, HD, normal and personalise products w/o promotion
    Given I log on to the site with the following:
      | site | country | user  | type_of_user | landing_page | user_state    |
      | COG  | MY      | Adam  | guest        | sign-in      | not_logged_in |
    When I add the following products to cart
      | sku           | qty |
      | 9350486746666 | 1   |
    And I add the following personalised products:
      | sku           | qty | personalised_message |
      | 9351785851242 | 1   | XX                   |
    And I navigate to bag page by clicking the minicart icon
    And checkout button is pressed
    And user checks out with details:
      | user_type | address | delivery_type |
      | guest     | house   | DEFAULT       |
    And user enters the voucher in the perks section on the checkout page
      | voucher_id       |
      | 9870150120702065 |
    And user selects the payment type as "cash_on_delivery"
    And the user clicks on the Continue to Payment button on the Checkout page for "COD" 
    Then cash on delivery Thankyou page is displayed with details for the user
    And the payment section on the Thankyou page shows the details
      | payment_type     | payment_amount |
      | Cash On Delivery | RM221.00       |
    And placed order total is verified and payment type is "Cash On Delivery"
    And in BM last order for "Adam" is:
      | order_status | payment_method   | order_amount |
      | OPEN         | CASH_ON_DELIVERY | RM221.00     |