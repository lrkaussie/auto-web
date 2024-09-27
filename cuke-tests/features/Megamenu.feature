Feature: Megamenu
     As a tester I want to check whether the navigations work from the megamenu
   
@sanity
Scenario: As a user I am able to go to the Cotton On Homepage and browse around
  Given I am on the Cotton On Home Page
  And I click on the geolocation popup link to stay on the current site
  When I click on the Women category in the menu
  And I click on the Tops Women subcategory
  Then The Tops Women subcategory page is loaded


