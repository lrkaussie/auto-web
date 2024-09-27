@au @giftwrap
Feature: Giftwrap - COG-AU - checkout and thankyou page

  As a customer shopping on cottonon.com
  I want to be able to see gift bags on checkout page
  and see changes on the thankyou page

  Assumptions:
  Site Preference 'Gift Wrapping Enabled' is 'ON'
  Site Preference 'Gift Wrapping Service Price' as '$6.99'
  Standard Cart:
  |         Product name          |     sku       |   Stock  | Price |
  | Brunswick Shirt 3             | 9351785780849 |  Instock | 29.95 |
  | Penny Pleat Skirt             | 9351785634425 |  Instock | 29.95 |
  | Twinkle Lights 1.5M           | 9351533886625 |  Instock | 9.99  |
  | 2018 A1 Wall Calender         | 9351533902226 |  Instock | 49.99 |

  Personalised Cart = Standard Cart + Below Personalised Item:
  |         Product name              |     sku       |   Stock  |Price|
  | Personalised Baby Footless Romper | 9351533254769 |  Instock |23.95|

  Design Reference:
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673e7659ff50f4bad377e
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fb7d563e1336df698a
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fe06c74a22b16b1a8b

  The customer has the <field> saved with <values>
  |field|values|
  |To|Mark|
  |From|Richard|
  |Message|Merry Christmas|

  and Personalised Gift Bag
  "Standard Gift Bag" plus
  |sku|           |quantity|
  |9351533254769| |1|

  @registered @mybag @gw1
  Scenario: Delivery methods available on My Bag page with Gift Bag and without Personalised Product
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following products to cart using quantity dropdown
      |      sku      | qty |
      | 9351785780849 |  3  |
      | 9351785634425 |  2  |
      | 9351533886625 |  5  |
      | 9351533902226 |  1  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "I NEED IT" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                  |
      | 9351785780849 |  3  | Brunswick Shirt 3      |
      | 9351785634425 |  2  | Penny Pleat Skirt      |
      | 9351533886625 |  5  | Twinkle Lights 1.5M    |
      | 9351533902226 |  1  | 2018 A1 Wall Calender  |
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    Then I validate mybag page:
      |delivery|available_del_methods|
      |Standard|Standard,Melbourne Metro Same Day,Click & Collect,Express,International|

  @registered @checkout @adyen @smoke_test @gw1
  Scenario: Checkout with Gift Bag and without Personalised Product
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following products to cart
      |      sku      | qty |
      | 9351533902226 |  1  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "I NEED IT" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                  |
      | 9351533902226 |  1  | 2018 A1 Wall Calender  |
    And I enter the following text in Make it a Gift page
      | To    | From | Message                           |
      | Mark  | Richard | Merry Christmas |
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    And I click on Checkout button on My Bag page
    And I validate Checkout page:
      |title_of_giftwrap_section|To  |From   |gift_bag_items|
      |Gift Wrap                |Mark|Richard|1             |
    When the user fills in details for a home delivery order
    And user selects the payment type as "adyen_valid_creditcard"
    And the user clicks on the Continue to Payment button on the Checkout page for "Credit Card"
    And on adyen HPP user places an order
    Then Adyen Thankyou page is shown with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And I validate the order summary section in thankyou page:
      |title        |
      |Gift Wrap    |
    And placed order total is verified and payment type is "Credit Card"
    And tax amount is "5.09"
    And in BM last order for "Giftwrap" is:
      | order_status | adyen_status| eventcode     | authResult | product_name|
      | OPEN         | APPROVED    | AUTHORISATION | NA         | Gifting     |