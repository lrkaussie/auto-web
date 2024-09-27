@au @giftwrap
Feature: Giftwrap - COG-AU - create

  As a customer shopping on cottonon.com
  I want to be able to create gift bags and add items to item
  so that I can get these items gift wrapped when it's delivered.

  Assumptions:
  Site Preference 'Gift Wrapping Enabled' is 'ON'
  Site Preference 'Gift Wrapping Service Price' as '$6.00'
  |         Product name          |     sku       |   Stock  |
  | Hattie Ruffle Tshirt Dress    | 9351785410920 |  Instock |
  | Novelty Pillow Cases Set Of 2 | 9351785126098 |  Instock |
  | Jaqlin Pant                   | 9351533838457 |  Instock |
  | PERSONALISED BLAZE BACKPACK   | 9351785851327 |  Instock |
  | Personalised Blaze Backpack   | 9351785851242 |  Instock |
  | Lola Midi Dress               | 9351533625590 |  Instock |

  Design Reference:
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673e7659ff50f4bad377e
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fb7d563e1336df698a
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fe06c74a22b16b1a8b

  Background:
  | Gift Bag     |      sku      |
  | REINDEER     | 9353699520481 |
  | GINGER BREAD | 9353699520498 |
  | MARIAH CAREY | 9353699520504 |
  | I NEED IT    | 9353699520511 |
  | THE NEW NICE | 9353699520528 |
  | MERRY VERY   | 9353699520535 |

  @registered @gw2
  Scenario: Create Gift wrap for different quantities of items and add customise message to My Bag
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following products to cart
      |      sku      | qty |
      | 9351533625590 |  1  |
      | 9351785126098 |  1  |
      | 9351533838457 |  1  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                         |
      | 9351533625590 |  1  | Lola Midi Dress               |
      | 9351785126098 |  1  | Novelty Pillow Cases Set Of 2 |
      | 9351533838457 |  1  | Jaqlin Pant                   |
    And I see the following products added in Your Gift Bag is looking good! section
      |      sku      | qty | title                         |
      | 9351533625590 |  1  | Lola Midi Dress               |
      | 9351785126098 |  1  | Novelty Pillow Cases Set Of 2 |
      | 9351533838457 |  1  | Jaqlin Pant                   |
    And I enter the following text in Make it a Gift page
      | To    | From | Message              |
      | Jack  | John | Happy Birthday Jack! |
    When I hit I'm done Create my Gift! button
    Then I see the Gift Bag with following Products in Bag
      |      sku      | qty | title                         |
      | 9351533625590 |  1  | Lola Midi Dress               |
      | 9351785126098 |  1  | Novelty Pillow Cases Set Of 2 |
      | 9351533838457 |  1  | Jaqlin Pant                   |
    And I see the following text as line items in My Bag page
      |Gift_Bag| To    | From | Message                |Number_of_items_in_gift_bag|
      |REINDEER| Jack  | John | Happy Birthday Jack... |3                          |
    And I see no "Add Gift Wrap" banner above the products list in My Bag page
    And the order total in the Order Summary section on My Bag page is "72.89"

  @registered @gw2
  Scenario: Create Gift wrap with Personalised items in My Bag without Customise message
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785126098 |  1  |                    |
      | 9351785851327 |  1  |XX                  |
      | 9351785851242 |  1  |YY                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "REINDEER" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                       |
      | 9351785851327 |  1  |Personalised Blaze Backpack  |
      | 9351785851242 |  1  |Personalised Blaze Backpack  |
    And I see the following products added in Your Gift Bag is looking good! section
      |      sku      | qty | title                       |
      | 9351785851327 |  1  |Personalised Blaze Backpack  |
      | 9351785851242 |  1  |Personalised Blaze Backpack  |
    When I hit I'm done Create my Gift! button
    Then I see the Gift Bag with following Products in Bag
      |       sku     | qty |title                         |
      | 9351533625590 |  1  |Lola Midi Dress               |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2 |
      | 9351785851327 |  1  |Personalised Blaze Backpack   |
      | 9351785851242 |  1  |Personalised Blaze Backpack   |
    And I see the following text as line items in My Bag page
      |Gift_Bag| To    | From | Message                |Number_of_items_in_gift_bag|
      |REINDEER|       |      |                        |2                          |
    And I see "Create more Gift Wraps" button in "Add Gift Wrap" banner in My Bag page

  @guest @gw2
  Scenario: Create Gift wrap with Personalise, Non-Personalised items and Customise message in My Bag
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785126098 |  1  |                    |
      | 9351785851327 |  1  |XX                  |
      | 9351785851242 |  1  |YY                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "MARIAH CAREY" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                         |
      | 9351785851327 |  1  |Personalised Blaze Backpack    |
      | 9351533625590 |  1  |Lola Midi Dress                |
      | 9351785851242 |  1  |Personalised Blaze Backpack    |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2  |
    And I see the following products added in Your Gift Bag is looking good! section
      |      sku      | qty | title                         |
      | 9351785851327 |  1  |Personalised Blaze Backpack    |
      | 9351533625590 |  1  |Lola Midi Dress                |
      | 9351785851242 |  1  |Personalised Blaze Backpack    |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2  |
    And I enter the following text in Make it a Gift page
      | To    | From | Message                           |
      | Jerry  | Rose |  Well done on your graduation... |
    When I hit I'm done Create my Gift! button
    Then I see the Gift Bag with following Products in Bag
      |      sku      | qty | title                         |
      | 9351785851327 |  1  |Personalised Blaze Backpack    |
      | 9351533625590 |  1  |Lola Midi Dress                |
      | 9351785851242 |  1  |Personalised Blaze Backpack    |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2  |
    And I see the following text as line items in My Bag page
      |Gift_Bag| To    | From | Message                |Number_of_items_in_gift_bag        |
      |MARIAH CAREY| Jerry  | Rose | Well done on your g... |4                          |
    And I see no "Add Gift Wrap" banner above the products list in My Bag page

  @registered @gw2
  Scenario: Create Gift wrap with Personalised and Non-Personalised items without customise message in My Bag
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785126098 |  1  |                    |
      | 9351785851327 |  1  |XX                  |
      | 9351785851242 |  1  |YY                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I select "I NEED IT" from Choose your Gift Bag section
    And I add the following products with quantity to it from Add your items section
      |      sku      | qty | title                         |
      | 9351785851327 |  1  |Personalised Blaze Backpack    |
      | 9351533625590 |  1  |Lola Midi Dress                |
      | 9351785851242 |  1  |Personalised Blaze Backpack    |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2  |
    And I see the following products added in Your Gift Bag is looking good! section
      |      sku      | qty | title                         |
      | 9351785851327 |  1  |Personalised Blaze Backpack    |
      | 9351533625590 |  1  |Lola Midi Dress                |
      | 9351785851242 |  1  |Personalised Blaze Backpack    |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2  |
    When I hit I'm done Create my Gift! button
    Then I see the Gift Bag with following Products in Bag
      |      sku      | qty | title                         |
      | 9351785851327 |  1  |Personalised Blaze Backpack    |
      | 9351533625590 |  1  |Lola Midi Dress                |
      | 9351785851242 |  1  |Personalised Blaze Backpack    |
      | 9351785126098 |  1  |Novelty Pillow Cases Set Of 2  |
    And I see the following text as line items in My Bag page
      |Gift_Bag| To    | From | Message                |Number_of_items_in_gift_bag|
      |I NEED IT|       |      |                        |4                          |
    And I see no "Add Gift Wrap" banner above the products list in My Bag page

  @outline @gw2
  Scenario Outline: Customer hits 'I'm done. Wrap It!' button without selecting the gift bag or items that go into
  the gift bag
    Given I log on to the site with the following:
      | site | country| user | type_of_user | landing_page | user_state |
      | COG  | AU     | Don  | guest        | sign-in       | not_logged_in  |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351785126098 |  1  |                    |
      | 9351785851327 |  1  |XX                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I started creating <GiftBags_status>
    When I hit I'm done Create my Gift! button
    Then I see the following error message <ErrorMessage>
    Examples:
      |GiftBags_status                                         |                               ErrorMessage                                                                         |
      |Did not select gift bag and items to add to the gift bag|Please choose your Gift Bag.Please add your items. |
      |No gift bag selected                                    |Please choose your Gift Bag.                       |
      |No items selected to add to the gift bag                |Please add your items.                             |

  @registered @gw2
  Scenario: Customer hits 'X' without creating the gift bag half way through the selection of bag and items.
  Pop-up 'Are you sure you want to leave....' is displayed
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785851242 |  1  |YY                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I hit 'X' button on the Gift Wrap page
    Then I see the message "Are you sure you want to leave?Your Gift Wrapping is not finished yet."

  @registered @gw2
  Scenario: Customer hits 'Continue Wrapping' in overlay 'Are you sure you want to leave.
  Our Gift Bag is not created yet.
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785126098 |  1  |                    |
      | 9351785851327 |  1  |YY                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I hit 'X' button on the Gift Wrap page
    Then I see the message "Are you sure you want to leave?Your Gift Wrapping is not finished yet."
    When I hit on "continue-wrap"
    Then I land on Make it a Gift page

  @registered @gw2
  Scenario: Customer hits 'Go Back to Bag Page' in overlay 'Are you sure you want to leave.
  Our Gift Bag is not created yet.
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following personalised products:
      |       sku     | qty |personalised_message|
      | 9351533625590 |  1  |                    |
      | 9351785851242 |  1  |XX                  |
    And I click on View Cart button
    And I select "Gift Wrap" page
    And I hit 'X' button on the Gift Wrap page
    Then I see the message "Are you sure you want to leave?Your Gift Wrapping is not finished yet."
    When I hit on "back-cart"
    Then I land on My Bag page
    And I see the following nonpersonalised products in MyBag page
      |      sku      | qty |
      | 9351533625590 |  1  |
    And I see the following personalised products in MyBag page
      |      sku      | qty |
      | 9351785851242 |  1  |