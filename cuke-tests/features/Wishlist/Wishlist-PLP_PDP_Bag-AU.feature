@wishlist_plp_pdp_bag @au
Feature: Adding/removing products to wishlist via PLP,PDP and My Bag
  As a Cotton On customer
  I want to move items to Wishlist from PLP, PDP or Bag pages
  so that I can save the items for later when I'm ready to shop

Assumption
  The following users exist in Commerce Cloud and used for registered user scenarios
   | Email                 | First Name | Last Name | Commerce Cloud Account |
   | don.bradman@email.com | Mark       | Taylor    | Yes                    |

  In AU, we have these products
  | colour     |  sku         | Size| type           | category                                                           | comments                                    |
  | 418553-06  | 9351785369785| NA  | single size    | women/womens-accessories/womens-bags-wallets                       | Queens Clutch Purse                         |
  | 138231-124 | 9351533822869| NA  | single size    | gifts/novelty-gifts                                                | Enamel Badge                      |
  | 5680139-01 | 9352855090035| NA  | single size    | gifts/gift-card/                                                   | physical giftcard                           |
  | 2002690-02 | 9351533603802| M   | Multiple sizes | women/dresses                                                      | Woven Allycia Cold Shoulder Frill Wrap Dress|
  | 136936-326 | 9351533840603| NA  | single size    | gifts/novelty-gifts                                                | Physical giftcard                           |
  | 418768-02  | 9351785508221| NA  | single size    | women/womens-accessories/womens-bags-wallets/womens-bags-backpacks | personalised product With attributes        |
  | 000121-02  | 9354233660489| NA  | single size    | gifts/gift-card/                                                   | EGIFT DESIGN 02                             |
  | 270882-03  | 9351785586526| XS  | Lena Midi Dress| Dresses & Playsuits                                                | Lena Midi Dress                             |
  | 140070-11  | 9351785605203| NA  | single size    | gifts/novelty-gifts                                                | personalised Without attributes             |
  | 141084-03  | 9351533563175| NA  | single size    |
  | 270882-03  | 9351785586526| XS  | multiple sizes |

#CO-3792: Wishlist - PLP Updates
@plp @guest @wip
# Redundant after PDP Update Release
Scenario: Add Products to Wishlist via PLP as guest user
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  When user navigates to "women/womens-accessories/womens-bags-wallets" page
  And I click on Wishlist icon of the product "418553-06" in PLP
  Then I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product  |
    | 418553-06|

@plp @registered @wip
# Redundant after PDP Update Release
Scenario: Add Products to Wishlist via PLP as registered user
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state | cart_page |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  When user navigates to "gifts/novelty-gifts" page
  And I click on Wishlist icon of the product "138231-124" in PLP
  Then I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product    |
    | 138231-124 |

@plp @guest @wip
# Redundant after PDP Update Release
Scenario: Remove Product from Wishlist by unchecking Wishlist Icon of a Product on PLP as guest user
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Don  | guest        | sign-in      | not_logged_in |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  When user navigates to "women/dresses" page
  And I click on Wishlist icon of the product "2002690-02" in PLP
  And I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product    |
    | 2002690-02 |
  And user navigates to "women/dresses" page
  Then I remove the product "2002690-02" from Wishlist in PLP
  And I navigate to Wishlist page
  And there are no products on the Wishlist page

@plp @registered @wip
# Redundant after PDP Update Release
Scenario: Remove Product from Wishlist via unchecking Wishlist Icon on PLP as Registered user
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state | cart_page |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  When user navigates to "women/dresses" page
  And I click on Wishlist icon of the product "2002690-02" in PLP
  And I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product    |
    | 2002690-02 |
  And user navigates to "women/dresses" page
  Then I remove the product "2002690-02" from Wishlist in PLP
  And I navigate to Wishlist page
  And the message "You have no saved items." is displayed on Wishlist page
  And I click on "Start Shopping" link on Wishlist page
  And user lands on "women/dresses" page

@plp @guest @personalisation 
Scenario: Wishlist icon is not visible for Personalised products (with attributes)in PLP
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
  When user navigates to "women/womens-accessories/womens-bags-wallets/womens-bags-backpacks" page
  Then the Wishlist icon is not visible for the products in PLP
    | product   |
    | 418768-02 |

@plp @registered @egiftcard 
Scenario: Wishlist icon is not visible for E-giftcards in PLP
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  |
  When user navigates to "gifts/gift-card/" page
  Then the Wishlist icon is not visible for the products in PLP
    | product   |
    | 000121-02 |

@plp @registered @wip
# Redundant after PDP Update Release
Scenario: Adding Physical-giftcards to Wishlist page from PLP
  Given I log on to the site with the following:
    | site | country | user   | type_of_user | landing_page | user_state |
    | COG  | AU      | Sophia | registered   | sign-in      | logged_in  |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  When user navigates to "gifts/gift-card/" page
  And I click on Wishlist icon of the product "5680139-01" in PLP
  Then I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product   |
    | 5680139-01 |

# CO-3822: Wishlist - PDP Updates
@pdp @guest @smoke_test
Scenario: Remove product from Wishlist via PDP as Guest
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  And I add the products to Wishlist from PDP page
    | sku           |
    | 9351785586526 |
  And I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product   |
    | 270882-03 |
  When I remove the products on Wishlist from PDP page
    | sku           |
    | 9351785586526 |
  Then I navigate to Wishlist page
  And there are no products on the Wishlist page

@pdp @registered 
Scenario: Remove Product from Wishlist via PDP as Registered user
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  And I add the products to Wishlist from PDP page
    | sku           |
    | 9351785586526 |
  And I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product   |
    | 270882-03 |
  When I remove the products on Wishlist from PDP page
    | sku           |
    | 9351785586526 |
  Then I navigate to Wishlist page
  And there are no products on the Wishlist page

@pdp @registered @personalisation 
Scenario: Wishlist icon is not visible for Personalised products in PDP
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  |
  When the user navigates to PDP of the product "418768-02"
  Then the Wishlist icon is not visible on PDP of the product "418768-02"

@pdp @guest @egiftcard 
Scenario: Wishlist icon is not visible for E-giftcards in PDP
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
  When the user navigates to PDP of the product "000121-02"
  Then the Wishlist icon is not visible on PDP of the product "000121-02"


@pdp @registered 
Scenario: Adding Physical-giftcards to Wishlist page from PDP
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  And I add the products to Wishlist from PDP page
    | sku           |
    | 9352855090035 |
  When I navigates to Wishlist page
  Then the products displayed on Wishlist page are
    | product    |
    | 5680139-01 |

# CO-3823: Wishlist - Bag Updates
@mybag @guest
Scenario: As a guest user with empty wishlist move all items from My Bag to wishlist
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  And I add the following products to cart
    | sku           | qty |
    | 9351533603802 | 1   |
    | 9351533840603 | 1   |
    | 9351785605203 | 1   |
  And I navigate to bag page by clicking the minicart icon
  And I add the product to Wishlist from bag page
    | products    |
    | 2002690-02 |
  And the message "Woven Allycia Cold Shoulder Frill Wrap Dress moved to your wishlist." is displayed on My Bag page
  And I add the product to Wishlist from bag page
    | products    |
    | 136936-326 |
  And the message "Quirky Magnets moved to your wishlist." is displayed on My Bag page
  And I add the product to Wishlist from bag page
    | products  |
    | 140070-11 |
  And the message "Boxed Keyring moved to your wishlist." is displayed on My Bag page
  And the bag page is empty
  And the message as "Your bag is empty" is displayed
  Then I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product    |
    | 2002690-02 |
    | 136936-326 |
    | 140070-11  |

@mybag @registered
Scenario: As a registered user with empty wishlist move single item to wishlist from My bag
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state | cart_page |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  And I add the products to Wishlist from PDP page
    | sku           |
    | 9351533563175 |
    | 9351785586526 |
  And I add the following products to cart
    | sku           | qty |
    | 9351533603802 | 1   |
  And I navigate to bag page by clicking the minicart icon
  When I add the product to Wishlist from bag page
    | products   |
    | 2002690-02 |
  And the message "Woven Allycia Cold Shoulder Frill Wrap Dress moved to your wishlist." is displayed on My Bag page
  And the bag page is empty
  And the message as "Your bag is empty" is displayed
  Then I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product    |
    | 141084-03  |
    | 270882-03  |
    | 2002690-02 |

@mybag @registered
Scenario: As a registered user with empty wishlist move all items to Wishlist from My Bag
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state | cart_page |
      | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the following products to cart
      | sku           | qty |
      | 9351533603802 | 1   |
      | 9351533840603 | 1   |
      | 9351785605203 | 1   |
    And I navigate to bag page by clicking the minicart icon
    And I add the product to Wishlist from bag page
      | products    |
      | 2002690-02 |
    And the message "Woven Allycia Cold Shoulder Frill Wrap Dress moved to your wishlist." is displayed on My Bag page
    And I add the product to Wishlist from bag page
      | products    |
      | 136936-326 |
    And the message "Quirky Magnets moved to your wishlist." is displayed on My Bag page
    And I add the product to Wishlist from bag page
      | products  |
      | 140070-11 |
    And the message "Boxed Keyring moved to your wishlist." is displayed on My Bag page
    And the bag page is empty
    And the message as "Your bag is empty" is displayed
    Then I navigate to Wishlist page
    And the products displayed on Wishlist page are
      | product    |
      | 2002690-02 |
      | 136936-326 |
      | 140070-11  |


@mybag @registered
Scenario: As a registered user with saved wishlist move multiple items to Wishlist page from My Bag
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state | cart_page |
    | COG  | AU      | Mark | registered   | sign-in      | logged_in  | empty     |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  And I add the products to Wishlist from PDP page
    | sku           |
    | 9351533563175 |
    | 9351785586526 |
  And I add the following products to cart
    | sku           | qty |
    | 9351533603802 | 1   |
    | 9351533840603 | 1   |
    | 9351785605203 | 1   |
  And I navigate to bag page by clicking the minicart icon
  When I add the product to Wishlist from bag page
      | products  |
      | 2002690-02 |
  And the message "Woven Allycia Cold Shoulder Frill Wrap Dress moved to your wishlist." is displayed on My Bag page
  And I see the following nonpersonalised products in MyBag page
    | sku           | qty |
    | 9351533840603 | 1   |
    | 9351785605203 | 1   |
  Then I navigate to Wishlist page
  And the products displayed on Wishlist page are
    | product    |
    | 141084-03  |
    | 270882-03  |
    | 2002690-02 |

@mybag @guest @personalisation
Scenario: No 'Move to Wishlist' button for Personalised Product with attributes in My Bag
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
  And the Wishlist page is empty
  And I add the following products to cart
    | sku           | qty |
    | 9351533603802 | 1   |
  And I add the following personalised products:
    | sku           | qty | personalised_message |
    | 9351785508221 | 1   | XX                   |
  And I navigate to bag page by clicking the minicart icon
  Then the Move to wishlist button is not visible for the products on My Bag page
    | product    |
    | 418768-02  |


@mybag @guest @egiftcard
Scenario: No 'Move to Wishlist' icon for E-giftcard in My Bag
  Given I log on to the site with the following:
    | site | country | user | type_of_user | landing_page | user_state    |
    | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
  And I navigate to Wishlist page
  And the Wishlist page is empty
  When the user navigates to PDP of the product "9354233660489"
  And I select the following on eGiftCard page:
    |design          |amount|recipient_name|recipient_email|recipient_email_conf|senders_name|senders_msg|
    |EGIFT DESIGN 02 |20    |adam           |abc@abc.com    |abc@abc.com        |gilli       |msg2       |
  And the user clicks on Add to Bag for eGiftCard
  And I navigate to bag page by clicking the minicart icon
  Then the Move to wishlist button is not visible for the eGiftCards on My Bag page
    | design          | product   |
    | EGIFT DESIGN 02 | 000121-02 |