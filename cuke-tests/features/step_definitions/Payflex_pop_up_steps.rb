And(/^on payflex page user places an order with a "([^"]*)" user$/) do |arg|
  on(PayflexPage) do |page|
    if arg == "random approved"
      page.payflex_go_for_it
      page.payflex_enter_OTP
      page.payflex_enter_card_details
      page.payflex_enter_return_code
      page.payflex_enter_password
    end
  end
end

And(/^user click cancel transaction on payflex page$/) do
  on(PayflexPage) do |page|
    page.payflex_return_to_CO_page
  end
end