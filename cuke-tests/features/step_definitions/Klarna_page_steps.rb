And(/^on "([^"]*)" klarna page "([^"]*)" user places an order of "([^"]*)"$/) do |site, user, arg|
  on(Klarna_Page) do |page|
    sleep 2
    case site
    when "US"
      expect((page.klarna_page_order_total site == arg).to_s).to be_truthy
      page.klarna_click_buy
      page.klarna_click_cont_payment
      page.klarna_enter_otp
      page.klarna_confirm_email_screen
      page.klarna_US_DOB_details
      page.klarna_US_card_details
      page.confirm_klarna_order
    when "AU"
      expect((page.klarna_page_order_total site).to_s == arg).to be_truthy
      page.klarna_click_buy
      page.klarna_click_cont_payment
      page.klarna_enter_otp
      page.klarna_confirm_email_screen
      page.klarna_AU_DOB_details
      page.klarna_authenticate_identity
      page.klarna_AU_card_details
      page.confirm_klarna_order
    when "GB"
      expect((page.klarna_page_order_total site).to_s == arg).to be_truthy
      sleep 5
      page.klarna_GB_card_details
      page.klarna_click_buy
      sleep 5
      page.klarna_confirm_phone_gb
      page.klarna_enter_otp
    end
  end
end


When(/^user clicks on back button on klarna hpp$/) do
  on(Klarna_Page) do |page|
    page.klarna_click_back
  end
end

And(/^on "([^"]*)" klarna page "([^"]*)" user places a declined order of "([^"]*)"$/) do |site, arg1, arg2|
  on(Klarna_Page) do |page|
    expect((page.klarna_page_order_total site == arg2).to_s).to be_truthy
    page.klarna_click_buy
    page.klarna_click_cont_payment
    page.klarna_enter_otp
    page.klarna_confirm_email_screen
    page.klarna_US_DOB_details
    page.klarna_US_card_details
    page.confirm_declined_klarna_order
  end
end