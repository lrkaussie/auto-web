And(/^on "([^"]*)" page user places an order with a random user$/) do |arg|
  on(Latitude_Page) do |page|
    if arg == "latpay"
      page.latpay_create_account_details
      page.latpay_driver_licence_details
      page.latpay_add_card_details
      expect((page.latpay_page_instl_amt) == $latpay_instal_amt).to be(true)
      expect(page.latpay_page_order_total == (@order_total_checkout_page.to_s)).to be(true)
      page.latpay_pay_order
    end
    if arg == "genoapay"
      page.genoapay_create_account_details
      page.genoapay_driver_licence_details
      page.genoapay_add_card_details
      page.genoapay_3D_security
      expect(page.latpay_page_order_total == (@order_total_checkout_page.to_s)).to be(true)
      page.latpay_pay_order
    end
  end
end

And(/^on "([^"]*)" page user clicks browser back$/) do |arg|
  on(Latitude_Page) do |page|
    page.click_latpay_browser_back
  end
end

And(/^on "([^"]*)" page user places an order with an existing user$/) do |arg|
  on(Latitude_Page) do |page|
    if arg == "latpay"
      page.latpay_login_exisitng_user
    end
    if arg == "genoapay"
      page.genoapay_login_exisitng_user
    end
  end
end

And(/^on "([^"]*)" page user clicks on the cross link after login$/) do |arg|
  on(Latitude_Page) do |page|
    page.latpay_click_cross_link
    sleep 2
  end
end

And(/^on "([^"]*)" page user clicks on the return to merchant link while signing up$/) do |arg|
  on(Latitude_Page) do |page|
    page.latpay_create_acc_to_return_merchant_link
    page.latpay_return_to_merchant_link
    sleep 2
  end
end
