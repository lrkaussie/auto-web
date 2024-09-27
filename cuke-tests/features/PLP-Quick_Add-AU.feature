@au @quickadd
Feature: PLP-Quick Add - COG-AU
  As a Cotton On Customer
  I want to add products to my basket directly from PLP page

  Designs:  https://app.zeplin.io/project/5c412384493bf5bf6801cdf4

  Assumption

  BM Configuration:- Merchant Tools > Site Preferences > Custom Site Preference Groups >
  Search Configuration > Enable Quick View set to Yes

  In AU, we have these products

  | master product/sku | price | comments                          |
  | 138231-139         |  na   |                                   |
  | 9351785132198      |  na   |                                   |
  | 418768-02          |  na   | personalised product              |
  | 000121-02          |  na   | egift card                        |
  | 323022-01          |  na   | Cotton On & Co physical gift card |
  | 363023-01          |  na   | Cotton On & Co physical gift card |
  | 5680138-01         |  na   | Factorie physical gift card       |
  | 5680139-01         |  na   | Factorie physical gift card       |
  | 141114-02          |  na   | gifts/novelty-gifts/novelty-games |
  | 136936-380         |  na   | gifts/novelty-gifts               |

  @guest @modalwindow @smoke_test
  Scenario: Add product from PLP using Quick Add functionality
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    And user navigates to "gifts/novelty-gifts" page
    When user adds product "138231-139" from plp quick add
    Then plp quick add modal window will show:
      |x_button |add_to_bag |view_more_details |
      |true     |true       |true              |

  @guest @personalisation
  Scenario: Check PLP Quick Add icon for personalised product
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    When user navigates to "women/womens-accessories/womens-bags-wallets/womens-bags-backpacks" page
    Then user checks the plp quick add for "418768-02":
      |status|
      |false |

  @guest @egiftcard
  Scenario: Check PLP Quick Add icon for egiftcard
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    When user navigates to "gifts/gift-card/" page
    Then user checks the plp quick add for "000121-02":
      |status|
      |false |

  @guest @physicalgiftcard
  Scenario Outline: Check PLP Quick Add icon for physical giftcard
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    When user navigates to "gifts/gift-card/" page
    Then user checks plp quick add for "<group_id>":
      |status|
      |true |
    Examples:
      |group_id   |giftcard                            |
      |323022-01  |Cotton On & Co physical gift card   |
      |363023-01  |Cotton On & Co physical gift card   |
      |5680138-01 |Factorie physical gift card         |
      |5680139-01 |Factorie physical gift card         |

  @guest @modalwindow
  Scenario: X button works for Quick Add functionality from the modal window
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    And user navigates to "gifts/novelty-gifts" page
    And user adds product "138231-139" from plp quick add
    When the user clicks on "X" on the plp quick add modal window
    Then the user stays on PLP of "gifts/novelty-gifts"

  @guest @modalwindow
  Scenario: Add to Bag button works for Quick Add functionality from the modal window
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       |Don     | guest        | sign-in      |not_logged_in|
    And user navigates to "gifts/novelty-gifts" page
    And user adds product "138231-139" from plp quick add
    And user selects the qty as "2" on plp quick add
    And the user clicks on "Add to Bag" on the plp quick add modal window
#    And the product is added from the quick add modal window
    When the user clicks on "X" on the plp quick add modal window
    And I click on View Cart button
    Then I validate mybag page:
      | order_total |
      | 19.98       |
    And I see the following nonpersonalised products in MyBag page
      |      sku      | qty |
      | 9351785132198 |  1  |

  @registered @modalwindow
  Scenario: View more details works for Quick Add functionality from the modal window
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state  |
      |COG   |AU       | Mark   | registered   | sign-in      | logged_in   |
    And user navigates to "gifts/novelty-gifts" page
    And user adds product "138231-139" from plp quick add
    When the user clicks on "View more details" on the plp quick add modal window
    Then the user lands on PDP of product "138231-139"

  @guest @modalwindow
  Scenario: See all colours link works for Quick Add functionality from the modal window
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Mark | guest        | sign-in      | not_logged_in |
    And user navigates to "gifts/novelty-gifts" page
    And user adds product "138231-139" from plp quick add
    When the user clicks on "See all colours" on the plp quick add modal window
    Then the user lands on PDP of product "138231-139"

  @guest @modalwindow
  Scenario: Verify shipping promo text displayed on quick view as guest user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When user navigates to "women/womens-accessories/womens-bags-wallets" page
    And user adds product "418553-06" from plp quick add
    Then shipping promo text as "Free on orders $30 +" is displayed on quick view

  @guest @modalwindow
  Scenario: Add Products to Wishlist via quick view as guest user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When user navigates to "women/womens-accessories/womens-bags-wallets" page
    And user adds product "418553-06" from plp quick add
    And I click on Wishlist icon of the product from quick view
    And the user clicks on "X" on the plp quick add modal window
    Then I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product  |
      | 418553-06|

  @zip
  Scenario: Verify the bnpl logos on quick view
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And user navigates to "gifts/novelty-gifts/novelty-games" page
    And user adds product "141114-02" from plp quick add
    Then plp quick add modal window will show:
      | logos   |
      | Present |

  @zip
  Scenario: Verify the bnpl tagline on quick view for a normal product without promotion with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And user navigates to "gifts/novelty-gifts/novelty-games" page
    And user adds product "141114-02" from plp quick add
    Then plp quick add modal window will show:
      |bnpl_text_with_price              |
      |Or buy now from AU$12.50 per week |

  @zip
  Scenario: Verify the bnpl tagline on quick view for a physical gift card product
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And user navigates to "gifts/gift-card" page
    And user adds product "323022-01" from plp quick add
    Then plp quick add modal window will show:
      | bnpl_text_with_price | logos       |
      | Not Present          | Not Present |

  @zip
  Scenario: Verify the default tag line is displayed on quick view for a normal product under the min product price with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And user navigates to "gifts/novelty-gifts" page
    And user adds product "136936-380" from plp quick add
    Then plp quick add modal window will show:
      |bnpl_text_with_price  |
      |Or buy now, pay later |

  @zip
  Scenario: Verify the bnpl tagline on quick view for a normal product having price equal to min price with fixed amt. config
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    And user navigates to "women/dresses/dresses-t-shirt-dress" page
    And user adds product "270882-05" from plp quick add
    Then plp quick add modal window will show:
      |bnpl_text_with_price  |
      |Or buy now, pay later |

  @zip
  Scenario: Verify the bnpl tagline on quick view for a normal product with product promotion with fixed amt. config
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    And user navigates to "women/dresses/" page
    And user clicks Load More button "1" times
    And user adds product "270829-06" from plp quick add
    Then plp quick add modal window will show:
      | bnpl_text_with_price                |
      | Or pay in 4 installments of US$3.12 |

  @plp_price
  Scenario: Verify price of the product with no promotion applied and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When user navigates to "charity-gifts/charity-bags/" page
    Then the "list/sale" price of the product as "924640-38" displayed on plp is "$2"

  @plp_price
  Scenario: Verify price of the product with  promotion applied (only sale price has 00 cents) and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When user navigates to "stationery-living/" page
    Then the "list" price of the product as "141201-53" displayed on plp is "$2.99"
    And the "sale" price of the product as "141201-53" displayed on plp is "$1.00"

  @plp_price
  Scenario: Verify price of the product with promotion applied (only list price has 00 cents) and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When user navigates to "gifts/" page
    And user clicks Load More button "6" times
#    And navigate to page "page-4" of the plp
    Then the "list" price of the product as "134334-12" displayed on plp is "$3.00"
    And the "sale" price of the product as "134334-12" displayed on plp is "$1.50"

  @plp_price
  Scenario: Verify price of the product with promotion applied (both list and sale price has 00 cents) and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When user navigates to "stationery-living/travel-bags-accessories/" page
    And user clicks Load More button "1" times
    Then the "list" price of the product as "135380-00" displayed on plp is "$10"
    And the "sale" price of the product as "135380-00" displayed on plp is "$9"





