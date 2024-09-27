Feature: Store Stock Finder for AU

  As a customer, when I've searched for a product size using a postcode in the PDP page
  I want to be able to see the stock levels in the nearby stores
  So that I can know if I can go into a store and buy that product

  Assumption:

  In AU we have these products in AU

  | Master | Color                         |size | size_position|Brand          |
  | 2003013| black                         | XXS |  1           |Cotton On      |
  | 2003013| eucalyptus                    | XXS |  1           |Cotton On      |
  | 2003013| black                         | L   |  5           |Cotton On      |
  | 2003013| black                         | S   |  3           |Cotton On      |
  | 2003013| black                         | XS  |  2           |Cotton On      |
  | 664723 | black                         | S   |  2           |Cotton On Body |
  | 664723 | tropical bouquet willow green | XL  |  5           |Cotton On Body |
  | 134680 | organisational bad ass!       |     |  1           |TYPO           |
  | 134680 | black organisational bad ass! |     |  1           |TYPO           |



  And in RMS we have the In Store Stock in Stores for any size

  |         | size 1 | size 2 | size 3 | size 4 | size 5 |
  | store 1 |   6    |   1    | 10     | 100    | 15     |
  | store 2 |   NR   |   1    | 3      | 4      | NR     |
  | store 3 |   4    |   5    | 7      | 33     | 10     |
  | store 4 |   0    |   5    | NR     | 5      | 1      |
  | store 5 |   8    |   0    | 13     | 6      | NR     |
  | store 6 |   6    |   1    | 10     | 100    | 15     |
  | store 7 |   NR   |   1    | 3      | 4      | NR     |
  | store 8 |   4    |   5    | 7      | 33     | 10     |
  | store 9 |   0    |   5    | NR     | 5      | 1      |
  | store 10|   8    |   0    | 13     | 6      | NR     |


  NR  stands for "No Response" from SHIM
  And in BM we have the following threshold config setting

  |store_id|none_flag|low_flag|
  |site    |   2     |   6    |
  |6003    |   1     |   5    |
  |6902    |   0     |   1    |
  |6025    |   2     |   3    |
  |6034    |   9     |   20   |

  Background:
    Given I am on country "AU"
    And site is "COG"

  @store_stock
  Scenario: Online tab is selected by default
    When the user navigates to PDP of the product "2003013"
    And the user selects the color "nude pink"
    Then the Online Stock tab is selected by default

  @store_stock
  Scenario: Size selected Online is carried over to In-Store tab
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "nude pink"
    And the user selects the online size "M"
    When the user navigates to In-Store tab
    Then the In-Store size "M" is selected by default

  @store_stock
  Scenario: Size selected In-Store does not override Online size
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "nude pink"
    And the user selects the online size "M"
    And the user navigates to In-Store tab
    When the user selects the In-Store size "XXS"
    And the user navigates to Online tab
    Then the online size "M" is still selected

  @store_stock @smoke_test
  Scenario: Search by postcode using site specific threshold
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "black"
    And the user selects the online size "XXS"
    And the user navigates to In-Store tab
    When the user searches for stock in stores by postcode 3030
    Then the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status  |
      | 1        | In Stock      |
      | 2        | Out of Stock  |
      | 3        | Limited Stock |
      | 4        | Out of Stock  |
      | 5        | In Stock      |
      | 6        | In Stock      |
      | 7        | Out of Stock  |
      | 8        | Limited Stock |
      | 9        | Out of Stock  |
      | 10       | In Stock      |
    And the stores are of type "Cotton On"

  @store_stock
  Scenario: Search by suburb using site specific threshold
    And the user navigates to PDP of the product "664723"
    And the user selects the color "tropical bouquet willow green"
    And the user selects the online size "XL"
    And the user navigates to In-Store tab
    When the user searches for stock in stores by suburb "Werribee"
    Then the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status |
      | 1        | In Stock     |
      | 2        | Out of Stock |
      | 3        | In Stock     |
      | 4        | Out of Stock |
      | 5        | Out of Stock |
      | 6        | In Stock     |
      | 7        | Out of Stock |
      | 8        | In Stock     |
      | 9        | Out of Stock |
      | 10       | Out of Stock |
    And the stores are of type "Cotton On Body"

  @store_stock
  Scenario: Postcode is saved in cookie while switching colors within same master multi size product and stock is auto refreshed
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "eucalyptus"
    And the user selects the online size "XXS"
    And the user navigates to In-Store tab
    And the user searches for stock in stores by postcode 3030
    And the user selects the color "black"
    And the postcode 3030 is prefilled
    Then the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status  |
      | 1        | In Stock      |
      | 2        | Out of Stock  |
      | 3        | Limited Stock |
      | 4        | Out of Stock  |
      | 5        | In Stock      |
      | 6        | In Stock      |
      | 7        | Out of Stock  |
      | 8        | Limited Stock |
      | 9        | Out of Stock  |
      | 10       | In Stock      |
    And the stores are of type "Cotton On"

  @store_stock @debug
  # Blocked due to issue as CO-6251
  Scenario: Postcode is saved in cookie while switching colors within same master single size product and stock is auto refreshed
    And the user navigates to PDP of the product "134680"
    And the user selects the color "organisational bad ass!"
    And the user navigates to In-Store tab
    And the user searches for stock in stores by postcode 3030
    And the user selects the color "black organisational bad ass!"
    And the postcode 3030 is prefilled
    Then the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status  |
      | 1        | In Stock      |
      | 2        | Out of Stock  |
      | 3        | Limited Stock |
      | 4        | Out of Stock  |
      | 5        | In Stock      |
      | 6        | In Stock      |
      | 7        | Out of Stock  |
      | 8        | Limited Stock |
      | 9        | Out of Stock  |
      | 10       | In Stock      |
    And the stores are of type "TYPO"

  @store_stock @debug
  # Blocked due to issue as CO-6251
  Scenario: Suburb is saved in cookie while switching from multisize product to single size product
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "black"
    And the user navigates to In-Store tab
    And the user selects the In-Store size "L"
    And the user searches for stock in stores by suburb "Hungry Jacks Near Hoppers Crossing"
    And the user navigates to PDP of the product "134680"
    And the user selects the color "organisational bad ass!"
    And the user navigates to In-Store tab
    And the suburb "Hungry Jacks Near Hoppers Crossing" is prefilled
    Then the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status  |
      | 1        | In Stock      |
      | 2        | Out of Stock  |
      | 3        | Limited Stock |
      | 4        | Out of Stock  |
      | 5        | In Stock      |
      | 6        | In Stock      |
      | 7        | Out of Stock  |
      | 8        | Limited Stock |
      | 9        | Out of Stock  |
      | 10       | In Stock      |
    And the stores are of type "TYPO"

  @store_stock
  Scenario: Postcode is saved in cookie while switching from one multi size product to another multi size product
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "black"
    And the user selects the online size "S"
    And the user navigates to In-Store tab
    And the user searches for stock in stores by postcode 3027
    And the user navigates to PDP of the product "664723"
    And the user selects the color "black"
    And the user selects the online size "S"
    When the user navigates to In-Store tab
    Then the postcode 3027 is prefilled
    And the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status  |
      | 1        | Out of Stock  |
      | 2        | Out of Stock  |
      | 3        | Limited Stock |
      | 4        | Limited Stock |
      | 5        | Out of Stock  |
      | 6        | Out of Stock  |
      | 7        | Out of Stock  |
      | 8        | Limited Stock |
      | 9        | Limited Stock |
      | 10       | Out of Stock  |
    And the stores are of type "Cotton On Body"

  @store_stock
  Scenario: Search by suburb and store specific threshold config takes priority over site specific threshold config
    And the user navigates to PDP of the product "2003013"
    And the user selects the color "black"
    And the user selects the online size "XS"
    And the user navigates to In-Store tab
    When the user searches for stock in stores by suburb "Osborne Park"
    Then the number of stores displayed is 10
    And the stores are listed with In Store Stock Status
      | store_no | stock_status  |
      | 1        | Limited Stock |
      | 2        | In Stock      |
      | 3        | In Stock      |
      | 4        | Out of Stock  |
      | 5        | Out of Stock  |
      | 6        | Out of Stock  |
      | 7        | Out of Stock  |
      | 8        | Limited Stock |
      | 9        | Limited Stock |
      | 10       | Out of Stock  |
    And the stores are of type "Cotton On"