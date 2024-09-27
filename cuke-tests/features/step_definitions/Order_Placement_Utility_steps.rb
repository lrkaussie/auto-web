Given(/^I navigate to the sign in page of the "([^"]*)" site for the country "([^"]*)"$/) do |cog, country |
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  @counter = 1
  @site = cog
  @country = country
  @url_comp = "#{@country.downcase}" + "_url"
  @site_information = Siteinfo.get_devsiteinfo "#{@site+@country}"
  begin
    on(GeoPage) do |page|
      page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "sign-in"+ "/")
      @popup_box_present = (page.check_geo_popup_box_present?)
      if (@country != 'AU' && @popup_box_present)
        while @counter < 2
          @counter = @counter + 2
          page.click_stay_current_site
        end
      end
    end
  end
end

And(/^I login to the site for the "([^"]*)" with "([^"]*)" and "([^"]*)"$/) do |user_type, email_id, password|
  if user_type == 'registered'
    on(SignInPage) do |page|
      page.wait_for_ajax
      page.enter_email email_id
      page.click_sign_me_in
      page.enter_pass password
      page.click_sign_me_in
    end
  end
end

And(/^I add "([^"]*)" with "([^"]*)" to the cart page$/) do |normal_products, quantity|
  if normal_products != ''
  @qty  = quantity
  products = normal_products
  table = products.split(/,/)
  table.each do |data|
  on(PdpPage) do |page|
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{data}" + ".html")
    page.wait_for_ajax
    # @loop = 0
    # for i in 1..(@qty) -- make it i in above
      on(PdpPage) do |page|
        if page.add_to_bag_enabled?
          page.select_qty @qty
          page.click_add_to_bag
        end
        expect(page.overlapped_success_message).to include 'to bag'
        # @loop = 1+@loop
        page.close_ovelapped_success_message
      end
    end
   end
  end
 end
# end

And(/^I add "([^"]*)" with "([^"]*)" to cart page$/) do |personalised_products, personalised_text|
  if personalised_products != ''
  @personalised_msg = personalised_text
  @qty = @qty.to_i
  on(PdpPage) do |page|
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{personalised_products}" + ".html")
    page.wait_for_ajax
    @loop = 0
    for i in 1..(@qty)
      on(PdpPage) do |page|
        if @personalised_msg != ''
          page.fill_personalised_text "#{@personalised_msg}"
        end
        if page.add_to_bag_enabled?
          page.click_add_to_bag
        end
        expect(page.overlapped_success_message).to include 'to bag'
        @loop = 1+@loop
        page.close_ovelapped_success_message
      end
    end
  end
 end
end

And(/^I add gift wrap with selected "([^"]*)"$/) do |gift_wrap_design|
  if gift_wrap_design != ''
  @count=0
  on(Gift_Wrap) do |page|
    page.giftwrap_dd_click
    page.start_wrapping_btn_click
    page.select_giftbag gift_wrap_design
    page.click_basket_line_items @count
    page.click_create_my_gift_btn
  end
 end
end


And(/^I click on the Checkout button on My Bag page to navigate to Checkout page$/) do
  on(MybagPage) do |page|
    page.bag_checkout
    @wait_for_page_to_load.page_wait
  end
end

And(/^I select "([^"]*)", "([^"]*)" on the eGiftCard page$/) do |egift_card_design, egift_card_amount|
  if egift_card_design != ''
  on(PdpPage) do |page|
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{egift_card_design}" + ".html")
    page.wait_for_ajax
  end
  on(EGiftCardPage) do |page|
    page.select_design egift_card_design
    page.select_gc_amount egift_card_amount
  end
 end
end

And(/^I enter "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" on the eGiftCard page$/) do |recipient_name, recipient_email, recipient_conf_email, senders_name, senders_message|
  if recipient_name != ''
  on(EGiftCardPage) do |page|
    @rec_name = recipient_name
    @rec_email = recipient_email
    @conf_rec_email = recipient_conf_email
    @sender_name = senders_message
    @sender_meg = senders_message
    if recipient_name != 'empty'
      page.enter_recipient_name recipient_name
    end
    if recipient_email != 'empty'
      page.enter_recipient_email recipient_email
    end
    if recipient_conf_email != 'empty'
      page.enter_conf_recipient_email recipient_conf_email
    end
    if senders_name != 'empty'
      page.enter_senders_name senders_name
    end
    if senders_message != 'empty'
      page.enter_senders_msg senders_message
    end
    if page.add_to_bag_gc_enabled?
        page.click_add_to_bag_gc
    end
   end
  end
end

And(/^I applied gift card with "([^"]*)" and "([^"]*)" at the checkout page$/) do |gift_card_no, pin|
  if gift_card_no != ''
  on(CheckoutPage) do |page|
    page.expand_giftcard_textbox
    page.gift_card_no = gift_card_no
    page.gift_card_pin = pin
    page.apply_gift_card
    page.wait_for_ajax
  end
 end
end

And(/^I add the following "([^"]*)" at checkout page$/) do |voucher|
  if voucher != ''
  on(CheckoutPage) do |page|
    page.expand_perks_section
    page.enter_voucher voucher
    page.click_apply_voucher_btn
    page.wait_for_ajax
  end
 end
end

And(/^I enter "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" and "([^"]*)" for "([^"]*)"$/) do |email_id, subscribe, first_name, last_name, phone, user_type|
  if user_type == 'guest'
  @first_name = first_name
  @last_name = last_name
  @phone = phone
  on(CheckoutPage) do |page|
    page.enter_email email_id
    page.enter_first_name first_name
    page.enter_last_name last_name
    page.enter_phone_number phone
    if subscribe != ''
      on(CheckoutPage) do |page|
        case subscribe
        when 'yes'
          page.subscribe_to_perks
        end
      end
    end
  end
 end
end

And(/^I select address with "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" , "([^"]*)" or "([^"]*)" based on the "([^"]*)" and "([^"]*)" at checkout page$/) do |address1, country, city, state, state_abb, postcode, store_id, delivery_method, user_type|
  on(CheckoutPage) do |page|
     case delivery_method
       when 'CNC'
         page.cnc
         page.cnc
         page.find_my_store postcode
         page.store_search_button
         page.click_store store_id
         page.click_full_form
         if user_type == 'registered'
           page.enter_billing_info @first_name, @last_name, country, @phone
         else
           page.enter_billing_info_guest @first_name, @last_name, country
         end
         Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
         page.click_full_form
         page.enter_billing_address address1, city, postcode, state_abb
         if user_type == 'registered'
           page.enter_adyen_phone @phone
           page.uncheck_add_to_addressbook
         end
       when 'HD'
         page.hd
         page.enter_hd_first_name @first_name
         page.enter_hd_last_name @last_name
         page.enter_hd_country country
         if page.is_full_form_hd_open
         page.click_full_form_hd
         end
         # to handle cases where state is a text field as opposed to a drop down
         case country
           when 'AU', 'NZ', 'ZA', 'US', 'MY', 'SG'
             page.enter_hd_delivery_address address1, city, state_abb, postcode
           when 'GB', 'JP'
             page.enter_uk_hd_delivery_address address1, city, state,  postcode
         end
         if user_type == 'registered'
           page.enter_hd_phone_number @phone
           page.uncheck_save_del_add
         end
         if !(page.same_add_billing_checked?)
           page.check_use_billing_address
         end
         if page.auth_to_leave_present?
          page.select_auth_to_leave 'Leave out of the weather'
         end
       when 'DEFAULT'
         page.enter_hd_first_name @first_name
         page.enter_hd_last_name @last_name
         page.enter_hd_country country
         case country
           when 'AU','NZ','SA','US'
             page.click_full_form_hd
         end
         if country != 'GB'
           @state_abb = state_abb.to_s
           page.enter_hd_delivery_address address1, city, @state_abb,  postcode
         else
           page.enter_uk_hd_delivery_address address1, city, state,  postcode
         end

        if user_type == 'registered'
          page.enter_hd_phone_number @phone
          page.uncheck_save_del_add
        end
        if !(page.same_add_billing_checked?)
          page.check_use_billing_address
        end
      end
  end
end

And(/^I place the order using credit card as "([^"]*)" with "([^"]*)", "([^"]*)", "([^"]*)", and "([^"]*)"$/) do |payment_method, cc_number, exp_month, exp_year, sec_code|
  if payment_method == 'credit card'
  on(CheckoutPage) do |page|
      @name = @first_name+" "+ @last_name
      @exp_month = exp_month.to_s
      @exp_year = exp_year.to_s
      @sec_code = sec_code.to_s
      @wait_for_page_to_load.page_wait
      page.click_cc
      page.place_order
      page.enter_adyen_valid_cc_details cc_number, @name, @exp_month, @exp_year, @sec_code
      page.uncheck_saved_card_adyen
      @order_total_adyen_page = page.get_order_total_on_adyen_page
      page.place_order_adyen
      on(ThankyouPage) do |page|
        page.is_Thankyou_page_displayed?
        @order_number = page.find_dw_order_number
        p @order_number
      end
   end
  end
end


And(/^I place the order using paypal as "([^"]*)" with "([^"]*)" and "([^"]*)"$/) do |payment_method, paypal_email, paypal_password|
  if payment_method == 'paypal'
  on(CheckoutPage) do |page|
      page.order_summary_content_visible?
      page.click_paypal_tab
      page.click_paypal_button
      on(PaypalPage) do |page|
        @payment_info = Payment.get_payment_info 'paypal'
        if (page.present_paypal_email_field?) == true
          page.paypal_login paypal_email, paypal_password
          page.paypal_spinner_visible?
          page.click_continue_paypal_store
        end
      end
      on(ThankyouPage) do |page|
        page.is_Thankyou_page_displayed?
        @order_number = page.find_dw_order_number
        p @order_number
      end
    end
  end
end


And(/^I place the order using afterpay as "([^"]*)" with "([^"]*)" and "([^"]*)"$/) do |payment_method, afterpay_email, afterpay_password|
  if payment_method == 'afterpay'
  on(CheckoutPage) do |page|
      page.click_afterpay_tab
      page.place_order
      on(AfterpayPopup_Page) do |page|
        @payment_info = Payment.get_payment_info 'afterpay'
        page.afterpay_login afterpay_email, afterpay_password
        page.afterpay_due_today_check
        page.enter_cvc_afterpay_page
        page.check_over_eighteen_checkbox
        page.place_order_afterpay
      end
      on(ThankyouPage) do |page|
        page.is_Thankyou_page_displayed?
        @order_number = page.find_dw_order_number
        p @order_number
      en
     end
   end
  end
end

And(/^I place the order using cash on delivery as "([^"]*)" at checkout page$/) do |payment_method|
  if payment_method == 'cash_on_delivery'
  on(CheckoutPage) do |page|
    case payment_method
      when 'cash_on_delivery'
        page.click_cash_on_delivery_tab
        page.place_order
        on(ThankyouPage) do |page|
          page.is_Thankyou_page_displayed?
          @order_number = page.find_dw_order_number
          p @order_number
        end
     end
   end
  end
end


And(/^I change the shipping method as "([^"]*)" on the checkout page$/) do |shipping_method|
  if shipping_method != ''
  on(CheckoutPage) do |page|
    page.wait_for_ajax
    page.select_delivery_method shipping_method
    page.wait_for_ajax
  end
 end
end


