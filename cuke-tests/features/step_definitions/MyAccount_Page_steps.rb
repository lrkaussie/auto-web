And(/^the user navigates to Create an account page$/) do
  on(MyAccountPage).navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "account/register/" + "/")
end

And(/^the user is taken to Create your account page$/) do
  expect(on(Utility_Functions).return_browser_url).to include "account/register/"
end

And(/^all fields on Create your account page are empty$/) do
  expect(on(MyAccountPage).profile_customer_firstname).to eq ""
  expect(on(MyAccountPage).profile_customer_lastname).to eq ""
  expect(on(MyAccountPage).profile_customer_email).to eq ""
  expect(on(MyAccountPage).profile_login_password).to eq ""
  expect(on(MyAccountPage).profile_login_passwordconfirm).to eq ""
end

And(/^the user navigates to Sign Me In page$/) do
  on(MyAccountPage).navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "sign-in" + "/")
end

And(/^the email field on Sign Me In page is empty$/) do
  expect(on(MyAccountPage).login_username).to eq ""
end

And(/^the Sign Me In button on Sign me In page is visible$/) do
  expect(on(MyAccountPage).is_sign_me_in_button_present).to be_truthy
end

And(/^the Password field on Sign Me In page is hidden$/) do
  expect(on(MyAccountPage).is_login_password_present).to be_falsey
end

And(/^the Remember Me checkbox on Sign Me In page is hidden$/) do
  expect(on(MyAccountPage).is_login_rememberme__present).to be_falsey
end

And(/^the Forgot Password Link on Sign Me In page is hidden$/) do
  expect(on(MyAccountPage).is_forgot_password_present).to be_falsey
end

When(/^the user signs in with email "([0-9a-zA-Z@+.]+)"$/) do |arg|
  on MyAccountPage do |page |
    #page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "sign-in" + "/")
    page.sign_in arg
  end
end

Then(/^the user see the pop up message "(.*)"$/) do |arg|
  expect(on(MyAccountPage).loyalty_account_pop_up_message).to include arg
end

And(/^the pop up has Create Your Account and No Thanks buttons$/) do
  expect(on(MyAccountPage).verify_perks_account_popup_buttons).to be_truthy
end


When(/^the user clicks on Create Your Account button on the popup$/) do
  on(MyAccountPage).create_online_account
end

Then(/^the user see the pop up message on Sign In Page "([^"]*)"$/) do |arg|
  expect(on(MyAccountPage).loyalty_account_pop_up_message).to include arg
end

When(/^the user clicks on No Thanks button on the popup$/) do
  on(MyAccountPage).no_thanks
end

Then(/^the user stays on Sign Me In page$/) do
  expect(on(Utility_Functions).return_browser_url).to include "sign-in"
end

And(/^the user (.*) lands on My Account page with the sections displayed$/) do |arg,table|
  expect(on(MyAccountPage).account_hi_message).to include "Hi #{arg}"
  expect(on(MyAccountPage).personal_details_text).to include table.hashes[0].values[0]
  expect(on(MyAccountPage).your_order_history_text).to include table.hashes[1].values[0]
  expect(on(MyAccountPage).your_addresses_text).to include table.hashes[2].values[0]
  expect(on(MyAccountPage).wishlist_text).to include table.hashes[3].values[0]
  expect(on(MyAccountPage).points_balance_text).to include table.hashes[4].values[0]
end

When(/^the user signs in with email "([0-9a-zA-Z@+.]+)" and password "(\S+)"$/) do |arg1, arg2|
  on(MyAccountPage).sign_in_with_password(arg1,arg2)
end

Then(/^the user see the error message "([^"]*)"$/) do |arg|
  expect(on(MyAccountPage).incorrect_password_message).to include arg
end

And(/^the user "(.*)" does not exist in Commerce Cloud$/) do |arg|
    on(BusinessManagerPage) do |page|
      page.delete_cc_user @site_information['bm_url'],arg,@site_information['bm_username'],@site_information['bm_password'],@country,@site
      page.bm_logout
    end
end

And(/^my first name is "([^"]*)"$/) do |arg|
  @first_name = arg
end

And(/^I navigate to the register page$/) do
  on(BusinessManagerPage) do |page|
    page.delete_cc_user @site_information['bm_url'],@registration_email,@site_information['bm_username'],@site_information['bm_password'],@country,@site
    page.bm_logout
  end
  on(MyAccountPage).navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "account" + "/" + "register" + "/")
end

And(/^I select the Join Cotton On & Perks checkbox$/) do
  on(MyAccountPage) do |page|
    page.join_loyalty
  end
end

When(/^I create the account$/) do
  on(MyAccountPage).create_cc_account
end

Then(/^I land on My Account page with the sections displayed$/) do |table|
  expect(on(MyAccountPage).account_hi_message).to include "Hi #{@first_name}"
  expect(on(MyAccountPage).personal_details_text).to include table.hashes[0].values[0]
  expect(on(MyAccountPage).your_order_history_text).to include table.hashes[1].values[0]
  expect(on(MyAccountPage).your_addresses_text).to include table.hashes[2].values[0]
  expect(on(MyAccountPage).wishlist_text).to include table.hashes[3].values[0]
  expect(on(MyAccountPage).points_balance_text).to include table.hashes[4].values[0]

end

And(/^my email is "(.*)"$/) do |arg|
  @registration_email = arg
end

And(/^I fill all the details for creating an account$/) do
  on(MyAccountPage) do |page|
    page.profile_customer_firstname="Nav"
    page.profile_customer_lastname="Han"
    page.profile_customer_email = @registration_email
    page.profile_login_password="radition123"
    page.profile_login_passwordconfirm="radition123"
  end
end

And(/^my user record is created in Commerce Cloud$/) do
  on(BusinessManagerPage) do |page|
    expect(page.verify_cc_user @site_information['bm_url'],@registration_email,@site_information['bm_username'],@site_information['bm_password'],@country,@site).to include @registration_email
    page.bm_logout
  end
end

And(/^I navigate to the loyalty subscription page$/) do
  on(MyAccountPage).navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "subscribe" + "/")

end

And(/^I fill all the details for joining perks$/) do
  on(MyAccountPage) do |page|
    page.profile_customer_firstname="Nav"
    page.profile_customer_lastname="Han"
    page.profile_customer_email=@registration_email
    page.enter_phone_number_field '450139228'
    page.profile_dob_day="10"
    page.profile_dob_month="10"
    page.profile_dob_year="1982"
    page.select_customer_gender
    #page.select_brands
    page.brand_typo
    page.brand_ruby
    end
end

And(/^I join for perks$/) do
  on(MyAccountPage).join_perks
end

Then(/^I see a pop up with message "([^"]*)"$/) do |arg|
  expect(on(MyAccountPage).verify_perks_pop_up_message).to include arg
end

And(/^the user lands on My Account page with details prefilled$/) do |table|
  expect(on(MyAccountPage).profile_customer_firstname).to eq table.hashes[0]['Firstname']
  expect(on(MyAccountPage).profile_customer_lastname).to eq table.hashes[0]['Lastname']
  expect(on(MyAccountPage).profile_customer_email).to eq table.hashes[0]['Email']
end

And(/^I click the "([^"]*)" link on My Account$/) do |arg|
  on(MyAccountPage) do |page|
    sleep 2
    # page.wait_for_ajax
    page.points_balance
  end
end

Then(/^the point balance on Perks Balance page is "([^"]*)"$/) do |arg|
  on(MyAccountPage) do |page|
    sleep 2
    page.wait_for_ajax
    expect(page.no_of_points).to eq arg
  end
end

And(/^the number of rewards is "(.*)"$/) do |arg|
  on(MyAccountPage) do |page|
    page.wait_for_ajax
    expect(page.no_of_rewards).to eq arg
  end
end

And(/^the points to reward mapping is "(.*)"$/) do |arg|
  on(MyAccountPage) do |page|
    page.wait_for_ajax
    expect(page.points_to_reward_mapping).to eq arg
  end

end

And(/^the following vouchers are displayed$/) do |table|
  index = 1
  table.hashes.each do |data|
    on(MyAccountPage) do |page|
      expect(page.voucher_header_points_balance_page index).to include data['voucher_value']
      expect(page.voucher_header_points_balance_page index).to include data['voucher_type']
      days = data['expiry_days'].gsub(/[\(\D+\)]/,'').to_i
      date = on(Utility_Functions).future_date(0,0,days)
      expect(page.voucher_expiry_date_points_balance_page index).to include date.to_s
      expect(page.voucher_expiry_days_points_balance_page index).to include data['expiry_days']
      expect(page.voucher_codes_points_balance_page index).to include data['voucher_id']
    end
    index = index+1
  end
end

Then(/^I see a message "([^"]*)" on the Perks Balance page$/) do |arg|
  expect(on(MyAccountPage).non_perk_member_message).to eq arg
end

And(/^the point to reward mapping is "(.*)"$/) do |arg|
  expect(on(MyAccountPage).non_perk_point_mapping).to eq arg
end

And(/^I click the "([^"]*)" button$/) do |arg|
  on(MyAccountPage) do |page|
    page.sign_up_for_perks
    sleep 5
  end

end

And(/^I land on Loyalty subscription page$/) do
  expect(on(Utility_Functions).return_browser_url).to include "subscribe"
end


And(/^I click the reward history on Perks Balance page$/) do
  on(MyAccountPage) do |page|
    page.click_reward_history
  end
end

Then(/^the Perks reward history shows the vouchers$/) do |table|
  index = 0
  table.hashes.each {|data|
    on(MyAccountPage) do |page|
      if page.reward_history_section_open_presence
        expect(page.check_reward_type_reward_history index).to eq data['reward_type']
        expect(page.check_voucher_locked_message_reward_history index).to include data['voucher_locked_message']
        expect(page.check_reward_value_reward_history index).to eq data['value']
        expect(page.is_reward_redeemed_reward_history? index).to be_truthy if data['redeemed'] == 'yes'
        expect(page.is_reward_redeemed_reward_history? index).to be_falsey if data['redeemed'] == 'no'
        if data['days_since_expired'] != ""
          date = on(Utility_Functions).past_date(0,0,data['days_since_expired'].to_i)
          expect(page.reward_redeemed_date_reward_history index).to eq date.to_s
        end
      end

    end
    index = index + 1
  }
end

And(/^the spend threshold message is "(.*)"$/) do |arg|
  expect(on(MyAccountPage).spend_threshold_message).to include arg
end

And(/^clicking on How do Rewards & Points work "([^"]*)" the section$/) do |arg|
  expect(on(MyAccountPage).rewards_info_section_status arg).to be_truthy
end

And(/^the section shows Rewards Info$/) do |table|
  # table is a table.hashes.keys # => [:rewards_info]
  table.hashes.each {|data|
  expect(on(MyAccountPage).rewards_info_section_content).to include data['rewards_info']
  }
end

And(/^the spend threshold message is empty$/) do
  expect(on(MyAccountPage).is_spend_threshold_message_empty?).to be_falsey
end


And(/^the reward history on Perks Balance page is hidden$/) do
  expect(on(MyAccountPage).is_reward_history_present?).to be_falsey
end

And(/^I click on Already a member link to expand the section$/) do
  on(MyAccountPage).already_a_perks_member
end

And(/^Already a member section shows$/) do |table|
  # table is a table.hashes.keys # => [:content]
  on(MyAccountPage) do |page|
    table.hashes.each {|data|
      expect(page.already_a_perks_member_content).to include data['content']
    }
  end
end

And(/^I click on Update Your Details here link$/) do
  on(MyAccountPage) do |page|
    page.update_account_details
    sleep 2
    page.wait_for_ajax
  end
end

And(/^I add the perks voucher to cart from Points Balance page$/) do |table|
  on(MyAccountPage) do |page|
    table.hashes.each { |data|
      page.apply_voucher_to_cart data['voucher_id']
    }
  end
end

Then(/^the vouchers are available to add on Points Balance page$/) do |table|
  on(MyAccountPage) do |page|
      table.hashes.each{|data|
        expect(page.verify_voucher_available data['voucher_id']).to be_truthy
      }
  end
end

And(/^the vouchers are shown an "Applied" on Points Balance page with the buttons disabled$/) do |table|
  on(MyAccountPage) do |page|
    table.hashes.each{|data|
      expect(page.verify_voucher_applied data['voucher_id']).to be_truthy
    }
  end
end

And(/^I validate the phone number field presence and default country code value as '(.*)'$/) do |arg|
  on(MyAccountPage) do |page|
    page.phone_number_field_presence
    expect(page.phone_number_country_code_presence).to eq arg
  end
end

Then(/^validate the error message as "([^"]*)" is displayed for the phone number field on entering phone number as "([^"]*)" for "([^"]*)"$/) do |arg1, arg2, arg3|
  on(MyAccountPage) do |page|
    if arg3 == "maximum length validation without country code"
      page.enter_phone_number_without_country_code arg2
      page.profile_dob_day="10"
      expect(page.ph_number_error_message_text).to eq arg1
    end
    if arg3 == "minimum length validation with country code"
      page.enter_phone_number_field arg2
      page.profile_dob_day="10"
      expect(page.ph_number_error_message_text).to eq arg1
    end
  end
end

Then(/^I validate that no error message is displayed on entering phone number as "([^"]*)"$/) do |arg|
  on(MyAccountPage) do |page|
    page.enter_phone_number_without_country_code arg
    page.profile_dob_day="10"
    expect(page.ph_number_error_message_presence).to be_falsey
  end
end

And(/^I select the Join Cotton On & Perks checkbox and enter the mobile phone number as "([^"]*)"$/) do |arg|
  on(MyAccountPage) do |page|
    page.join_loyalty
    page.enter_phone_number_field arg
  end
end

And(/^I navigate directly to the register page$/) do
  on(MyAccountPage).navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "account" + "/" + "register" + "/")
end


And(/^I fill all the details with under allowed age DOB while joining perks$/) do
  on(MyAccountPage) do |page|
    page.profile_customer_firstname="vincy"
    page.profile_customer_lastname="bedi"
    page.profile_customer_email=@registration_email
    page.enter_DOB_under_allowed_age
    page.select_customer_gender
    #page.select_brands
    page.brand_typo
    page.brand_ruby
  end
end

And(/^I enter DOB under allowed age on Registeration page$/) do
  on(MyAccountPage) do |page|
      page.enter_DOB_under_allowed_age
  end
end

Then(/^the customer sees the under age overlay popup message$/) do
  on(MyAccountPage) do |page|
    expect(page.underage_overlay_present).to be_truthy
    expect(page.underage_text =~ /US Privacy Laws prohibit/).to be_truthy
  end
end

Then(/^DOB heading is present$/) do
  on(MyAccountPage) do |page|
    expect(page.DOB_checkbox_present).to be_truthy
  end
end

And(/^save DOB checkbox is present with correct text$/) do
  on(MyAccountPage) do |page|
    expect(page.DOB_checkbox_text(0) ==  "Save date of birth").to be_truthy
    expect(page.DOB_checkbox_text(1) ==  "(so we can send you birthday pressies)").to be_truthy
  end
end

And(/^I select the save DOB checkbox$/) do
  on(MyAccountPage) do |page|
    page.select_DOB_checkbox
  end
end

And(/^DOB copy under the field is present with correct text on "([^"]*)" page$/) do |arg|
  on(MyAccountPage) do |page|
    case arg
    when "subscription"
      expect(page.DOB_copy_subscription ==  "Fill this out for your Birthday rewards.").to be_truthy
    when "registeration"
      expect(page.DOB_copy_subscription ==  "Fill this out for your Birthday rewards.").to be_truthy
    when "checkout"
      expect(page.DOB_copy_checkout ==  "Fill this out for your Birthday rewards.").to be_truthy
    end
  end
end

And(/^I enter the password on subscription page$/) do
  on(MyAccountPage) do |page|
    page.enter_password_subscribe_pg
  end
end

Then(/^no brand out of all "([^"]*)" brands is pre-selected in the preference section$/) do |arg|
  on(MyAccountPage) do |page|
      expect(page.brand_selected_pref_section == arg.to_i).to be_truthy
  end
end

Then(/^the highlighted brand in the preference section is "([^"]*)"$/) do |arg|
  on(MyAccountPage) do |page|
    case arg
    when "Typo" , "Kids", "Factorie"
      expect(page.brand_selected_pref_section == arg).to be_truthy
      expect((page.co_brand_selected_prefs_number).to_s == "1").to be_truthy
    when "Cotton On"
      expect(page.co_brand_selected_pref_section == arg).to be_truthy
      expect((page.co_brand_selected_prefs_number).to_s == "3").to be_truthy
    end
  end
end

And(/^user selects the join perks checkbox on register pg$/) do
  on(MyAccountPage) do |page|
    page.select_join_perks_register_pg
  end
end