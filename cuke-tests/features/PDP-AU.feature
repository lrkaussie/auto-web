@pdp @au
Feature: PDP - COG-AU

  As a user I want to check the behaviour of pdp page
  In AU, we have these products
  | sku/group id  | stocklevel | size  |price  |comments                 |
  | 270882-03     | NA         | NA    | 24.00 |                         |
  | 9351785092140 | NA         | solid | 49.99 |                         |
  | 9351533598962 | 1          |  XS   | 29.95 |  Hurry only 1 left      |
  | 9351785535067 | 4          |  L    | 29.95 |  Hurry only 4 left      |
  | 9351785535050 | 5          |  M    | 29.95 |  Hurry only 5 left      |
  | 9351785535043 | 6          |  S    | 29.95 |     Almost Gone         |
  | 9351533598979 | 9          |  S    | 29.95 |     Almost Gone         |
  | 9351785535074 | 10         |  XL   | 29.95 |     Almost Gone         |
  | 9350486006111 | 11         |  XL   | 39.95 | In-stock, ready to ship |
  | 9351533563151 | 1          | solid | 2.00  |  Hurry only 1 left      |
  | 9351785293813 | 4          | solid | 2.00  |  Hurry only 4 left      |
  | 2041513973991 | 5          | osfa  | 14.95 |  Hurry only 5 left      |
  | 9351785549439 | 6          | osfa  | 12.95 |     Almost Gone         |
  | 9351533563175 | 9          | solid | 2.00  |     Almost Gone         |
  | 9351785534565 | 10         | osfa  | 12.95 |     Almost Gone         |
  | 9351533041727 | 11         | osfa  | 12.95 | In-stock, ready to ship |
  | 9350486006111 | 11         |  XL   | 39.95 | In-stock, ready to ship |
  | 9351785509174 | 1          | osfa  | 37.95 |  Hurry only 1 left      |
  | 9352403118389 | 4          | osfa  | 44.95 |  Hurry only 4 left      |
  | 9352403118426 | 5          | osfa  | 39.95 |  Hurry only 5 left      |
  | 9352403112011 | 6          | osfa  | 19.95 |     Almost Gone         |
  | 9351533891032 | 9          | osfa  | 12.95 |     Almost Gone         |
  | 9352403443283 | 10         | M/L   | 49.95 |     Almost Gone         |
  | 9351785414355 | 11         |  S    | 39.95 | In-stock, ready to ship |
  | 9351533119198 | N/A        | osfa  |  3.00 |                         |
  | 9351785114569 | N/A        | osfa  |       |                         |
  | 9351533753675 | N/A        | osfa  |       |                         |
  | 9351533332535 | N/A        | osfa  |       |                         |
  | 9351533077993 | N/A        | osfa  |       |                         |

  Config with OS, OSFA, SOLID
  | 9351533828120 | OSFA    | No Size Displayed       | US site |
  | 9351785341101 | SOLID   | No Size Displayed       | US site |
  | 9350486978784 | OS      | ONE SIZE Displayed      | US site |
  | 9351533679051 | OS,OSFA | ONE SIZE+OSFA Displayed | US site |

  default shipping is $6
  HD is $6, cnc is $3
  content asset - deliveryPDPDescription

  @pdp_page @guest
  Scenario: Verify that CnC store is getting selected on PDP and getting set in the browser cookie
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9351785092140"
    And I select my preferred store as "GEELONG" and store code is "3069"
    Then selected store in the browser session is with the store name as "WAURN PONDS"

  @pdp_page @guest
  Scenario: Verify that store gets changed on changing the already selected store
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "9351785092140"
    And I select my preferred store as "GEELONG" and store code is "3002"
    Then selected store in the browser session is with the store name as "MARKET SQUARE (MEGA)"
    And I change my preferred store as "WERRIBEE" and store code is "3937"
    Then selected store in the browser session is with the store name as "HIGHPOINT (MEGA)"

  @pdp_page @guest
  Scenario: Verify shipping promo text displayed on PDP as guest user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351785092140"
    Then shipping promo text as "Free on orders $30 +" is displayed on "PDP"

  @perf @guest
  Scenario: Add to Wishlist
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state|
      |COG |AU     |Don|guest  |9351785092140.html     |not_logged_in|
    And I click on Wishlist on PDP page
    And I navigate to Wishlist page
    Then wishlist details are
      |wishlist_present_text|
      |Wishlist             |

#   And I land on SignIn page

  @size @guest
  Scenario: Add to Bag without selecting size error message checks
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    And the user navigates to PDP of the product "270882-03"
    And the user clicks on Add to Bag from the PDP
    Then I validate pdp page:
      |size_selection|
      | Please select a size |

  @stock_pdp @guest
  Scenario Outline: Stock threshold message for product with multiple sizes
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    When I navigate to PDP of the product <sku>
    Then on pdp page user sees the <message>
    Examples:
      |sku          |stock|message                          |
      |9351533598962|1    | Hurry only 1 left               |
      |9351785535067|4    | Hurry only 4 left               |
      |9351785535050|5    | Hurry only 5 left               |
      |9351785535043|6    |   Almost Gone                   |
      |9351533598979|9    |   Almost Gone                   |
      |9351785535074|10   |   Almost Gone                   |
      |9350486006111|11   | In Stock and ready for dispatch |

  @stock_pdp @guest
  Scenario Outline: Stock threshold message for product with one size
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    When I navigate to PDP of the product <sku>
    Then on pdp page user sees the <message>
    Examples:
      |sku          |stock|message                          |
      |9351533563151|1    | Hurry only 1 left               |
      |9351785293813|4    | Hurry only 4 left               |
      |2041513973991|5    | Hurry only 5 left               |
      |9351785549439|6    |   Almost Gone                   |
      |9351533563175|9    |   Almost Gone                   |
      |9351785534565|10   |   Almost Gone                   |
      |9351533041727|11   | In Stock and ready for dispatch |

  @stock_pdp @guest
  Scenario Outline: Stock threshold message for personalised product
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    When I navigate to PDP of the product <sku>
    Then on pdp page user sees the <message>
    Examples:
      |sku          |stock|message                          |
      |9351785509174|1    | Hurry only 1 left               |
      |9352403118389|4    | Hurry only 4 left               |
      |9352403118426|5    | Hurry only 5 left               |
      |9352403112011|6    |   Almost Gone                   |
      |9351533891032|9    |   Almost Gone                   |
      |9352403443283|10   |   Almost Gone                   |
      |9351785414355|11   | In Stock and ready for dispatch |

  @rerun @stock_pdp @guest
  Scenario Outline: Customer clicks on instore tab after checking the stock threshold message
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page       |user_state   |
      |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
    And I navigate to PDP of the product <sku>
    And on pdp page user sees the <message>
    When the user clicks "In-Store" tab on pdp page
    Then the user doesn't see the instock message on pdp page
  Examples:
  |sku          |stock|message                          |
  |9351785535067|4    | Hurry only 4 left               |
  |2041513973991|5    | Hurry only 5 left               |
  |9351785549439|6    |   Almost Gone                   |
  |9351785534565|10   |   Almost Gone                   |
  |9350486006111|11   | In Stock and ready for dispatch |

   @viewbag
   Scenario: To verify View-bag button on PDP success message
     Given I log on to the site with the following:
       |site|country|user  |type_of_user|landing_page       |user_state   |
       |COG |AU     |Don   |guest       |sign-in            |not_logged_in|
     And the user navigates to PDP of the product "9351533119198"
     And the user clicks on Add to Bag from the PDP
     Then "View Bag Now" button is displayed on the pdp sucess message overlay
     And I click on the View Bag button on PDP success message overlay
     Then mybag page cart details are:
       | cart_present_text |
       | My Bag |

  @continueshopping
  Scenario: Verify continue shopping button is displayed on pdp success message when adding Multibuy product
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351533332535" with parameters as "__abTest=ContinueShoppingButton&__abTestSegment=ShowContinueShoppingButton"
    And the user clicks on Add to Bag from the PDP
    Then "Continue shopping" button is displayed on the pdp success message overlay with "Multibuy Carousel"

  @continueshopping
  Scenario: Verify continue shopping button is displayed on pdp success message when adding cross sell product
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351533753675" with parameters as ""
    And the user clicks on Add to Bag from the PDP
    Then "Continue shopping" button is displayed on the pdp success message overlay with "Cross Sell Carousel"

  @continueshopping
  Scenario: Verify continue shopping button is displayed on pdp success message when adding product (Through manual Recommendation)
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351785114569" with parameters as "__abTest=ContinueShoppingButton&__abTestSegment=ShowContinueShoppingButton"
    And the user clicks on Add to Bag from the PDP
    Then "Continue shopping" button is displayed on the pdp success message overlay with "Manual Carousel"

  @continueshopping
  Scenario: Verify continue shopping button is displayed on pdp success message when adding product which has free gift
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And the user navigates to PDP of the product "9351533077993" with parameters as "__abTest=ContinueShoppingButton&__abTestSegment=ShowContinueShoppingButton"
    And the user clicks on Add to Bag from the PDP
    Then "Continue shopping" button is displayed on the pdp success message overlay with "Gift Carousel"

  @bnpl
  Scenario: Verify the zip logos on the PDP
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the bnpl logos should be displayed on the pdp

  @bnpl
  Scenario: Verify the afterpay modal window on the PDP
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the "afterpay" modal window is displayed on clicking the logo

  @bnpl
  Scenario: Verify the zip modal window on the PDP
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the "zip" modal window is displayed on clicking the logo

  @bnpl
  Scenario: Verify the humm modal window on the PDP
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the "humm" modal window is displayed on clicking the logo

  @bnpl
  Scenario: Verify the laybuy modal window on the PDP
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the "laybuy" modal window is displayed on clicking the logo

  @bnpl
  Scenario: Verify the latpay modal window on the PDP
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the "latpay" modal window is displayed on clicking the logo

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a normal product without promotion with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785092140"
    Then the bnpl tagline is displayed as "Or buy now from AU$12.50 per week" on the pdp

  @bnpl
  Scenario: Verify the default tag line is displayed on the PDP for a normal product under the min product price with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785730516"
    Then the bnpl tagline is displayed as "Or buy now, pay later" on the pdp

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a personalised product with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785508221"
    Then the bnpl tagline is displayed as "Or buy now from AU$9.49 per week" on the pdp

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a normal product with product promotion with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785509303"
    Then the bnpl tagline is displayed as "Or buy now from AU$3.24 per week" on the pdp

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a physical gift card product with no. of weeks config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9352403796464"
    Then the bnpl tagline is not displayed for physical gift card on the pdp

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a normal product without promotion with fixed amt. config
    Given I log on to the site with the following:
      |site|country|user  |type_of_user|landing_page|user_state   |
      |COG |US     |Thomas|guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785509303"
    Then the bnpl tagline is displayed as "Or pay in 4 installments of US$3.25" on the pdp

  @bnpl
  Scenario: Verify the default tag line is displayed on the PDP for a normal product under the min product price with fixed amt. config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |US     |Thomas |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351533003176"
    Then the bnpl tagline is displayed as "Or buy now, pay later" on the pdp

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a normal product having price equal to min price with fixed amt. config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |US     |Thomas |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785586670"
    Then the bnpl tagline is displayed as "Or buy now, pay later" on the pdp

  @bnpl
  Scenario: Verify the bnpl tagline on the PDP for a normal product with product promotion with fixed amt. config
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |US     |Thomas |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product "9351785334462"
    Then the bnpl tagline is displayed as "Or pay in 4 installments of US$3.12" on the pdp

  @fringe_sizing
  Scenario: Fringe sizing type one scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "241182" and VG as "241182-78"
    Then "5" sizes should be displayed on the PDP
    And "0" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type two scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "241182" and VG as "241182-82"
    Then "5" sizes should be displayed on the PDP
    And "1" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type three scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "241182" and VG as "241182-88"
    Then "5" sizes should be displayed on the PDP
    And "3" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type four scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "241182" and VG as "241182-100"
    Then "6" sizes should be displayed on the PDP
    And "1" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type five scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "241200" and VG as "241200-12"
    Then "5" sizes should be displayed on the PDP
    And "1" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type six scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "241200" and VG as "241200-46"
    Then "5" sizes should be displayed on the PDP
    And "2" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type seven scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "260388" and VG as "260388-30"
    Then "6" sizes should be displayed on the PDP
    And "0" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type eight scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "663141" and VG as "663141-13"
    Then "13" sizes should be displayed on the PDP
    And "3" unavailable sizes should be displayed on the PDP

  @fringe_sizing
  Scenario: Fringe sizing type nine scenario
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    When the user navigates to PDP of the product with master as "660541" and VG as "660541-14"
    Then "8" sizes should be displayed on the PDP
    And "4" unavailable sizes should be displayed on the PDP

  @pdp_size
  Scenario: Verify size for product with size as OSFA and config has OS,OSFA and SOLID mentioned.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351533828120"
    Then "No" size is displayed on the pdp

  @pdp_size
  Scenario: Verify size for product with size as SOLID and config has OS,OSFA and SOLID mentioned.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351785341101"
    Then "No" size is displayed on the pdp

  @pdp_size
  Scenario: Verify size for product with size as OS and config has OS,OSFA and SOLID mentioned.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9350486978784"
    Then "ONE SIZE" size is displayed on the pdp

  @pdp_size
  Scenario: Verify size for product with size as OS/OSFA and config has OS,OSFA and SOLID mentioned.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351533679051"
    Then "ONE SIZE/OSFA" size is displayed on the pdp

  @pdp_price
  Scenario: Verify price of the product with no promotion applied and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351533828120"
    Then the "list/sale" price of the product displayed on pdp should be "$2"

  @pdp_price
  Scenario: Verify price of the product with promotion applied (only sale price has 00 cents) and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351785724560"
    Then the "sale" price of the product displayed on pdp should be "$15.00"
    And the "list" price of the product displayed on pdp should be "$24.99"

  @pdp_price
  Scenario: Verify price of the product with promotion applied (only list price has 00 cents) and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351785509693"
    Then the "sale" price of the product displayed on pdp should be "$1.50"
    And the "list" price of the product displayed on pdp should be "$3.00"

  @pdp_price
  Scenario: Verify price of the product with promotion applied (both list and sale price has 00 cents) and config has enabled hide cents.
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state    |
      | COG  | US      | Thomas | guest        | sign-in      | not_logged_in |
    When the user navigates to PDP of the product "9351785720562"
    Then the "sale" price of the product displayed on pdp should be "$9"
    And the "list" price of the product displayed on pdp should be "$10"



