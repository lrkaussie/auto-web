require_relative '../support/personas'
require 'page-object'
require 'page-object/page_factory'
require_relative '../support/pages/Frontend/Cotton_On/utility_functions'
require 'fig_newton'
require 'yaml'

And(/^verify the presence of SMS opt in checkbox is "([^"]*)"$/) do |arg|
  expect(on(CheckoutPage).sms_opt_in_checkbox_presence).to eq arg
end

And(/^I validate the default country code value as '(.*)'$/) do |arg|
  on(CheckoutPage) do |page|
    expect(page.mobile_number_country_code_presence).to eq arg
  end
end

Then(/^validate the error message as "([^"]*)" is displayed for the mobile number field on entering number as "([^"]*)" for "([^"]*)"$/) do |arg1, arg2, arg3|
  on(CheckoutPage) do |page|
    if arg3 == "minimum length validation with country code"
      page.enter_mobile_number_with_country_code arg2
      @browser.send_keys :tab
      expect(page.mobile_number_error_message_text).to eq arg1
    end
    if arg3 == "minimum length validation without country code"
      page.enter_mobile_number_without_country_code arg2
      @browser.send_keys :tab
      expect(page.mobile_number_error_message_text).to eq arg1
    end
  end
end

And(/^user checks the SMS opt in checkbox for "([^"]*)" user$/) do |arg|
  on(CheckoutPage) do |page|
    page.check_sms_opt_in_checkbox arg
  end
end


And(/^verify the presence of SMS opt in checkbox in the bluebox is "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    expect(page.sms_opt_in_checkbox_bluebox_presence) == arg
  end
end

And(/^verify the value of phone number field in the bluebox is "([^"]*)" on focus$/) do |arg|
  on(CheckoutPage) do |page|
    expect(page.mobile_number_bluebox_country_code_presence) == arg
  end
end

And(/^user enters the mobile number in the bluebox as "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
      page.enter_mobile_number_bluebox arg
      @browser.send_keys :tab
      @mobile_number = page.mobile_number_bluebox_text
  end
end


And(/^an error message as "([^"]*)" is displayed$/) do |arg|
  on(CheckoutPage) do |page|
    expect((page.bluebox_error_message_text) == arg).to be_truthy
  end
end

And(/^verify the masked number in the bluebox is "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    expect((page.perks_user_number_value) == arg).to be_truthy
  end
end

And(/^verify the presence of change link in the bluebox is "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    expect((page.change_link_bluebox_presence).to_s == arg).to be_truthy
  end
end

And(/^user clicks the change link in the bluebox$/) do
  on(CheckoutPage) do |page|
    page.click_change_link_bluebox
  end
end