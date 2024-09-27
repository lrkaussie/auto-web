Feature: Giftwrap - COG-US - checkout and thankyou page

  As a customer shopping on cottonon.com
  I want to be able to see gift cards while cretaing gift bags bags on checkout page
  and see changes on the thankyou page

  Assumptions:
  Site Preference 'Gift Wrapping Enabled' is 'ON'
  Site Preference 'Gift Wrapping Service Price' as '$6'
  Standard Cart:
  |         Product name            |     sku       |   Stock  | Price |
  | Istanbul Foldable Duffle Bag    | 9351785858555 |  Instock | 34.95 |
  | Kimi Scooped Bodycon Midi Dress | 9350486941696 |  Instock | 19.95 |

  Personalised Cart = Standard Cart + Below Personalised Item:
  | Product name        | sku           | Stock   | Price |
  | Personalised Candle | 9350486069246 | Instock | 10.00 |

  @registered @mybag @gw1
  Scenario: Delivery methods available on My Bag page with Gift Bag and without Personalised Product
    Given I log on to the site with the following:
      | site | country| user | type_of_user | landing_page | user_state |
      | COG  | US     | Filip | registered  | sign-in       | logged_in  |
    And I add the following products to cart using quantity dropdown
      |      sku      | qty |
      | 9351785858555 |  1  |
      | 9350486941696 |  1  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                           |
      | 9351785858555 |  1  | Istanbul Foldable Duffle Bag    |
      | 9350486941696 |  1  | Kimi Scooped Bodycon Midi Dress |
    And I select gift card as "TEST-CARD" from Choose your card section
    And I enter the message as "with Love" in the message section
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    Then I validate mybag page:
      |gift_card_text|
      |with Love     |

  @registered @checkout @adyen @smoke_test @gw1
  Scenario: Checkout with Gift Bag and with Personalised Product
    Given I log on to the site with the following:
      | site | country| user  | type_of_user | landing_page | user_state |
      | COG  | US     | Filip | registered  | sign-in       | logged_in  |
    And I add the following products to cart using quantity dropdown
      |      sku      | qty |
      | 9351785858555 |  1  |
      | 9350486941696 |  1  |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9350486069246 |  1  |YY                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                           |
      | 9351785858555 |  1  | Istanbul Foldable Duffle Bag    |
      | 9350486941696 |  1  | Kimi Scooped Bodycon Midi Dress |
      | 9350486069246 |  1  | Personalised Candle             |
    And I select gift card as "TEST-CARD" from Choose your card section
    And I enter the message as "with Love" in the message section
    And I hit I'm done Create my Gift! button
    And I land on My Bag page
    And I click on Checkout button on My Bag page
    And I validate Checkout page:
      |title_of_giftwrap_section|giftwrap_section_text|gift_bag_items|
      |Gift Wrap                |with Love            |3             |
    When the user fills in details for a home delivery order
    And user selects the payment type as "adyen_valid_creditcard"
    And the user enters adyen details for "Credit Card" for single page checkout form
    And the user places order on the Checkout page for "Credit Card"
    Then Adyen Thankyou page is shown for the SPC with details for the user
    And "HD" delivery address is shown on the Adyen Thankyou page
    And I validate the order summary section in thankyou page:
      |title        |
      |Gift Wrap    |
    And placed order total is verified and payment type is "Credit Card"
    And in BM last order for "Filip" is:
      | order_status | adyen_status| eventcode     | authResult | product_name|
      | OPEN         | APPROVED    | AUTHORISATION | NA         | REINDEER    |