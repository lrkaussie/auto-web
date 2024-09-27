Feature: Shop by brand
     As a tester I want to check all the shop by brand scenarios in this feature

@1414 @brands @header
Scenario Outline: Verify that the brand links from the header section take the user to the relevant brand page 
  Given I am on the Cotton On Home Page
  And I click on the geolocation popup link to stay on the current site
  When I click on the "<brand_name>" brand link on the header
  Then I am directed to the "<brand_page>"

Examples:

| brand_name | brand_page |
| cottonon | Cotton On |
| body | Body |
| kids | Kids |
| typo | Typo |
| rubi | Rubi |









