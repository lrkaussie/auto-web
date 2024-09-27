And(/^on laybuy page user places an order with an existing user$/) do
  on(LaybuyPopup_Page) do |page|
    @payment_info = Payment.get_payment_info 'laybuy'
    page.laybuy_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    page.laybuy_logs_in
    # page.laybuy_continue_order
    # page.laybuy_continue_order
    expect(page.laybuy_page_instl_amt == $laybuy_instal_amt).to be(true)
    # expect(page.order_total_laybuy_page == (@order_total_checkout_page.to_s)).to be(true)
    page.laybuy_place_order_existing_user
  end
end

And(/^on laybuy page user clicks browser back$/) do
  on(LaybuyPopup_Page) do |page|
    page.click_laybuy_login
    page.click_laybuy_browser_back
  end
end

And(/^on laybuy page user clicks on the link as return to merchant before login$/) do
  on(LaybuyPopup_Page) do |page|
    page.click_laybuy_login
    page.laybuy_return_to_merchant_before_login
    sleep 2
  end
end

And(/^on laybuy page user clicks on the link as return to merchant after login$/) do
  on(LaybuyPopup_Page) do |page|
    @payment_info = Payment.get_payment_info 'laybuy'
    page.laybuy_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    page.laybuy_logs_in
    # page.laybuy_continue_order
    # page.laybuy_continue_order
    page.laybuy_return_to_merchant_after_login
    sleep 2
  end
end

And(/^on laybuy page user places an order with a declined order specific user$/) do
  on(LaybuyPopup_Page) do |page|
    page.laybuy_login "cottononqa+laybuydeclined@gmail.com", "Laybuycotton1!"
    # page.laybuy_continue_order
    # page.laybuy_continue_order
    page.laybuy_logs_in
    # expect(page.laybuy_page_instl_amt == $laybuy_instal_amt).to be(true)
    expect(page.order_total_laybuy_page == (@order_total_checkout_page.to_s)).to be(true)
    page.laybuy_place_order_existing_user
  end
end