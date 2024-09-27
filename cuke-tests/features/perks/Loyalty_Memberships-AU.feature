@perks_account @au
Feature: Loyalty Memberships Feature
  As CottonOn customer,
  I want to activate my website account by clicking a link in the email I received,
  so that I can setup my password to log in to the website.

  Assumption:-

  The following users exist in CC with Perks account status in RMS

  | Email                         | First Name | Last Name | Commerce Cloud Account | Perks Account |
  | cottononqa+lila@gmail.com     | Lila       | Love      | No                     | Yes           |
  | cottononqa+monica@gmail.com   | Monica     | Belluci   | No                     | No            |
  | cottononqa+lynn@gmail.com     | Lynn       | Ladlee    | Yes                    | Yes           |
  | cottononqa+jessica@gmail.com  | Jessica    | Alba      | Yes                    | No            |
  | cottononqa+sophia@gmail.com   | Sophia     | Laura     | Yes                    | Yes           |
  | cottononqa+samantha@gmail.com | Samantha   | Foxx      | No                     | No            |

  Background:
    Given I am on country "AU"
    And site is "COG"

  @my_account @loy1
  Scenario: Hide Password, Remember me, Forgot password fields in the 'Already have an account?' section in My Account page
    When the user navigates to Sign Me In page
    And the email field on Sign Me In page is empty
    And the Sign Me In button on Sign me In page is visible
    And the Password field on Sign Me In page is hidden
    And the Remember Me checkbox on Sign Me In page is hidden
    And the Forgot Password Link on Sign Me In page is hidden

  @my_account @smoke_test @loy1
  Scenario: Sign into My Account with an email address without a website account and with PERKS membership
    And the user "cottononqa+lila@gmail.com" does not exist in Commerce Cloud
    When the user navigates to Sign Me In page
    And the user signs in with email "cottononqa+lila@gmail.com"
    Then the user see the pop up message "Hi Lila,We see you're a CottonOn & Co Perks member but do not have a website account with us. Would you like to create one now?"
    And the pop up has Create Your Account and No Thanks buttons

  @my_account @loy1
  Scenario: Button functions on overlay popup on Sign Me In Page for a user without Online account and with Perks account, Hit "No Thanks Button"
    And the user "cottononqa+lila@gmail.com" does not exist in Commerce Cloud
    And the user navigates to Sign Me In page
    When the user signs in with email "cottononqa+lila@gmail.com"
    And the user clicks on No Thanks button on the popup
    Then the user stays on Sign Me In page

  @my_account @gmail
  Scenario: Sign Me In Page - User clicks on Create your account button, activate account from email and create an online account
    And the user "cottononqa+lila@gmail.com" does not exist in Commerce Cloud
    And the user navigates to Sign Me In page
    And the user signs in with email "cottononqa+lila@gmail.com"
    And the user clicks on Create Your Account button on the popup
    And the user see the pop up message on Sign In Page "Hi Lila,We’ve sent you a email. Please click on the link in the email to finish setting up your account."
    When the user clicks on activate online account link
    Then the user see the overlay password dialogue pop up message "Hi Lila,You’re nearly there! Just add a password."
    And the user creates the online account by giving password
    And the user Lila lands on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |


  @my_account @smoke_test @loy1
  Scenario: Sign into My Account with an email address without a website account and without PERKS membership
    And the user navigates to Sign Me In page
    And the email field on Sign Me In page is empty
    And the Sign Me In button on Sign me In page is visible
    And the Password field on Sign Me In page is hidden
    And the Remember Me checkbox on Sign Me In page is hidden
    And the Forgot Password Link on Sign Me In page is hidden
    When the user signs in with email "cottononqa+monica@gmail.com"
    Then the user see the pop up message "Hi there,Looks like you're new! Would you like to create an account to sign in?"
    And the pop up has Create Your Account and No Thanks buttons

  @my_account @smoke_test @loy1
  Scenario: Button functions on overlay popup on Sign Me In page for a user without Online account and without Perks account, Hit "Create Your Account" button
    And the user navigates to Sign Me In page
    And the user signs in with email "cottononqa+monica@gmail.com"
    When the user clicks on Create Your Account button on the popup
    Then the user is taken to Create your account page
    And all fields on Create your account page are empty

  @my_account @loy1
  Scenario: Button functions on overlay popup on Sign Me In page for a user without Online account and without Perks account, Hit "No Thanks" button
    And the user navigates to Sign Me In page
    When the user signs in with email "cottononqa+monica@gmail.com"
    And the user clicks on No Thanks button on the popup
    Then the user stays on Sign Me In page

  @my_account @loy2
  Scenario: Sign in to Online account from Sign Me In Page with correct password for a user with online account and without Perks account
    And the user navigates to Sign Me In page
    When the user signs in with email "cottononqa+lynn@gmail.com" and password "radiation123"
    Then the user Lynn lands on My Account page with the sections displayed
      | sections         |
      | My Details       |
      | My Order History |
      | My Addresses     |
      | Wishlist         |
      | My Perks         |

  @my_account @loy2
  Scenario: Sign in to Online account from Sign Me In Page with incorrect password for a user with online account and without Perks account
    And the user navigates to Sign Me In page
    When the user signs in with email "cottononqa+lynn@gmail.com" and password "radiation"
    Then the user see the error message "Sorry, this does not match our records. Check your spelling and try again."

  @checkout @loy2
  Scenario: Checkout with an email address without a website account and with PERKS membership and verify the response behaviour.
    And the user "cottononqa+lila@gmail.com" does not exist in Commerce Cloud
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    When the user clicks on Sign In Here Link
    Then the user see the overlay pop up message "Hi Lila,We see you're a CottonOn & Co Perks member but do not have a website account with us. Would you like to create one now or continue as guest?"
    And the pop up has Create Your Account and No Thanks button

  @checkout @gmail
  Scenario: Checkout page, User clicks on Create your account button, activate account from email and create online account
    And the user "cottononqa+lila@gmail.com" does not exist in Commerce Cloud
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    And the user clicks on Sign In Here Link
    And the user clicks the Create Your Account button on pop up
    Then the user see the overlay pop up message "Hi Lila,We’ve sent you a email. Please click on the link in the email to finish setting up your account."
    And the user clicks on activate online account link
    And the user see the overlay password dialogue pop up message "Hi Lila,You’re nearly there! Just add a password."
    And the user creates the online account by giving password
    And the user lands on Checkout page
    And the first name is prefilled as "Lila"
    And last name is prefilled as "Love"
    And the checkout page has products
      | sku           | qty |
      | 9351785586540 | 1   |

  @checkout @loy2
  Scenario:  Button Function, Checkout with an email address without a website account and with PERKS membership Hit "Continue as Guest"
    And the user "cottononqa+lila@gmail.com" does not exist in Commerce Cloud
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+lila@gmail.com"
    When the user clicks on Sign In Here Link
    And the user clicks the Continue as guest button on pop up
    And the user lands on Checkout page
    Then the perks overlay popup closes

  @checkout @loy2
  Scenario: Checkout with an email address without a website account and without PERKS membership and verify the response behaviour.
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    When the user clicks on Sign In Here Link
    Then the user see the overlay pop up message "Hi there,Looks like you're new! Would you like to create an account now or continue as guest?"

  @checkout @loy2
  Scenario: Button Function, Checkout with an email address without a website account and without PERKS membership hit "Create Your Account"
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    When the user clicks on Sign In Here Link
    And the user clicks the Create Your Account button on pop up
    Then the user is taken to Create your account page
    And all fields on Create your account page are empty

  @checkout @loy2
  Scenario: Button Function, Checkout with an email address without a website account and without PERKS membership hit "Continue As Guest"
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+monica@gmail.com"
    When the user clicks on Sign In Here Link
    And the user clicks the Continue as guest button on pop up
    Then the user stays on Checkout page
    And the perks overlay popup closes

  @checkout @loy2
   Scenario: User with a website account and with PERKS membership signs in at Checkout Page with correct password
     And a bag with products:
       | sku           | qty |
       | 9351785586540 | 1   |
     And checkout button is pressed
     And the user enters email on checkout "cottononqa+lynn@gmail.com"
     When the user clicks on Sign In Here Link
     Then the password field is visible
     And the user logs in to online account with password "radiation123"
     And the user "Lynn" is logged in
     And the user stays on Checkout page

  @checkout @loy2
  Scenario: User with a website account and without PERKS membership signs in at Checkout Page with correct password
    And a bag with products:
      | sku           | qty |
      | 9351785586540 | 1   |
    And checkout button is pressed
    And the user enters email on checkout "cottononqa+jessica@gmail.com"
    When the user clicks on Sign In Here Link
    Then the password field is visible
    And the user logs in to online account with password "radiation123"
    And the user "Jessica" is logged in
    And the user stays on Checkout page
