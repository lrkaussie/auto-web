And(/^the user clicks on activate voucher email link for "([^"]*)"$/) do |arg|
  on(LoyaltyPage) do |page|
    page.navigate_to("#{$site_comp_url}"+ "/" + "activate-perks/?customer=" + "#{@person['fullname']['fname'].downcase}" + "." + "#{@person['fullname']['lname'].downcase}" + "&voucher=" + "#{arg}" + "&token=5a9af584b62a8ce9bbf0f95397e715f6")
  end
end

And(/^the customer sees the overlay popup message "([^"]*)"$/) do |arg|
  on(LoyaltyPage) do |page|
    expect(page.rewards_popup_description).to include arg
  end
end

And(/^the message has the text "([^"]*)"$/) do |arg|
  on(LoyaltyPage) do |page|
    #to_do There is an issue with Loyalty mock where sometimes it returns 9 days as voucher expiry days and sometimes 10 days.
    #As a workaround we just check if it is equal to either of the two. Will fix the mock when we get time
    expect(page.rewards_popup_expiration).to include {"Expires in 10 days.";"Expires in 9 days."}
  end
end

And(/^the order discount in the Order Summary section on My Bag page is "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    expect((page.order_discount).to_s == (arg)).to be(true)
  end
end

And(/^the order discount after perks voucher applied is "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    expect((page.order_disc).to_s == (arg)).to be(true)
  end
end

And(/^the voucher "([^"]*)" is applied on the checkout page under the PERKS voucher section$/) do |arg|
  on(CheckoutPage) do |page|
    page.expand_perks_section
    expect(page.applied_vouchers).to include arg
  end
end

And(/^the total on checkout is "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    sleep 8
    expect(page.order_total_value).to include arg
  end
end

Then(/^price adjustment for voucher (.+) is "([^"]*)"$/) do |arg1, arg2|
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
    #begin
    case @country
    when 'SA'
      page.select_rsa_dd_bm
    when 'US'
      page.select_us_dd_bm
    when 'NZ'
      page.select_nz_dd_bm
    when 'AU'
      if @site == 'SUPRE'
        page.select_au_supre_dd_bm
      else
        page.select_au_dd_bm
      end
    when 'MY'
      page.select_my_dd_bm
    when 'UK'
      page.select_uk_dd_bm
    end
    #end
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@failed_order_number}" if defined? @failed_order_number
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    page.click_order_result_bm
    expect(page.adj_order_price(arg1)).to include arg2
    page.bm_logout
  end
end

Then(/^the voucher is applied on the checkout page under the PERKS voucher section$/) do
  @voucher_list.each {|data|
    expect(on(CheckoutPage).applied_vouchers).to include data['voucher_id']
  }
end

And(/^the customer can see the Remove link against the PERKS voucher$/) do
  index = 0
  @voucher_list.each {|data|
    expect(on(CheckoutPage).check_remove_link(index)).to be(true)
    index = index+1
  }
end

And(/^the user expands the voucher section$/) do
  on(CheckoutPage) do |page|
    page.expand_perks_section
    end
end


And(/^the click to activate voucher is applied on the checkout page under the PERKS voucher section$/) do
  @click_to_activate_voucher_list.each {|data|
    expect(on(CheckoutPage).applied_vouchers).to include data['voucher_id']
   }
end

And(/^the customer can see the Remove link against the click to activate voucher$/) do
  index = 0
  @click_to_activate_voucher_list.each {|data|
    expect(on(CheckoutPage).check_remove_link(index)).to be(true)
    index = index+1
  }
end

And(/^the user has received click to activate emails for vouchers$/) do |table|
  @click_to_activate_voucher_list = table.hashes
end

Then(/^the customer sees the voucher error message "([^"]*)"$/) do |arg|
  expect(on(CheckoutPage).check_voucher_error_message).to include arg
end


And(/^the user sees overlay popup message$/) do |table|
  on(CheckoutPage) do |page|
    table.hashes.each {|data|
      expect(page.check_overlay_pop_up_message).to include data['message']
    }
    page.dismiss_overlay_pop_up_message
  end
end
