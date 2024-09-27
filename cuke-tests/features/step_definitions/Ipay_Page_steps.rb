When(/^user clicks on "([^"]*)"$/) do |arg|
  on(IpayPage) do |page|
    case arg
      when 'Test Successful Response'
        page.click_success_response
      when 'Test Cancelled Response'
        page.click_cancel_response
    end
  end
end

Then(/^ipay Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    if page.order_conf_page_loaded?
      expect(page.order_confirmation_text).to include (page.assert_transaction_id)
      expect(page.billing_address_conf_page).to include (@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['phone']).to_s,(@person['house']['postcode']).to_s
    end
  end
end

Then(/^"([^"]*)" delivery address is shown on the ipay Thankyou page$/) do |arg|
  case arg
    when 'HD'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address). to include (@person['fullname']['fname']), (@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['house']['postcode']).to_s
      end
    when 'CNC'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address). to include (@person['fullname']['fname']), (@person['fullname']['lname']),(@person['store_address']),(@person['store_city']), (@person['store_postcode']).to_s
        expect(page.confirm_delivery_method). to include ('Click & Collect')
      end
  end
end
