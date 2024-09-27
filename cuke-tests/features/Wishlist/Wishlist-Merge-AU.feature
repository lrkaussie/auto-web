@wishlist_merge @au @guest
Feature: Wishlist Merge Features
  As a Cotton On customer
  I can move items to Wishlist from PLP, PDP or Bag pages as guest
  and later login as registered user
  so that the guest Wishlist is merged with registered user Wishlist

  Assumption:

  The following users exist in Commerce Cloud
  | Email                         | First Name | Last Name | Commerce Cloud Account |
  | cottononqa+lynn@gmail.com     | Lynn       | Ladlee    | Yes                    |
  | cottononqa+sophia@gmail.com   | Sophia     | Laura     | Yes                    |

  In AU, we have these products
  | sku           | vg_id     | type           |
  | 9351785586526 | 270882-03 | multiple sizes |
  | 9351785039305 | 138802-00 | single size    |
  | 9350486827327 | 140000-01 | single size    |
  | 9351785778204 | 362940-01 | multiple_sizes |


  Scenario: Guest wishlist merged with empty wishlist of registered user
    Given I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351785586540 |
      | 9350486827327 |
    When I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state |
      | COG  | AU      | Lynn | registered   | sign-in      | logged_in  |
    And I navigate to Wishlist page
    Then the products displayed on Wishlist page are
      | product   |
      | 270882-03 |
      | 140000-01 |

  Scenario: Guest wishlist merged with saved wishlist of registered user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351785586526 |
      | 9351785039305 |
    And I logout from the site
    And I log on to the site with the following:
      | site | country | user | type_of_user | landing_page | user_state    |
      | COG  | AU      | Lynn | guest        | sign-in      | not_logged_in |
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9350486827327 |
      | 9351785778204 |
    When I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  |
    And I navigate to Wishlist page
    Then the products displayed on Wishlist page are
      | product   |
      | 270882-03 |
      | 138802-00 |
      | 140000-01 |
      | 362940-01 |

  Scenario: Empty guest wishlist does overwite the wish list of a registered user
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  |
    And I navigate to Wishlist page
    And the Wishlist page is empty
    And I add the products to Wishlist from PDP page
      | sku           |
      | 9351785586526 |
      | 9351785039305 |
    And I logout from the site
    And I navigate to Wishlist page
    And the Wishlist page is empty
    When I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state |
      | COG  | AU      | Sophia | registered   | sign-in      | logged_in  |
    And I navigate to Wishlist page
    Then the products displayed on Wishlist page are
      | product   |
      | 270882-03 |
      | 138802-00 |

