And(/^on the paypal page user enters the details to log in$/) do
  on(PaypalPage) do |page|
    @payment_info = Payment.get_payment_info 'paypal'
    if (page.present_paypal_email_field?) == true
      page.paypal_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
      # page.pay_with_heading_presence
    end
  end
end

And(/^paypal page shows order total of "([^"]*)"$/) do |arg|
  on(PaypalPage) do |page|
    page.pay_with_heading_presence
    expect((page.paypal_order_total).to_s == (arg)).to be(true)
    # this has been commented as the bank section has changed for A/B testing
    # expect((page.paypal_order_total_bank_section).to_s == (arg)).to be(true)
  end
end

And(/^on paypal store page user places an order$/) do
  on(PaypalPage) do |page|
    # page.paypal_spinner_visible?
    # page.paypal_payment_option_selected?
   if (page.accept_cookies_present) == "true"
      page.accept_cookies_paypal
   end
   page.click_continue_paypal_store
  end
end


