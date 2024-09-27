And(/^on zip page user places an order with an existing user$/) do
  on(ZipPopup_Page) do |page|
    sleep 5
    @payment_info = Payment.get_payment_info 'zip'
    if (page.zip_login_page_presence).to_s == "true"
      page.zip_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    end
    sleep 5
    # @zip_order_total = page.validate_zip_page
    if (page.zip_continue_order_presence).to_s == "true"
      page.zip_place_order_existing_user
    end
    if (page.zip_continue_order_presence).to_s == "false"
      page.zip_existing_account_user_flow
      if (page.zip_security_code_presence).to_s == "true"
        page.zip_enter_security_code
      end
    end
    expect(($zip_order_total) == (@order_total_checkout_page.to_s)).to be(true)
  end
end

And(/^on zip page user places a split order with an existing user$/) do
  on(ZipPopup_Page) do |page|
    sleep 5
    @payment_info = Payment.get_payment_info 'zip'
    if (page.zip_login_page_presence).to_s == "true"
      page.zip_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    end
    sleep 5
    # @zip_order_total = page.validate_zip_page
    if (page.zip_continue_order_presence).to_s == "true"
      page.zip_place_order_existing_user
    end
    if (page.zip_continue_order_presence).to_s == "false"
      page.zip_existing_account_user_flow
      if (page.zip_security_code_presence).to_s == "true"
        page.zip_enter_security_code
      end
    end
  end
end

And(/^on zip page user places an order with new "([^"]*)" user$/) do |arg|
  on(ZipPopup_Page) do |page|
    sleep 5
    case arg
    when "Random"
      if (page.zip_select_account_presence).to_s == "true"
         page.zip_new_user_create_account
         page.zip_create_account_details arg
         page.zip_new_user_card_details arg
      else
      if (page.zip_select_account_presence).to_s == "false"
        page.zip_existing_account_user_flow
        if (page.zip_security_code_presence).to_s == "true"
           page.zip_enter_security_code
        end
      end
      end
    when 'Referral','Declined'
      if (page.zip_login_page_presence).to_s == "false"
        page.zip_existing_partial_account
        # page.zip_fail_existing_account_user_flow
        page.zip_main_menu_icon
        page.zip_logout
        sleep 5
        page.zip_click_browser_back
        sleep 2
        page.zip_click_browser_back
        sleep 10
      end
      sleep 5
      if (page.zip_select_account_presence).to_s == "true"
        page.zip_new_user_create_account
        page.zip_create_account_failed_orders arg
        page.zip_new_user_card_details arg
      end
      sleep 5
      if (page.zip_login_page_presence).to_s == "true"
        page.zip_create_account_details arg
        page.zip_new_user_card_details arg
      end
    end
  end
end

And(/^on zip page user clicks browser back$/) do
  on(ZipPopup_Page) do |page|
    sleep 2
    page.zip_click_browser_back
  end
end

And(/^on zip page user clicks on the link as return to sandbox$/) do
  on(ZipPopup_Page) do |page|
    sleep 5
    @payment_info = Payment.get_payment_info 'zip'
    if (page.zip_login_page_presence).to_s == "true"
      page.zip_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    end
    sleep 2
    if (page.zip_continue_order_presence).to_s == "false"
      page.zip_existing_partial_account
    end
    page.zip_main_menu_icon
    page.zip_click_return_to_sandbox
  end
end

And(/^on quadpay page user places an order with a "([^"]*)" user$/) do |arg|
  on(ZipPopup_Page) do |page|
    if arg == "random approved"
      page.quadpay_login_verify_mobile
      page.quadpay_enter_personal_details arg
      page.quadpay_click_create_account
      page.quadpay_enter_card_details
      expect((page.quadpay_page_order_total) == $order_tot_checkout_page).to be(true)
      expect((page.quadpay_page_instl_amt) == $quadpay_instl_amt).to be(true)
      page.quadpay_complete_order
    end
    if arg == "declined"
      page.quadpay_login_verify_mobile
      page.quadpay_enter_personal_details arg
      page.quadpay_click_create_account
      page.quadpay_enter_card_details
      page.quadpay_complete_order
    end
  end
end

Then(/^on quadpay page declined message is displayed and user navigates back to CO page$/) do
  on(ZipPopup_Page) do |page|
    @arg = "Sorry"
    expect((page.get_quadpay_declined_msg).include?(@arg)).to be(true)
    page.click_back_to_cart_declined
    sleep 5
  end
end

And(/^on quadpay page user clicks the cross icon$/) do
  on(ZipPopup_Page) do |page|
    page.quadpay_click_cross_icon
    sleep 2
  end
end


Then(/^zip payment method is not available on the "([^"]*)" page$/) do |arg|
  on(ZipPopup_Page) do |page|
    expect((page.zip_payment_method_presence).to_s == "false").to be(true)
  end
end