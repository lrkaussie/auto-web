@au @giftwrap
Feature: Giftwrap - COG-AU - update/delete

  As a customer shopping on cottonon.com
  I want to be able to update/ remove gift bags I created and added to my basket so that the
  items in my basket are not gift wrapped.


  Assumptions:
  Site Preference 'Gift Wrapping Enabled' is 'ON'
  Site Preference 'Gift Wrapping Service Price' as '$6.99'
  |         Product name            |     sku       |   Stock  |
  | Dylan Long Leggings             | 2027105310931 |  Instock |
  | Hattie Ruffle Tshirt Dress      | 9351785410920 |  Instock |
  | Jodi Low Rise Sneaker 1         | 9351785006635 |  Instock |
  | A5 Spinout Notebook - 120 Pages | 9351533883921 |  Instock |
  | PERSONALISED BLAZE BACKPACK     | 9351785851327 |  Instock |
  | Izzie Strappy Maxi Dress        | 9351785535067 |  Instock |
  | A5 Campus Notebook - 240 Pages  | 9351533433294 |  Instock |
  | Dylan Long Leggings             | 2027105310931 |  Instock |
  | Alpha Keyring                   | 9351533229682 |  Instock |
  | So-Cal Slouch Cap               | 9351785549460 |  Instock |
  | Maddie Rouched Tie(free gift)   | 9351785181271 |  Instock |

  Design Reference:
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673e7659ff50f4bad377e
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fb7d563e1336df698a
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fe06c74a22b16b1a8b

  Standard Cart with Gift Bags will have the following:

  SKU/QTY combination-

  |      sku      | qty |       Product name             |
  | 2027105310931 |  1  |   Dylan Long Leggings          |
  | 9351785410920 |  2  |   Hattie Ruffle Tshirt Dress   |
  | 9351785006635 |  1  |   Jodi Low Rise Sneaker 1      |
  | 9351533883921 |  1  | A5 Spinout Notebook - 120 Pages|
  | 9351533433294 |  2  | A5 Campus Notebook - 240 Pages |
  | 9351785181271 |  1  | Maddie Rouched Tie(free gift)  |

  Giftbags-

  |  Gift Bag      |     sku       | qty |         Product name             |
  |  REINDEER      | 2027105310931 |  1  |   Dylan Long Leggings            |
  |  REINDEER      | 9351785410920 |  2  |   Hattie Ruffle Tshirt Dress     |
  |  GINGER BREAD  | 9351533883921 |  1  |   A5 Spinout Notebook - 120 Pages|
  |  MARIAH CAREY  | 9351533433294 |  2  |   A5 Campus Notebook - 240 Pages |
  |  MARIAH CAREY  | 9351785181271 |  1  |   Maddie Rouched Tie(free gift)  |


  @registered @wip
  Scenario: Delete one gift bag from the customer's basket
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following products to cart
      |      sku      | qty |
      | 2027105310931 |  1  |
      | 9351533433294 |  2  |
    And I add the following Giftbag and products:
      | GiftBag      |      sku      | qty |  title                           | To    | From    | Message                           |
      | REINDEER     | 2027105310931 |  1  |  Dylan Long Leggings             | Jerry  | Rose   |  Well done on your graduation...  |
      | MARIAH CAREY | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  | James  | Mariah | Happy Birthday                    |
    When I remove the following Giftbag:
      | GiftBag      |      sku      | qty |  title                           |
      | REINDEER     | 2027105310931 |  1  |  Dylan Long Leggings             |
    Then I see the following Giftbags in MyBag:
      | GiftBag      |      sku      | qty |  title                           | To    | From    | Message                           |
      | MARIAH CAREY | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  | James  | Mariah | Happy Birthday                    |

  @edit_giftwrap @mybag @gw3
  Scenario: Remove items added to the gift wrap from the basket
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following products to cart
      |      sku      | qty |
      | 9351533433294 |  2  |
    And I add the following Giftbag and products:
      | GiftBag      |      sku      | qty |  title                           | To    | From    | Message                           |
      | MARIAH CAREY | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  | James  | Mariah | Happy Birthday                    |
    And I edit the following Giftbag:
      | GiftBag          |      sku      | qty |  title                           |
      | MARIAH CAREY     | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  |
    When I update the Giftwrap item quantity from "2" to "0"
    Then I see no items in Your Gift Bag is looking good section

  @updateQty @MyBag @wip
  Scenario: Update quantity of items in the basket
    Given I log on to the site with the following:
      | site | country | user     | type_of_user | landing_page | user_state |
      | COG  | AU      | Giftwrap | registered   | sign-in      | logged_in  |
    And I add the following products to cart
      | sku           | qty |
      | 2027105310931 | 1   |
      | 9351785410920 | 2   |
      | 9351785006635 | 1   |
    And I click on 'Wrap My Gifts $6.99' banner in My Bag page
    And I see 'Wrap My Gifts $6.99' page
    And I select Gift Bag from 'Choose your Gift Bag' section
    And I add the following product with quantity to it from 'Add your items' section
      | sku           | qty |
      | 9351785410920 | 2   |
    And I see the products selected starts adding to 'Your Gift Bag is looking good!' section
    And I enter the following text in 'Wrap My Gifts $6.99' page
      | To   | From | Message              |
      | Jack | John | Happy Birthday Jack! |
    When I hit 'I'm done. Wrap it!' button
    Then I land on My Bag page
    And I see the gift bags as line items in the basket along with the actual product line items
    And I see the gift bags as line items in the basket
      | Gift Bag | sku           | qty | Comments                   |
      | GiftBag1 | 9351785410920 | 2   | Hattie Ruffle Tshirt Dress |
    When I updates the quantity of Product from '2 <Quantity>' to '1 <NewQuantity>'
    And I see the message displayed as Reducing the qty has adjusted your Gift Bag(s) below the product line item
      | Gift Bag | sku           | New qty | Comments                   |
      | GiftBag1 | 9351785410920 | 1       | Hattie Ruffle Tshirt Dress |

  @guest @mybag @wip
  Scenario: Update quantity of items in the basket
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the following products to cart
      | sku           | qty |
      | 2027105310931 | 1   |
      | 9351785410920 | 2   |
      | 9351785006635 | 1   |
    And I click on 'Wrap My Gifts $6.99' banner in My Bag page
    And I see 'Wrap My Gifts $6.99' page
    And I select Gift Bag from 'Choose your Gift Bag' section
    And I add the following product with quantity to it from 'Add your items' section
      | sku           | qty |
      | 2027105310931 | 1   |
    And I see the products selected starts adding to 'Your Gift Bag is looking good!' section
    And I enter the following text in 'Wrap My Gifts $6.99' page
      | To   | From | Message              |
      | Jack | John | Happy Birthday Jack! |
    When I hit 'I'm done. Wrap it!' button
    Then I land on My Bag page
    And I  see the gift bags as line items in the basket along with the actual product line items
      | Gift Bag | sku           | qty | Comments            |
      | GiftBag1 | 2027105310931 | 1   | Dylan Long Leggings |
    When I updates the quantity of Product from 1 <Quantity> to 3 <NewQuantity>
    And I see no message displayed and No impact-Gift Bags stay as is
      | Gift Bag | sku           | New qty | Comments            |
      | GiftBag1 | 2027105310931 | 3       | Dylan Long Leggings |

  @personalised_product_qty_update_disabled @MyBag @wip
  Scenario: Cannot Update the quantity of items in the basket for Personalised product
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the following products to cart
      | sku           | qty |
      | 2027105310931 | 1   |
      | 9351785410920 | 2   |
      | 9351785851327 | 1   |
    And I click on 'Wrap My Gifts $6.99' banner in My Bag page
    And I see 'Wrap My Gifts $6.99' page
    And I select Gift Bag from 'Choose your Gift Bag' section
    And I add the following product with quantity to it from 'Add your items' section
      | sku           | qty |
      | 9351785851327 | 1   |
    And I see the products selected starts adding to 'Your Gift Bag is looking good!' section
    And I enter the following text in 'Wrap My Gifts $6.99' page
      | To   | From | Message              |
      | Jack | John | Happy Birthday Jack! |
    When I hit 'I'm done. Wrap it!' button
    Then I land on My Bag page
    And I  see the gift bags as line items in the basket along with the actual product line items
      | Gift Bag | sku           | qty | Comments                    |
      | GiftBag1 | 9351785851327 | 1   | PERSONALISED BLAZE BACKPACK |
    Then for Personalised product I should not be able to view the quantity dropDown
    Then No impact-Gift Bags stay as is
    Then I should not be able to view the quantity dropdown so there will not be any impact to the Giftbag

  @remove_last_gift @MyBag @wip
  Scenario: Remove the last item from the gift bag. Checkout with empty gift bag.
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I add the following products to cart
      | sku           | qty |
      | 2027105310931 | 1   |
    And I click on 'Wrap My Gifts $6.99' banner in My Bag page
    And I see 'Wrap My Gifts $6.99' page
    And I select Gift Bag from 'Choose your Gift Bag' section
    And I add the following product with quantity to it from 'Add your items' section
      | sku           | qty |
      | 2027105310931 | 1   |
    And I see the products selected starts adding to 'Your Gift Bag is looking good!' section
    And I enter the following text in 'Wrap My Gifts $6.99' page
      | To   | From | Message              |
      | Jack | John | Happy Birthday Jack! |
    When I hit 'I'm done. Wrap it!' button
    Then I land on My Bag page
    And I  see the gift bags as line items in the basket
      | Gift Bag | sku           | qty | Comments            |
      | GiftBag1 | 2027105310931 | 1   | Dylan Long Leggings |
    When I remove the last item from gift bag
    Then the gift bag will continue to remain as a line item in the MyBag page
    And the gift bag will be highlighted
    And there will be a message with a link 'Your gift bag is empty. Please add items to continue or remove gift-bag1
      | Gift Bag |
      | GiftBag1 |
    When I click on the remove link to remove the gift bag from the basket
    Then I can proceed to checkout page