@au @recent_search
Feature: Search - Clear Recent - COG AU

  Assumption
  BM Configuration: Merchant Tools / Custom Preference  / Search _Config / Enable Recent Searches = Yes

  @registered
  Scenario:  No Previous or recent searches made
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Mark |registered |sign-in     |logged_in    |
    When I click on search text box
    Then the clear recent link is not displayed on the search bar
    And the cross icon is not displayed on the search bar

  @guest
  Scenario: Your Recent Searches displays Single search string
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And I search for "tops" in the search text box
    And the cross icon is displayed on the search bar
    And the search magnifying glass is displayed on the search bar
    And search suggestions box populates
    And I click on the search magnifying glass
    And search results page for "tops" is displayed
    When I click on search text box
    Then "tops" is displayed in recent search list
    And the clear recent link is displayed on the search bar


  @guest
  Scenario: Clearing 1 recent search
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And I search for "tops" in the search text box
    And I click on the search magnifying glass
    And search results page for "tops" is displayed
    And I click on search text box
    And "tops" is displayed in recent search list
    When I click on "Clear Recent" link in recent search list
    Then Your Recent Searches list and Clear Recent link is not displayed

  @guest
  Scenario: Storing 10 recent searches in the search list
    # checking only 4 at the moment due to the brittleness of the script in jenkins
    # If 10 needs to be tested please pull the latest code and run from your local machine
    When I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    Then I get the following search keyword-search list combination in the search text box
      |recent_search_input_string|                    recent_search_output_in_search_list                                                   |
      | towel	                 | towel                                                                                                    |
      | hat                      | hat, towel                                                                                               |
      | metal drink bottle       | metal drink bottle, hat, towel                                                                           |
      | 9351785092140            | 9351785092140, metal drink bottle, hat, towel                                                            |
#      | 136993                   | 136993, 9351785092140, metal drink bottle, hat, towel                                                    |
#      | Women	                 | Women, 136993, 9351785092140, metal drink bottle, hat, towel                                             |
#      | Kids Accessories         | Kids Accessories, Women, 136993, 9351785092140, metal drink bottle, hat, towel                           |
#      | socks	                 | socks, Kids Accessories, Women, 136993, 9351785092140, metal drink bottle, hat, towel                    |
#      | dresses                  | dresses, socks, Kids Accessories, Women, 136993, 9351785092140, metal drink bottle, hat, towel           |
#      | Homewares                | Homewares, dresses, socks, Kids Accessories, Women, 136993, 9351785092140, metal drink bottle, hat, towel|
#      | Shirt                    | Shirt, Homewares, dresses, socks, Kids Accessories, Women, 136993, 9351785092140, metal drink bottle, hat|

  @wip
  Scenario: Clicking on Cross icon clears the search string from search text field and
  displays previous search results
    Given I log on to the site with the following:
      |site|country|user|type_of_user|landing_page|user_state   |
      |COG |AU     |Don |guest       |sign-in     |not_logged_in|
    And I search for "tops" in the search text box
    And search results page for "tops" is displayed
    When I search for "dresses" in the search text box
    And I click on Cross icon
    Then search text "dresses" is cleared
    And I see <your recent searches> list and 'Clear Recent' link
      | your recent searches |
      | tops                 |

