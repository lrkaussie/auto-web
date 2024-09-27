Feature: Geo Pop up
     As a tester I want to check whether the geo popup appears on NZ site

@1353 @geopopup
Scenario: Verify that the pop up appears as the user is browsing from Australia
  Given I am on the Cotton On Home Page	 
  When I am in "AU"
  Then the geolocation popup is present
  And the Big flag is for "AU"
  And I check the warning message "You are on the New Zealand Site"
  And I see the "Go to Australia" site button
  And I can see the "Stay on the New Zealand Site" link
  And countries listed are: "AU" "NZ" "HK" "MY" "SG" "US"