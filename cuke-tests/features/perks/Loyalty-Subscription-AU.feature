Feature: Register online or subscribe to loyalty
  As a user
  I can register online or subscribe to Loyalty through various channels
  So I can shop and earn points

  Assumption:- User "Nav Han" is creating account on the site with email "cottononqa+nav@gmail.com"

  Background:
    Given I am on country "AU"
    And site is "COG"

  @online_account @smoke_test @loy1
  Scenario: Create an online account
    And my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    And I navigate to the register page
    And I fill all the details for creating an account
    When I create the account
    Then I land on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |
    And my user record is created in Commerce Cloud

  @loy1
  Scenario: Subscribe to Loyalty through Register Page by creating an online account
    And my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    And I navigate to the register page
    And I fill all the details for creating an account
    And I select the Join Cotton On & Perks checkbox and enter the mobile phone number as "450139228"
    When I create the account
    Then I land on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |
    And my user record is created in Commerce Cloud

  @loy1
  Scenario: Subscribe to Loyalty through Loyalty Subscription page
    And my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    And I navigate to the loyalty subscription page
    And I fill all the details for joining perks
    When I join for perks
    Then I see a pop up with message "Check your email, your welcome voucher  is on it’s way. Don’t forget to go into your nearest store and pick up your card"

  Scenario: Validating phone number field on the subscription page
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    When I navigate to the loyalty subscription page
    Then I validate the phone number field presence and default country code value as '+61'

  Scenario: Validating phone number s on the registeration page
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    When I navigate directly to the register page
    And I select the Join Cotton On & Perks checkbox
    Then I validate the phone number field presence and default country code value as '+61'

  Scenario: Validating the error message for the phone number field min length on the registeration page
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    When I navigate directly to the register page
    And I select the Join Cotton On & Perks checkbox
    Then validate the error message as "Please specify a valid mobile number." is displayed for the phone number field on entering phone number as "9976" for "minimum length validation with country code"

  Scenario: Validating that no error message for the phone number field on the registeration page is displayed without county code on violating the min. length
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    When I navigate directly to the register page
    And I select the Join Cotton On & Perks checkbox
    Then I validate that no error message is displayed on entering phone number as "99951"

  Scenario: Validating that error message is displayed for the phone number field on the registeration page without county code on violating the max. length of 13 digit
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    When I navigate directly to the register page
    And I select the Join Cotton On & Perks checkbox
    Then validate the error message as "Please specify a valid mobile number." is displayed for the phone number field on entering phone number as "999999545454545" for "maximum length validation without country code"

  Scenario: Validating the error message for the phone number field min length on the subscription page
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    And I navigate to the loyalty subscription page
    Then validate the error message as "Please specify a valid mobile number." is displayed for the phone number field on entering phone number as "97851" for "minimum length validation with country code"

  Scenario: Validating that no error message for the phone number field on the subscription page is displayed without county code on violating the min. length
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    And I navigate to the loyalty subscription page
    Then I validate that no error message is displayed on entering phone number as "99951"

  Scenario: Validating that error message is displayed for the phone number field on the subscription page without county code on violating the max. length
    Given my first name is "Nav"
    And my email is "cottononqa+nav@gmail.com"
    And I navigate to the loyalty subscription page
    Then validate the error message as "Please specify a valid mobile number." is displayed for the phone number field on entering phone number as "999999545454545" for "maximum length validation without country code"

  Scenario: Validating that no error message is displayed on MY site(Min 11 & Max 13) for the phone number field on the subscription page if 12 digits are entered after changing the country code of AU to MY
    Given I log on to the site with the following:
      | site | country | user   | type_of_user | landing_page | user_state      |
      |COG   | MY      | Adam   | guest        | sign-in      | not_logged_in   |
    And I navigate to the loyalty subscription page
    Then I validate that no error message is displayed on entering phone number as "9995123456"