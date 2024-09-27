@au @egiftcard
Feature: eGiftCard - COG-AU
  As a Cotton On Customer
  I want to add eGiftCards to my basket and buy them

  Designs:  https://app.zeplin.io/project/5b3ad6e81df33a4b7fa45180/

  Assumption
  GiftCard Product Images exist if not then upload it using Import & Export under Merchant Tools >  Products and Catalogs
  egiftcards-catalog.xml and egiftcards-nav-catalog-au.xml Catalogues exist
  egiftcards-inventory-au.xml Inventory exist
  BM Configuration:- Merchant Tools > Site Preferences > Custom Site Preference Groups > Gift Cards

  Online Store ID - 3995
  e-Gift Cards Master Product ID - 000121
  Site code - AU
  Import Customer Groups: Merchant Tools >  Customers >  Import & Export > Customer Group Import
  File name - customer-groups.xml
  Import Shipping Methods: Merchant Tools >  Ordering >  Import & Export > Shipping Method Import
  File name - email-shipping-method.xml
  Change Shipping Methods for Active/ Default and all other delivery except personalisation -> Customer Groups to NormalDelivery


  In AU, we have these products

  | sku            | price |
  | 9354233660489  |  na   |
  | 9354233205772  |  na   |
  | 9354233205789  |  na   |
  | 9354233205796  |  na   |
  | 9354233205802  |  na   |
  | 9354233205819  |  na   |
  | 9354233205826  |  na   |
  | 9354233205833  |  na   |
  | 9354233205840  |  na   |
  |	9354233205857  |  na   |

  msg1 is message text which will be 120 characters



  @guest @pdp
  Scenario Outline: Verify user cannot add eGiftCards if mandatory fields are not entered
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state|
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select <design>, <amount> on eGiftCard page
    When I enter <recipient_name>, <recipient_email>, <recipient_conf_email>, <senders_name> on eGiftCard page
    And the user clicks on Add to Bag for eGiftCard
    Then the error message on eGiftCard page is <error_message>
    Examples:
      |design|amount|recipient_email|recipient_conf_email|recipient_name|senders_name|error_message                           |
      |des_1 |empty |abc@abc.com    |abc@abc.com         | xyz          |def         |Select or enter amount                  |
      |des_1 |10    |abc@abc.com    |abc@abc.com         | empty        |def         |Please enter a value for Recipient Name |
      |des_1 |10    |empty          |abc@abc.com         | xyz          |def         |Please enter a value for Recipient Email|
      |des_1 |10    |abc@abc.com    |empty               | xyz          |def         |Please confirm your Recipient Email     |
      |des_1 |10    |abc@abc.com    |abc@abc.com         | xyz          |empty       |Please enter a value for Senders Name   |
      |des_1 |10    |abc@abc.com    |efg@abc.com         | xyz          |def         |Recipient Email address does not match  |
      |des_1 |501   |abc@abc.com    |abc@abc.com         | xyz          |def         |The e-gift card amount can only be between $10-$500|

  @guest @mybag @plp
  Scenario: Verify user can add 2 eGiftCards to My Bag and validations on My Bag
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And I search for "eGift"
    And I select "000121-08" on PLP
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 08 |10    |mark          |def@def.com    |def@def.com         |don         |msg8       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |adam           |abc@abc.com    |abc@abc.com        |gilli       |msg2       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    Then mybag page cart details are:
      |order_total|available_del_methods|
      | 30.00     |Standard, International, Click & Collect, MelbourneMetro, Express|
    And mybag page has the following egift card products:
      |recipient_name|senders_name|senders_msg|design          |
      |adam          |gilli       |msg2       |egift design 02 |
      |mark          |don         |msg8       |egift design 08 |


  @registered @mybag @deliverymethods
  Scenario: Verify user can add 1 eGiftCard, 1 regular item to My Bag and validations on My Bag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    When I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following products to cart
      |      sku      | qty |
      | 9351533625590 |  1  |
    And I click on View Cart button
    Then mybag page cart details are:
      |order_total|available_del_methods|
      | 35.95     |Standard, International, Click & Collect, MelbourneMetro, Express|
    And mybag page has the following egift card products:
      |recipient_name|senders_name|senders_msg|design          |
      |abc           |xyz         |msg1       |egift design 02 |

  @registered @mybag @deliverymethods
  Scenario: Verify user can add 1 eGiftCard, 1 personalised item to My Bag and validations on My Bag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351785851327 |  1  |XX                  |
    And I click on View Cart button
    Then mybag page cart details are:
      |order_total|available_del_methods|
      | 58.95     |Standard (Personalisation)|
    And mybag page has the following egift card products:
      |recipient_name|senders_name|senders_msg|design          |
      |abc           |xyz         |msg1       |egift design 02 |

  @guest @mybag
  Scenario: Verify user can remove eGiftCard from My Bag redirects to empty bag page
            if no other items in the bag
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in|not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    When the user removes the eGiftCard "egift design 02" from My Bag page
    Then mybag page cart details are:
      |text_on_page|continue_shopping_button|
      |Your bag is empty|false              |

  @registered @mybag @deliverymethods
  Scenario: Verify user can remove eGiftCard from My Bag which has a combination of
    regular item and personalised item
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785851327 |  1  |XX                  |
    And I click on View Cart button
    When the user removes the eGiftCard "egift design 02" from My Bag page
    Then mybag page cart details are:
      |order_total|available_del_methods|
      |68.90      |Standard (Personalisation)|

  @registered @delivery_methods @mybag
  Scenario: Verify delivery methods for mybag with 1 personalised item in a Giftwrap and eGiftCard
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351785851327 |  1  |XX                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                       |
      | 9351785851327 |  1  |Personalised Blaze Backpack  |
    When I hit I'm done Create my Gift! button
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    Then mybag page cart details are:
      |delivery|
      |Standard Delivery (AU)- Personalised|

  @guest @checkout @email @adyen @smoke_test
  Scenario: Guest user can place order with eGiftCard
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "email" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "Credit Card"
    And "email" delivery address is shown on the Adyen Thankyou page
    And I validate the order summary section in thankyou page:
      |title        |
      |egift design 02|

    @registered @checkout @hd @adyen
  Scenario: Registered user can place order with eGiftCard, personalised item and regular item
      Given I log on to the site with the following:
        | site | country | user | type_of_user | landing_page | user_state | cart_page |
        | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785851327 |  1  |XX                  |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And I validate the order summary section in thankyou page:
      |title        |
      |egift design 02|
      |Lola Midi Dress|
      |Personalised Blaze Backpack|
    And placed order total is verified and payment type is "Credit Card"


  @guest @checkout @hd @orderpromo @adyen
  Scenario: Guest user can place order with eGiftCard, order promotional item
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |e_giftcard_sku.html|not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following products to cart
      |      sku      | qty |
      | 9351785509303 | 2   |
    And I click on View Cart button
    And promo code added on bag "autotest_order"
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And I validate the order summary section in thankyou page:
      |title        |
      |egift design 02|
      |Visual Diary A4|
    And placed order total is verified and payment type is "Credit Card"

  @guest @checkout @cnc @paypal
  Scenario: Guest user can place order with eGiftCard, and regular item click and collect order and paypal
    paypal as the payment method
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following products to cart
      |      sku      | qty |
      | 9351533625590 |  1  |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "cnc" delivery
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And "CNC" delivery address is shown on the Paypal Thankyou page
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And I validate the order summary section in thankyou page:
      |title          |
      |egift design 02|
      |Lola Midi Dress|

  @guest @checkout @hd @giftcard @adyen
  Scenario: Guest user can order eGiftCard using adyen and giftcard redemption as payment method
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in    |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |30    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "email" delivery
    And the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "Credit Card"
    And the Thank You page shows the gift card number and redeemed amount as
      | payment_type                   | payment_amount |
      | Gift Card, ***************7149 | AU$20.00       |
    And I validate the order summary section in thankyou page:
      |title          |
      |egift design 02|

  @guest @checkout @hd @giftcard @adyen
  Scenario: Guest user can order 2 eGiftCards using adyen and giftcard redemption as payment method
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    And "guest" user fills in details for "email" delivery
    When the user applies gift cards
      | gift_card_no        | pin  |
      | 2790030163867647149 | 1234 |
    Then the gift card is applied under gift card section and the amount taken as
      | gift_card_no    | amount_taken | amount_left |
      | ...163867647149 | $20.00       | 0           |
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "Credit Card"
    And the Thank You page shows the gift card number and redeemed amount as
      | payment_type                   | payment_amount |
      | Gift Card, ***************7149 | AU$20.00       |
    And I validate the order summary section in thankyou page:
      |items|
      |egift design 01|
      |egift design 02|

  @guest @checkout @hd @afterpay
  Scenario: Guest user can place order with eGiftCard and personalised item
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |30    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351785851327 |  1  |XX                  |
    And I click on View Cart button
    And user selects to checkout from their bag
    When "guest" user fills in details for "home" delivery
    And "guest" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Afterpay Thankyou page
    And I validate the order summary section in thankyou page:
      |title          |
      |egift design 02|
      |Personalised Blaze Backpack|
    And placed order total is verified and payment type is "Afterpay Pay Over Time"

  @registered @checkout @hd @adyen
  Scenario: Registered user can place order with only eGiftCard and payment method as adyen
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in contact details
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And I validate the order summary section in thankyou page:
      |title        |
      |egift design 02|
    And placed order total is verified and payment type is "Credit Card"

  @registered @checkout @hd @adyen
  Scenario: Registered user can place order with only eGiftCard and payment method as paypal
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    When "registered" user fills in contact details
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And I validate the order summary section in thankyou page:
      |title        |
      |egift design 02|

  @guest @checkout @hd @giftcard @adyen
  Scenario: Guest user places order with eGiftCards using adyen as payment method but after removing the first added egift card
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    And the user edits the bag from Checkout Page
    And the user removes the eGiftCard "egift design 01" from My Bag page
    And user selects to checkout from their bag
    And "guest" user fills in details for "email" delivery
    And user selects the payment type as "adyen_valid_creditcard"
    And "guest" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "Credit Card"
    And I validate the order summary section in thankyou page:
      |items|
      |egift design 02|

  Scenario: Guest user places order with eGiftCard after removing the already added regular item with paypal as the payment method
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page       |user_state   |
      |COG |AU     |Don |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following products to cart
      |      sku      | qty |
      | 9351533625590 |  1  |
    And I click on View Cart button
    And user selects to checkout from their bag
    And the user edits the bag from Checkout Page
    And the user removes the "9351533625590" product from the cart
    And user selects to checkout from their bag
    And "guest" user fills in details for "email" delivery
    And user selects the payment type as "paypal"
    And user clicks on checkout with Paypal button
    And on the paypal page user enters the details to log in
    And on paypal store page user places an order
    Then Paypal Thankyou page is shown with details for the user
    And placed order total is verified and payment type is "PayPal Express Checkout"
    And I validate the order summary section in thankyou page:
      |title          |
      |egift design 02|


  @registered @checkout @hd @giftcard @adyen
  Scenario: Registered user places order with eGiftCards using adyen as payment method but after removing the first added egift card
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 01 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |20    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I click on View Cart button
    And user selects to checkout from their bag
    And the user edits the bag from Checkout Page
    And the user removes the eGiftCard "egift design 01" from My Bag page
    And user selects to checkout from their bag
    When "registered" user fills in contact details
    And user selects the payment type as "adyen_valid_creditcard"
    And "registered" user fills in billing address details for "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    And Adyen Thankyou page is shown with details for the user
    Then Adyen Thankyou page is shown with details for the user
    And I validate the order summary section in thankyou page:
      |items|
      |egift design 02|
    And placed order total is verified and payment type is "Credit Card"

  Scenario: Registered user places order with eGiftCard after removing the already added regular item with afterpay as the payment method
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And the user navigates to PDP of the product "9354233660489"
    And I select the following on eGiftCard page:
      |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
      |EGIFT DESIGN 02 |10    |abc           |abc@abc.com    |abc@abc.com         |xyz         |msg1       |
    And the user clicks on Add to Bag for eGiftCard
    And I add the following products to cart
      |      sku      | qty |
      | 9351533625590 |  1  |
    And I click on View Cart button
    And user selects to checkout from their bag
    And the user edits the bag from Checkout Page
    And the user removes the "9351533625590" product from the cart
    And user selects to checkout from their bag
    When "registered" user fills in contact details
    And "registered" user fills in billing address details for "afterpay"
    And the user clicks on the Continue to Payment button on the Checkout page for "Afterpay"
    And on Afterpay page user places an order on "AU" site
    Then Afterpay Thankyou page is shown with details for the user
    And I validate the order summary section in thankyou page:
      |title          |
      |egift design 02|
    And placed order total is verified and payment type is "Afterpay Pay Over Time"

