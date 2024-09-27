@au @giftwrap
Feature: Giftwrap - COG-AU - remove
  As a customer shopping on cottonon.com
  I want to be able to remove gift bags I created and added to my basket so that the
  items in my basket are not gift wrapped

  Assumptions:
  Site Preference 'Gift Wrapping Enabled' is 'ON'
  Site Preference for Non-Personalised 'Quantity Enable' is 'ON'
  Site Preference for Personalised 'Quantity Enable' is 'OFF'
  Site Preference 'Gift Wrapping Service Price' as '$6.99'

  Products-
    |         Product name            |     sku       |   Stock  |
    | Dylan Long Leggings             | 2027105310931 |  Instock |
    | Hattie Ruffle Tshirt Dress      | 9351785410920 |  Instock |
    | Jodi Low Rise Sneaker 1         | 9351785006635 |  Instock |
    | A5 Spinout Notebook - 120 Pages | 9351533883921 |  Instock |
    | A5 Campus Notebook - 240 Pages  | 9351533433294 |  Instock |
    | Maddie Rouched Tie Front Top    | 9351785181271 |  Instock |


  Giftbags-
  | Gift Bag     | sku           |
  | REINDEER     | 9353699520481 |
  | GINGER BREAD | 9353699520498 |
  | MARIAH CAREY | 9353699520504 |
  | I NEED IT    | 9353699520511 |
  | THE NEW NICE | 9353699520528 |
  | MERRY VERY   | 9353699520535 |


  Design Reference:
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673e7659ff50f4bad377e
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fb7d563e1336df698a
  https://app.zeplin.io/project/5b3ad72221dc0fb447bed8ff/screen/5b7673fe06c74a22b16b1a8b


  Background:
    Given I log on to the site with the following:
      | site | country| user     | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU     | Giftwrap | registered  | sign-in       | logged_in  | empty     |
    And I add the following products to cart
      |      sku      | qty |
      | 2027105310931 |  1  |
      | 9351785410920 |  2  |
      | 9351785006635 |  1  |
      | 9351533883921 |  1  |
      | 9351533433294 |  2  |
      | 9351785181271 |  1  |
    And I add the following Giftbag and products:
      | GiftBag      |      sku      | qty |  title                           | To    | From    | Message                           |
      | REINDEER     | 2027105310931 |  1  |  Dylan Long Leggings             | Jerry  | Rose   |  Well done on your graduation...  |
      | MARIAH CAREY | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  | James  | Mariah | Happy Birthday                    |
      | REINDEER     | 9351785410920 |  2  |  Hattie Ruffle Tshirt Dress      | John   | Doe    | Happy 21st                        |
      | GINGER BREAD | 9351533883921 |  1  |  A5 Spinout Notebook - 120 Pages | Jack   | Russell| Happy 18th                        |
      | MARIAH CAREY | 9351785181271 |  1  |  Maddie Rouched Tie Front Top    | Jane   | Ford   | Happy 1st                         |

  @delete_giftwrap @mybag @registered @gw3
  Scenario: Delete one gift bag from the customer's basket
    When I remove the following Giftbag:
      | GiftBag      |      sku      | qty |  title                           |
      | REINDEER     | 2027105310931 |  1  |  Dylan Long Leggings             |
    Then I see the following Giftbags in MyBag:
      | GiftBag      |      sku      | qty |  title                           | To    | From    | Message                           |
      | MARIAH CAREY | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  | James  | Mariah | Happy Birthday                    |
      | REINDEER     | 9351785410920 |  2  |  Hattie Ruffle Tshirt Dress      | John   | Doe    | Happy 21st                        |
      | GINGER BREAD | 9351533883921 |  1  |  A5 Spinout Notebook - 120 Pages | Jack   | Russell| Happy 18th                        |
      | MARIAH CAREY | 9351785181271 |  1  |  Maddie Rouched Tie Front Top    | Jane   | Ford   | Happy 1st                         |


  @delete_giftwrap @mybag @registered @gw3
  Scenario: Delete all gift bags added to the basket
    When I remove the following Giftbag:
      | GiftBag      |      sku      | qty |  title                           |
      | REINDEER     | 2027105310931 |  1  |  Dylan Long Leggings             |
      | MARIAH CAREY | 9351533433294 |  2  |  A5 Campus Notebook - 240 Pages  |
      | REINDEER     | 9351785410920 |  2  |  Hattie Ruffle Tshirt Dress      |
      | GINGER BREAD | 9351533883921 |  1  |  A5 Spinout Notebook - 120 Pages |
      | MARIAH CAREY | 9351785181271 |  1  |  Maddie Rouched Tie Front Top    |
    Then I see no giftwraps on MyBag page
    And I see the following products on MyBag page:
      | product_name                    |
      | Dylan Long Leggings             |
      | Hattie Ruffle Tshirt Dress      |
      | Jodi Low Rise Sneaker 1         |
      | A5 Spinout Notebook - 120 Pages |
      | A5 Campus Notebook - 240 Pages  |
      | Maddie Rouched Tie Front Top    |
    And the order total in the Order Summary section on My Bag page is "120.79"