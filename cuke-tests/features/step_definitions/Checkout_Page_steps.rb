require_relative '../support/personas'
require 'page-object'
require 'page-object/page_factory'
require_relative '../support/pages/Frontend/Cotton_On/utility_functions'
require 'fig_newton'
require 'yaml'

Given(/^I am on country "([^"]*)"$/) do |arg|
  @country = arg
  @url_comp = "#{@country.downcase}" + "_url"
  @wait_for_page_to_load = Utility_Functions.new(@browser)
end

And(/^site is "([^"]*)"$/) do |arg|
  @site = arg
  @site_information = Siteinfo.get_siteinfo "#{@site+@country}"
  $site_comp_url = "#{@site_information["#{@url_comp}"]}"
end

Given(/^a bag with products:$/) do |table|
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  @counter = 1
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    begin
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
        @popup_box_present = (page.check_geo_popup_box_present?)
        if (@country != 'AU' && @popup_box_present)
          while @counter < 2
            @counter = @counter + 2
            page.click_stay_current_site
          end
        end
      end
      on(PdpPage) do |page|
        if @qty > "1"
          begin
            retries ||= 0
            page.select_qty @qty
            page.click_add_to_bag
            expect(page.overlapped_success_message).to include 'to bag'
          rescue Selenium::WebDriver::Error::JavascriptError
            retry if (retries += 1) < $code_retry
          end
        else
          page.click_add_to_bag
          expect(page.overlapped_success_message).to include 'to bag'
        end
      end
      @wait_for_page_to_load.page_wait
      on(MinicartPage) do |page|
        page.click_mini_cart_icon
      end
    end
  end
end

And(/^a bag with personalised product with personalised text "([^"]*)" and click on proceed to checkout on success overlay:$/) do |arg, table|
  @counter = 1
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    @qty = @qty.to_i
    begin
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
        @popup_box_present = (page.check_geo_popup_box_present?)
        if (@country != 'AU' && @popup_box_present)
          while @counter < 2
            @counter = @counter + 2
            page.click_stay_current_site
          end
        end
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          # need to refactor this piece and remove sleep at a later stage
          page.fill_personalised_text arg
          page.click_add_to_bag
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.click_checkout_button
        end
      end
      @wait_for_page_to_load.page_wait
    end
  end
end

And(/^a bag with products with click continue on success overlay:$/) do |table|
  @counter = 1
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    @qty = @qty.to_i
    begin
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
        @popup_box_present = (page.check_geo_popup_box_present?)
        if (@country != 'AU' && @popup_box_present)
          while @counter < 2
            @counter = @counter + 2
            page.click_stay_current_site
          end
        end
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          # need to refactor this piece and remove sleep at a later stage
          page.click_add_to_bag
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.click_continue_button
        end
      end
      @wait_for_page_to_load.page_wait
    end
  end
end

And(/^a bag with products with click on proceed to checkout on success overlay:$/) do |table|
  @counter = 1
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    @qty = @qty.to_i
    begin
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          # need to refactor this piece and remove sleep at a later stage
          page.click_add_to_bag
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.click_checkout_button
        end
      end
      @wait_for_page_to_load.page_wait
    end
  end
end

Given(/^a bag with products via search from search bar:$/) do |table|
  @counter = 1
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    @qty = @qty.to_i
    begin
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
        @popup_box_present = (page.check_geo_popup_box_present?)
        if (@country != 'AU' && @popup_box_present)
          while @counter < 2
            @counter = @counter + 2
            page.click_stay_current_site
          end
        end
        on(SearchPage) do |page|
          page.enter_search_key @sku
          page.click_search_icon
        end
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          # need to refactor this piece and remove sleep at a later stage
          page.click_add_to_bag
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.close_ovelapped_success_message
        end
      end
      @wait_for_page_to_load.page_wait
      on(MinicartPage) do |page|
        page.click_mini_cart_icon
      end
    end
  end
end

Given(/^a bag with products via megamenu and plp:$/) do |table|
  @counter = 1
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    @qty = @qty.to_i
    begin
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
        on(SearchPage) do |page|
          page.enter_search_key @sku
          page.click_search_icon
        end
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          # need to refactor this piece and remove sleep at a later stage
          page.click_add_to_bag
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.close_ovelapped_success_message
        end
      end
      @wait_for_page_to_load.page_wait
      on(MinicartPage) do |page|
        page.click_mini_cart_icon
      end
    end
  end
end



And(/^bag selected delivery option from the drop down is "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    @val = 0
    page.click_delivery_methods_dd
    case arg
      when "standard_delivery"
        @val == 0
    end
    @wait_for_page_to_load.page_wait
    page.sel_del_method @val
    @wait_for_page_to_load.page_wait
  end
end


And(/^the price of product before any promotion is verified$/) do
  on(MybagPage) do |page|

    case @country
      when 'SA'
        expect((page.sale_price_before_disc).to_f == ((("#{FigNewton.price_before_promo_sa}").to_f * (@data['qty']).to_f).round(2))).to be(true)
      when 'NZ'
        expect((page.sale_price_before_disc).to_f == ((("#{FigNewton.price_before_promo_nz}").to_f * (@data['qty']).to_f).round(2))).to be(true)
      when 'AU'
        expect((page.sale_price_before_disc).to_f == ((("#{@product_info['product_price']['before_promo_au']}").to_f * @product_promo_qty.to_f).round(2))).to be(true)
    end
  end
end


And(/^the price of product before any promotion is "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    expect(page.sale_price_before_disc).to eq arg
  end
end


And(/^promo code added on bag "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    page.order_total
    page.sale_price_before_disc
    page.apply_promo_code arg
    @order_total_checkout_page = (page.order_total).to_f
  end
end

And(/^the price of product after order promotion applied is verified$/) do
  on(MybagPage) do |page|
    @wait_for_page_to_load.page_wait
    @order_total_checkout_page = page.order_total
    case @country
      when 'SA'
        expect((page.order_total).to_f == (("#{FigNewton.price_after_order_promo_sa}").to_f)).to be(true)
      when 'NZ'
        expect((page.order_total).to_f == (("#{FigNewton.price_after_order_promo_nz}").to_f)).to be(true)
      when 'AU'
        expect((page.order_discount).to_f == (("#{@product_info['product_price']['order_discount']}").to_f)).to be(true)
    end
  end
end


And(/^the discount price after order promotion applied is "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    # @wait_for_page_to_load.page_wait
    expect((page.order_discount).to_s == (arg)).to be(true)
  end
end

And(/^the price of product after product promotion applied is verified$/) do
  on(MybagPage) do |page|
    @order_total_checkout_page = page.order_total
    @wait_for_page_to_load.page_wait
    case @country
      when 'SA'
        expect((page.product_sale_price_after_disc).to_f == ((("#{FigNewton.price_after_product_promo_sa}").to_f * (@data['qty']).to_f).round(2))).to be(true)
      when 'NZ'
        expect((page.product_sale_price_after_disc).to_f == ((("#{FigNewton.price_after_product_promo_nz}").to_f * (@data['qty']).to_f).round(2))).to be(true)
      when 'AU'
        expect((page.product_sale_price_after_disc).to_f == ((("#{@product_info['product_price']['after_product_promo_au']}").to_f * @product_promo_qty.to_f).round(2))).to be(true)
    end
  end
end

And(/^the price of product after product promotion applied is "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    page.order_total
    # @wait_for_page_to_load.page_wait
    expect((page.product_sale_price_after_disc).to_s == (arg)).to be(true)
  end
end

And(/^the price of product after shipping promotion applied is verified$/) do
  on(MybagPage) do |page|
    @wait_for_page_to_load.page_wait
    case @country
      when 'SA'
        expect((page.order_total).to_f == (("#{FigNewton.price_after_shipping_promo_sa}").to_f)).to be(true)
      when 'NZ'
        expect((page.order_total).to_f == (("#{FigNewton.price_after_shipping_promo_nz}").to_f)).to be(true)
      when 'AU'
        expect(@order_total_checkout_page  == (("#{@product_info['product_price']['after_shipping_promo_au']}").to_f)).to be(true)
    end
  end
end

And(/^the price of product after shipping promotion applied is "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
	  expect((page.order_total).to_f).to eq(arg.to_f)
  end
end

And(/^checkout button is pressed$/) do
  on(MybagPage) do |page|
    page.bag_checkout
    expect((@browser.url).include?"/checkout/?bagpage=true")
  end
end


And(/^user selects to checkout from their bag$/) do
  on(MybagPage) do |page|
    sleep 2
    page.bag_checkout
  end
end

When(/^user clicks on checkout with Paypal button$/) do
  on(CheckoutPage) do |page|
    page.click_paypal_button
  end
end


And(/^an user "([^"]*)"$/) do |arg|
  @person = Personas.get_persona arg
end

And(/^user selects the payment type as "([^"]*)"$/) do |arg|
  @pay_type = arg
  on(CheckoutPage) do |page|
    begin
      case @pay_type
      when 'afterpay'
        page.click_afterpay_tab
      when 'adyen_valid_creditcard'
        # @wait_for_page_to_load.page_wait
        sleep 2
        page.click_cc
      when 'adyen_invalid_cvc_creditcard'
        @wait_for_page_to_load.page_wait
        page.click_cc
      when 'adyen_invalid_creditcard'
        @wait_for_page_to_load.page_wait
        page.click_cc
      when 'adyen_3DS_valid_creditcard'
        sleep 2
        page.click_cc
      when 'ipay'
        page.order_summary_content_visible?
        page.click_ipay
      when 'paypal'
        page.order_summary_content_visible?
        page.click_paypal_tab
      when 'cash_on_delivery'
        page.order_summary_content_visible?
        page.click_cash_on_delivery_tab
        @order_total = page.get_order_total
      when 'zip'
        page.order_summary_content_visible?
        page.click_zip_tab
      when 'laybuy'
        page.order_summary_content_visible?
        page.click_laybuy_tab
      when 'latpay'
        page.order_summary_content_visible?
        page.click_latpay_tab
      when 'humm'
        page.click_humm_tab
      when 'genoapay'
        sleep 2
        page.click_genoapay_tab
      when 'quadpay'
        page.click_quadpay_tab
      when 'payflex'
        page.click_payflex_tab
      when 'klarna'
        page.click_klarna_tab
      end
    end
  end
end

And(/^user selects the payment type as "([^"]*)" for response code as "([^"]*)"$/) do |arg1, arg2|
  @hpp_card_name = arg2
  @pay_type = arg1
  on(CheckoutPage) do |page|
    sleep 2
    page.click_cc
  end
end

When(/^user checks out with details:$/) do |table|
  @data = table.hashes.first
  on(CheckoutPage) do |page|
    case @data['user_type']
    when 'guest'
        page.enter_email @person['email_info']['email_address']
        page.enter_first_name @person['fullname']['fname']
        page.enter_last_name @person['fullname']['lname']
        page.enter_phone_number @person['phone']
      when 'registered'
        page.enter_email @person['email_info']['email_address']
        page.click_sign_in_here
        page.enter_pass @person['email_info']['password']
        page.sign_me_btn
    end
    begin
      case @data['delivery_type']
        when 'CNC'
          page.cnc
          page.cnc
          page.enter_first_name @person['fullname']['fname']
          page.enter_last_name @person['fullname']['lname']
          page.enter_phone_number @person['phone']
          page.find_my_store @person['store_postcode']
          page.store_search_button
          # page.click_store @person['store_id']
          @cnc_store_value = page.select_cnc_store_co_pg @person['store_id']
          @status = (@cnc_store_value == "store-details select-checkbox active")
          if @status == 'false'
            # page.click_store @person['store_id']
            page.select_cnc_store_co_pg @person['store_id']
          else
          end
          @order_total_checkout_page = page.order_summary_total
          # page.click_cc
          # if (@data['user_type'] == 'registered')
          #   page.enter_cc_billing_info @person['fullname']['fname'], @person['fullname']['lname'], @person['country_value'], @person['phone']
          # else
          #   page.enter_cc_billing_info_guest @person['fullname']['fname'], @person['fullname']['lname'], @person['country_value']
          # end
          # Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          # page.click_full_form_cc
          # page.enter_cc_billing_address @person["#{@data['address']}"]['address1'], @person["#{@data['address']}"]['city'], @person["#{@data['address']}"]['postcode'], @person["#{@data['address']}"]['state_abb']
          # if (@data['user_type'] == 'registered')
          #   page.enter_cc_adyen_phone @person['phone']
          #   page.uncheck_add_to_addressbook
          # end
        when 'HD'
          page.hd
          page.enter_hd_first_name @person['fullname']['fname']
          page.enter_hd_last_name @person['fullname']['lname']
          page.enter_hd_country @person['country_value']
          if page.is_full_form_hd_open
          page.click_full_form_hd
          end
          # to handle cases where state is a text field as opposed to a drop down
          case @person['country_value']
            when 'AU', 'NZ', 'ZA', 'US'
              page.enter_hd_delivery_address @person["#{@data['address']}"]['address1'], @person["#{@data['address']}"]['city'], @person["#{@data['address']}"]['state_abb'],  @person["#{@data['address']}"]['postcode']
            when 'GB', 'JP'
              page.enter_uk_hd_delivery_address @person["#{@data['address']}"]['address1'], @person["#{@data['address']}"]['city'], @person["#{@data['address']}"]['state'],  @person["#{@data['address']}"]['postcode']
          end
          if (@data['user_type'] == 'registered')
            page.enter_hd_phone_number @person['phone']
            page.uncheck_save_del_add
          end
          # page.click_cc
          # if !(page.same_add_billing_checked?)
          #   page.check_cc_use_billing_address
          # end
          if page.auth_to_leave_present?
            page.select_auth_to_leave 'Leave out of the weather'
          end
        when 'DEFAULT'
          page.enter_hd_first_name @person['fullname']['fname']
          page.enter_hd_last_name @person['fullname']['lname']
          page.enter_hd_country @person['country_value']
          case @country
            when 'AU','NZ','SA','US'
              page.click_full_form_hd
          end
          if (@person['country_value'] != 'GB')
            page.enter_hd_delivery_address @person["#{@data['address']}"]['address1'], @person["#{@data['address']}"]['city'], (@person["#{@data['address']}"]['state_abb'].to_s),  @person["#{@data['address']}"]['postcode']
          else
            page.enter_uk_hd_delivery_address @person["#{@data['address']}"]['address1'], @person["#{@data['address']}"]['city'], (@person["#{@data['address']}"]['state']),  @person["#{@data['address']}"]['postcode']
          end

          if (@data['user_type'] == 'registered')
            page.enter_hd_phone_number @person['phone']
            page.uncheck_save_del_add
          end
          # page.click_cc
          # if !(page.same_add_billing_checked?)
          #   page.check_cc_use_billing_address
          # end
      end
    end
  end
end

And(/^the user clicks on the Continue to Payment button on the Checkout page for "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    if defined? @order_balance_remaining
      @order_total_checkout_page = @order_balance_remaining
    else
      @order_total_checkout_page = page.order_summary_total
    end
    if arg == "Credit Card"
	    page.cc_place_order
      begin
        case @pay_type
        when 'adyen_valid_creditcard'
          page.enter_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], (@person['fullname']['fname'] +" "+ @person['fullname']['lname']), ("0" + (@person["#{@pay_type}"]['exp_month']).to_s), (@person["#{@pay_type}"]['exp_year'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s)
          page.uncheck_saved_card_adyen
          @order_total_adyen_page = page.get_order_total_on_adyen_page
        when 'adyen_invalid_creditcard'
          page.enter_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], ("#{@hpp_card_name}" +" "+ @person['fullname']['lname']), ("0" + (@person["#{@pay_type}"]['exp_month']).to_s), (@person["#{@pay_type}"]['exp_year'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s)
          page.uncheck_saved_card_adyen
        when 'adyen_invalid_cvc_creditcard'
          page.enter_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], ("#{@hpp_card_name}" +" "+ @person['fullname']['lname']), ("0" + (@person["#{@pay_type}"]['exp_month']).to_s), (@person["#{@pay_type}"]['exp_year'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s)
          page.uncheck_saved_card_adyen
        end
      end
    end
    if arg == "Adyen"
      page.cc_place_order
    end
    if arg == "Afterpay"
      page.afterpay_place_order
    end
    if arg == "COD"
      page.cod_place_order
    end
    if arg == "zip"
      page.zip_place_order
      sleep 2
    end
    if arg == "laybuy"
      page.get_laybuy_inst_amt
      page.laybuy_place_order
    end
    if arg == "latpay"
      page.get_latpay_inst_amt
      page.latpay_place_order
    end
    if arg == "humm"
      page.humm_place_order
    end
    if arg == "humm_nz"
      page.humm_nz_place_order
    end
    if arg == "genoapay"
      sleep 2
      page.genoapay_place_order
    end
    if arg == "quadpay"
      page.get_order_total
      page.get_quadpay_inst_amt
      page.quadpay_place_order
    end
    if arg == "payflex"
      page.get_order_total
      page.get_payflex_inst_amt
      page.payflex_place_order
    end
  end
end

When(/^on Afterpay page user places an order on "([^"]*)" site$/) do |arg|
  on(AfterpayPopup_Page) do |page|
    @payment_info = Payment.get_payment_info 'afterpay'
    if arg != "NZ"
      page.afterpay_v2_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
      @afterpay_order_total = page.validate_v2_afterpay_page
      expect((page.validate_v2_afterpay_page).to_f).to eq(@order_total_checkout_page.to_f);
      page.place_order_v2_afterpay
      sleep 5
    end
    if arg == "NZ"
      page.afterpay_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
      page.afterpay_due_today_check
      @afterpay_order_total = page.validate_afterpay_page
      expect((page.validate_afterpay_page).to_f).to eq(@order_total_checkout_page.to_f);
      page.enter_cvc_afterpay_page
      page.check_over_eighteen_checkbox
      page.place_order_afterpay
      sleep 5
    end
  end
end

And(/^on adyen HPP user places an order$/) do
  on(CheckoutPage) do |page|
    page.place_order_adyen
  end
end

Then(/^Thankyou page is shown$/) do
  on(ThankyouPage) do |page|
    @wait_for_page_to_load.page_wait
    expect(page.order_page_url).to include 'complete'
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
  end
end

Then(/^Adyen Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    @order_number = page.find_dw_order_number
    on(Utility_Functions) do |page|
      expect(page.return_browser_url).to include 'AUTHORISED'
    end
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']).to_s,(@person['phone']).to_s,(@person['house']['postcode']).to_s)
  end
end

Then(/^Paypal Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    @order_number = page.find_dw_order_number
    # order confirmation page takes too much time to load in jenkins. temp workaround
    # to_do remove this sleep at a later stage
    sleep 5
    expect(page.order_confirm_page_loaded?).to be(true)
    on(Utility_Functions) do |page|
      expect(page.return_browser_url).to include 'complete-pp'
    end
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include '1', 'gttt', 'ACT', '1234'
  end
end


Then(/^Afterpay Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    page.order_confirm_mesage_visible?
    @order_number = page.find_dw_order_number
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['phone'].to_s),(@person['house']['postcode'].to_s))
  end
end

And(/^"([^"]*)" delivery address is shown on the Adyen Thankyou page$/) do |arg|
  case arg
    when 'HD', 'DEFAULT'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb'].to_s),(@person['house']['postcode'].to_s))
      end
    when 'HD second'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['house 2']['fname']),(@person['house 2']['lname']),(@person['house 2']['address2']),(@person['house 2']['city']),(@person['house 2']['state_abb'].to_s),(@person['house 2']['postcode'].to_s))
    end
    when 'CNC'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['store_address']),(@person['store_city']),(@person['store_postcode'].to_s))
        expect(page.confirm_delivery_method).to include('Click & Collect')
      end
    when 'email'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_method).to include('Email - FREE')
      end
  end
end

And(/^"([^"]*)" delivery address is shown on the Paypal Thankyou page$/) do |arg|
  case arg
    when 'HD_Registered'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb'].to_s),(@person['house']['postcode'].to_s))
      end
    when 'HD', 'DEFAULT'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb'].to_s),(@person['house']['postcode'].to_s))
      end
    when 'CNC'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['store_address']),(@person['store_city']),(@person['store_postcode'].to_s))
        expect(page.confirm_delivery_method).to include('Click & Collect')
      end
  end
end


And(/^"([^"]*)" delivery address is shown on the Afterpay Thankyou page$/) do |arg|
  case arg
    when 'HD'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['house']['postcode'].to_s))
      end
    when 'CNC'
      on(ThankyouPage) do |page|
        expect(page.confirm_delivery_address).to include((@person['fullname']['fname']), (@person['fullname']['lname']),(@person['store_address']),(@person['store_city']), (@person['store_postcode'].to_s))
        expect(page.confirm_delivery_method).to include('Click & Collect')
      end
  end
end

And(/^placed order total is verified and payment type is "([^"]*)"$/) do |arg|
  on(ThankyouPage) do |page|
    if defined? @applied_gift_cards
      expect((page.assert_payment_type @applied_gift_cards.length).to_s == (arg)).to be(true)
    else
      expect((page.assert_payment_type 0).to_s == (arg)).to be(true)
    end
    case arg
    when 'Credit Card'
      if defined? @applied_gift_cards
        expect((page.assert_credit_total_on_conf_page).to_s == (@order_total_checkout_page)).to be(true)
      else
        expect((page.assert_order_total_on_conf_page).to_s == (@order_total_checkout_page)).to be(true)
      end
    when 'adyen', 'bank'
      expect((page.assert_order_total_on_conf_page).to_s == (@order_total_adyen_page)).to be(true)
    when 'afterpay'
      expect((page.assert_order_total_on_conf_page).to_s == (@afterpay_order_total)).to be(true)
    when 'Cash On Delivery'
      expect((page.assert_order_total_on_conf_page).to_s == (@order_total)).to be(true)
    when 'ZIP Pay Over Time'
      expect(((page.assert_order_total_on_conf_page).to_s) == ($zip_order_total.gsub(/[$]/,''))).to be(true)
     # .gsub(/[AU]/,''
    when 'Laybuy'
      # expect((((page.assert_order_total_on_conf_page).to_s).gsub(/[AU]/,'')) == $laybuy_order_total.to_s).to be(true)
    when 'LatitudePay'
      expect((((page.assert_order_total_on_conf_page).to_s).gsub(/[AU]/,'')) == $latpay_page_order_total.to_s).to be(true)
    end
  end
end

And(/^placed split order total is verified and payment type is "([^"]*)"$/) do |arg|
  on(ThankyouPage) do |page|
    if defined? @applied_gift_cards
      expect((page.assert_payment_type @applied_gift_cards.length).to_s == (arg)).to be(true)
    else
      expect((page.assert_payment_type 0).to_s == (arg)).to be(true)
    end
  end
end

When(/^order total is recorded$/) do
  on(CheckoutPage) do |page|
    @order_total = page.get_order_total
  end
end

And(/^I have a bag with products:$/) do |table|
  @data = table.hashes.first
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  on(GeoPage) do |page|
        page.navigate_to("#{FigNewton.au_url}"+ "/" + @data['sku'] + ".html")
    @wait_for_page_to_load.page_wait
    for i in 1..(@data['qty']).to_i
      on(PdpPage) do |page|
        page.click_add_to_bag
        expect(page.overlapped_success_message).to include 'to bag'
      end
    end

    on(PdpPage) do |page|
      # need to check issue with the product added popup message
      page.close_ovelapped_success_message
    end


    @wait_for_page_to_load.page_wait

    on(MinicartPage) do |page|
      page.click_mini_cart_icon
    end
  end
end

And(/^cart is "([^"]*)"$/) do |arg|
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  case @country
    when 'SA'
      @sku= '2063046999910'
      @counter = 1
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
      end
    when 'AU','NZ', 'US', 'MY', 'UK'
      @sku= '9351785092140'
      @counter = 1
      on(GeoPage) do |page|
        @url_comp = "#{@country.downcase}" + "_url"
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
      end
  end
  @qty = 1
  for i in 1.."#{@qty}".to_i
    on(PdpPage) do |page|
      page.click_add_to_bag
      expect(page.overlapped_success_message).to include 'to bag'
    end
  end
  on(PdpPage) do |page|
    # to_do need to check issue with the product added popup message
    page.close_ovelapped_success_message
  end
  @wait_for_page_to_load.page_wait
  on(MinicartPage) do |page|
    page.click_mini_cart_icon
  end
  # on(MybagPage) do |page|
  #   @val = 0
  #   page.click_delivery_methods_dd
  #   @wait_for_page_to_load.page_wait
  #   page.sel_del_method @val
  # end
  on(MybagPage) do |page|
    page.bag_checkout
    expect((@browser.url).include?"/checkout/?bagpage=true")
    # @wait_for_page_to_load.page_wait
  end
end


Then(/^user is taken back from ipay page to the checkout page$/) do
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include 'cancel'
  end
  on(CheckoutPage) do |page|
    page.order_summary_content_visible?
  end
end

Then(/^I can see "([^"]*)" details for the user$/) do |arg|
  on(CheckoutPage) do |page|
    case arg
      when 'HD'
        expect((page.is_hd_checked).to_s == ("true")).to be(true)
      when 'CNC'
        expect((page.is_cnc_checked).to_s == ("true")).to be(true)
    end
  end
end

Then(/^user is taken back to checkout page with "([^"]*)" details$/) do |arg|
  on(Utility_Functions) do |page|
#    @falied_checkout_url = page.return_browser_url
    expect(page.return_browser_url).to include 'CANCELLED'
    @wait_for_page_to_load.page_wait
  end
  on(CheckoutPage) do |page|
    case arg
      when 'HD'
        expect((page.is_hd_checked).to_s == ("true")).to be(true)
      when 'CNC'
        expect((page.is_cnc_checked).to_s == ("true")).to be(true)
    end
  end
end

Then(/^user is taken back to checkout page with "([^"]*)" details if browser back it hit$/) do |arg|
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include 'checkout'
    @wait_for_page_to_load.page_wait
  end
  on(CheckoutPage) do |page|
    case arg
      when 'HD'
        expect((page.is_hd_checked).to_s == ("true")).to be(true)
      when 'CNC'
        expect((page.is_cnc_checked).to_s == ("true")).to be(true)
    end
  end
end

And(/^customer will land on the checkout page with "([^"]*)" details and the error message "([^"]*)"$/) do |arg1, arg2|
  on(Utility_Functions) do |page|
    @checkout_url = page.return_browser_url
    # @wait_for_page_to_load.page_wait
  end
  on(CheckoutPage) do |page|
    @failed_order_number = page.find_failed_order_number "#{@checkout_url}"
    case arg1
      when 'HD'
        expect((page.is_hd_checked).to_s == ("true")).to be(true)
      when 'CNC'
        expect((page.is_cnc_checked).to_s == ("true")).to be(true)
    end
    expect(page.error_msg_checkout).to include arg2
  end
end

And(/^the adyen HPP holderName is (.*)$/) do |response_codes|
  @hpp_card_name = "#{response_codes}"
end

And(/^on adyen HPP user selects "([^"]*)"$/) do |arg|
  on(HPPPage) do |page|
    case arg
      when 'Top Back'
        page.click_top_back_btn
      when 'Bottom Back'
        page.click_bottom_back_btn
      when 'Browser Back'
        page.hit_back_btn_browser
    end
  end
end

And(/^I click on the product name link in the order summary section$/) do
  on(CheckoutPage) do |page|
    #to_do check this function while refactoring next
    #page.click_product_row
  end
end

And(/^I click on the Subscribe button on the checkout page$/) do
  on(CheckoutPage) do |page|
    page.check_subscribe_btn
  end
end


And(/^I click on browser back button$/) do
  on(HPPPage) do |page|
    page.hit_back_btn_browser
  end
end

And(/^an user "([^"]*)" navigates to the checkout$/) do |arg|
  @person = Personas.get_persona arg
  on(CheckoutPage) do |page|
    page.enter_email @person['email_info']['email_address']
    page.click_sign_in_here
    page.enter_pass @person['email_info']['password']
    page.sign_me_btn
  end
end


And(/^selects country as "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    page.enter_hd_country arg
  end
end

When(/^the user enters the (.*)$/) do |inv_phone_number|
  on(CheckoutPage) do |page|
    page.hd
    page.enter_hd_phone_number inv_phone_number
    page.hd
  end
end

Then(/^the user sees the (.*)$/) do |error_message|
  on(CheckoutPage) do |page|
    expect(page.phone_error_text).to include error_message
  end
end


And(/^user selects "([^"]*)" on the checkout page$/) do |arg|
  on(CheckoutPage) do |page|
    page.hd
  end
end

Then(/^tax amount is "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    expect(page.get_tax_amt).to eq arg
  end
end

And(/^user enters the voucher "([^"]*)" in the perks section on the checkout page$/) do |arg|
  on(CheckoutPage) do |page|
    page.expand_perks_section
    page.enter_voucher arg
    page.click_apply_voucher_btn
  end
end

Then(/^the FPN display is seen on the checkout page:$/) do |table|
  @msg = table.hashes.first
  on(CheckoutPage) do |page|
    expect(page.fpn_validation_checkout_page).to include @msg['message_line_1']
    expect(page.fpn_validation_checkout_page).to include @msg['message_line_2']
  end
end

Then(/^the privacy policy link when expanded shows detailed description$/) do
  on(CheckoutPage) do |page|
    page.privacy_policy_checkout_page_link
    (page.privacy_policy_text_long_version).should_not be_nil
  end
end

And(/^user enters the voucher in the perks section on the checkout page$/) do |table|
  on(CheckoutPage) do |page|
    page.expand_perks_section
    @voucher_list = table.hashes
    @voucher_list.each {|data|
    sleep 2
    page.enter_voucher data['voucher_id']
    page.click_apply_voucher_btn
    page.wait_for_ajax
    }
  end
end


And(/^the user edits the bag from Checkout Page$/) do
  on(CheckoutPage).edit_bag_on_checkout
end

And(/^the user enters email on checkout "(.*)"$/) do |arg|
  on(CheckoutPage) do |page|
#    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "checkout" + "/")
    page.enter_email arg
    @browser.send_keys :tab
  end
end

When(/^the user clicks on Sign In Here Link$/) do
  on(CheckoutPage).click_sign_in_here
end


And(/^the user see the overlay pop up message "(.*)"$/) do |arg|
  expect(on(CheckoutPage).loyalty_account_pop_up_message).to include arg
end

And(/^the Join Perks checkbox is (.*+)$/) do |arg|
  if arg.to_s == 'shown'
    expect(on(CheckoutPage).is_perks_checkbox_visible).to be_truthy
  else
    expect(on(CheckoutPage).is_perks_checkbox_visible).to be_falsey
  end
end

And(/^the pop up has Create Your Account and No Thanks button$/) do
  expect(on(CheckoutPage).verify_perks_popup_buttons).to be_truthy
end

And(/^the user clicks the Create Your Account button on pop up$/) do
  on(CheckoutPage).create_online_account
end

Then(/^the user see the overlay password dialogue pop up message "(.*)"$/) do |arg|
expect(on(CheckoutPage).password_dialogue).to include arg
end

When(/^the user clicks on activate online account link$/) do
  on(CheckoutPage) do |page|
    #sleep for 30 seconds for the email to be received
    sleep 30
    set_password_link = page.get_password_token
    puts "The set password url is #{set_password_link}"
    page.navigate_to set_password_link
  end
end

And(/^the user creates the online account by giving password$/) do
  on(CheckoutPage).confirm_online_password
end

And(/^the checkout page has products$/) do |table|
  count = 0
  table.hashes.each do |data|
    expect(on(CheckoutPage).product_in_checkout_page(data['sku'],count)).to include data['sku']
    count = count+1
  end

end

And(/^the user (.*) on Checkout page$/) do |arg|
  expect(on(CheckoutPage).return_co_browser_url).to include "checkout"
end

And(/^the first name is prefilled as "([^"]*)"$/) do |arg|
  expect(on(CheckoutPage).first_name_checkout).to eq arg
end

And(/^last name is prefilled as "([^"]*)"$/) do |arg|
  expect(on(CheckoutPage).last_name_checkout).to eq arg
end

And(/^the user clicks the Continue as guest button on pop up$/) do
  on(CheckoutPage).continue_as_guest
end

And(/^the perks overlay popup closes$/) do
  expect(on(CheckoutPage).is_perks_pop_up_visible).to be_falsey
end

Then(/^the password field is visible$/) do
  expect(on(CheckoutPage).is_password_visible).to be_truthy
end

And(/^the user logs in to online account with password "(.*)"$/) do |arg|
  on(CheckoutPage).enter_pass arg.to_s
  on(CheckoutPage).sign_me_btn
end

Then(/^the user "(.*)" is logged in$/) do |arg|
  expect(on(CheckoutPage).login_header).to include "Hi #{arg} not you?"
end

When(/^"([^"]*)" enters details in signin section$/) do |arg|
  on(CheckoutPage) do |page|
      case arg
        when "guest"
          page.enter_email @person['email_info']['email_address']
      end
  end
end

And(/^user enters "([^"]*)" in contact details$/) do |arg|
  on(CheckoutPage) do |page|
    case arg
      when "first_name"
        page.enter_first_name @person['fullname']['fname']
        @browser.send_keys :tab
      when "last_name"
        page.enter_last_name @person['fullname']['lname']
        @browser.send_keys :tab
      when "phone_number"
        page.enter_phone_number @person['phone']
    end
  end
end


And(/^I validate the error message "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    expect(page.txt_field_err_validation).to include arg
  end
end

When(/^user enters the details for the following combination:$/) do |table|
  @details = table.hashes.first
  on(CheckoutPage) do |page|
    case @details['delivery_type']
      when "HD"
        page.hd
        page.enter_hd_first_name @person['fullname']['fname']
        @browser.send_keys :tab
        expect(page.txt_field_err_validation).to include @details['error_message']
        page.enter_hd_last_name @person['fullname']['lname']
        @browser.send_keys :tab
        expect(page.txt_field_err_validation).to include @details['error_message']
        page.enter_hd_country @person['country_value']
        if page.is_full_form_hd_open
          page.click_full_form_hd
        end
        case @person['country_value']
          when 'AU', 'NZ', 'ZA', 'US'
            page.enter_hd_add_1 @person["#{@details['address']}"]['address1']
            @browser.send_keys :tab
            expect(page.txt_field_err_validation).to include @details['error_message']
            page.enter_hd_city @person["#{@details['address']}"]['city']
            @browser.send_keys :tab
            expect(page.txt_field_err_validation).to include @details['error_message']
            page.enter_hd_state @person["#{@details['address']}"]['state_abb']
            page.enter_hd_pc @person["#{@details['address']}"]['postcode']
        end
    end
  end
end

When(/^user enters the following payment information:$/) do |table|
  @user_payment_details = table.hashes.first
    case @user_payment_details['payment_type']
      when "credit_card"
        on(CheckoutPage) do |page|
          page.click_cc
          if !(page.cc_bill_add_block_present?)
            page.check_cc_use_billing_address
          end
          page.enter_cc_billing_fname @person['fullname']['fname']
          @browser.send_keys :tab
          expect(page.txt_field_err_validation).to include @user_payment_details['error_message']
          page.enter_cc_billing_lname @person['fullname']['lname']
          @browser.send_keys :tab
          expect(page.txt_field_err_validation).to include @user_payment_details['error_message']
          page.set_cc_billing_country @person['country_value']
          page.click_full_form_cc
          page.enter_cc_billing_address1 @person['house']['address1']
          @browser.send_keys :tab
          expect(page.txt_field_err_validation).to include @user_payment_details['error_message']
          page.enter_cc_billing_city @person['house']['city']
          @browser.send_keys :tab
          expect(page.txt_field_err_validation).to include @user_payment_details['error_message']
        end
      end
end

And(/^the customer removes the perks voucher from Checkout Page$/) do |table|
  on(CheckoutPage) do |page|
    @remove_voucher_list = table.hashes
    @remove_voucher_list.each {|data|
      page.remove_voucher data['voucher_id']
    }
    page.wait_for_ajax
  end
end

And(/^the user hits on the Continue to Payment button on the Checkout page$/) do
  on(CheckoutPage).cc_place_order
end

And(/^I see the following nonpersonalised products in Checkout page$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    on(CheckoutPage) do |page|
      expect(page.check_copage_line_item @sku).to be(true)
      expect(page.check_copage_line_item_sku @sku,@qty).to be(true)
    end
  end
end

And(/^I see the following personalised products in Checkout page$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    on(CheckoutPage) do |page|
      expect(page.check_copage_line_item @sku).to be(true)
    end
  end
end

Then(/^I see that the default delivery is "([^"]*)" on Checkout page$/) do |arg|
  on(CheckoutPage) do |page|
    case arg
      when "Home Delivery"
        page.is_hd_checked
    end
  end
end

When(/^I select "([^"]*)" on the checkout page$/) do |arg|
  on(CheckoutPage) do |page|
    case arg
      when 'CNC'
        page.cnc
        #Defect CO-3104 forces us to click on CNC twice
        page.cnc
      else
        "You gave me #{arg} -- I have no idea what to do with that."
    end
  end
end

When(/^user navigates to "([^"]*)" page$/) do |arg|
  on(GeoPage) do |page|
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ arg)
    sleep 2
    # page.wait_for_ajax
  end
end

And(/^I validate Checkout page:$/) do |table|
  table.hashes.each do |row|
    on(CheckoutPage) do |page|
      if row['To'] != nil
        expect(page.get_giftbag_to_txt).to include row['To']
      end
      if row['From'] != nil
        expect(page.get_giftbag_from_txt).to include row['From']
      end
      if row['gift_bag_items'] != nil
        expect(page.get_giftbag_items_txt).to include row['gift_bag_items']
      end
      if row['title_of_giftwrap_section'] != nil
        expect(page.get_giftwrap_section_text).to include row['title_of_giftwrap_section']
      end
      if row['giftwrap_section_text'] != nil
        on(MybagPage) do |page|
          expect((page.gift_card_text).to_s == row['giftwrap_section_text']).to be(true)
        end
      end
    end
  end
end

And(/^the user navigates away from the email field$/) do
  @browser.send_keys :tab
end

Then(/^the perks section is displayed on Checkout page$/) do |table|
  expect(on(CheckoutPage).perks_header_text table.hashes[0].keys[0]).to eq table.hashes[0].values[0]
  expect(on(CheckoutPage).calculated_points).to include table.hashes[1].values[0] if table.hashes[1].keys[0] == 'perks_member_section'
  expect(on(CheckoutPage).calculated_points).to include table.hashes[2].values[0] if table.hashes[1].keys[0] == 'perks_member_section'
  expect(on(CheckoutPage).perks_description_text).to eq table.hashes[1].values[0] if table.hashes[1].keys[0] == 'nonperks_member_section'
  expect(on(CheckoutPage).perks_sub_description_text).to eq table.hashes[2].values[0] if table.hashes[1].keys[0] == 'nonperks_member_section'
end

# And(/^the "([^"]*)" button is displayed on Perks section$/) do |arg|
#   expect(on(CheckoutPage).signup_to_perks_present).to be_truthy
# end

And(/^"(.*)" link is displayed on Perks section$/) do |arg|
  expect(on(CheckoutPage).already_perks_member_present).to be_truthy
end


# And(/^the user clicks "([^"]*)" button$/) do |arg|
#   on(CheckoutPage).signup_to_perks
# end

And(/^the "([^"]*)" checkbox is selected by default$/) do |arg|
  expect(on(CheckoutPage).perks_checkbox_status).to be_truthy
end

And(/^the "([^"]*)" checkbox gets selected$/) do |arg|
  expect(on(CheckoutPage).perks_checkbox_status).to be_truthy
end

And(/^user selects the join perks checkbox$/) do
  on(CheckoutPage).select_join_perks
end

And(/^the user selects the preferences "([^"]*)"$/) do |arg1|
  on(CheckoutPage).select_brands
end

And(/^in BM the loyalty subscription data for "(.*)" has correct email, interests and brands$/) do |arg|
  loyalty_sub_json_guest = '{"email":"cottononqa+monica@gmail.com","first_name":"Monica","last_name":"Belluci","date_of_birth":null,"gender":null,"interests":["CategoryStationery"],"brands":["BrandTypo"]}'
  loyalty_sub_json_registered = '{"email":"cottononqa+jessica@gmail.com","first_name":"Jessica","last_name":"Alba","date_of_birth":null,"gender":null,"interests":["CategoryStationery"],"brands":["BrandTypo"]}'
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
    page.click_order_attributes
    expect(page.get_loyalty_sub_data).to eq loyalty_sub_json_guest if arg == 'Monica'
    expect(page.get_loyalty_sub_data).to eq loyalty_sub_json_registered if arg == 'Jessica'
  end
end

When(/^the user clicks "([^"]*)" link$/) do |arg|
  on(CheckoutPage).already_perks_member
end

Then(/^the message "([^"]*)" appears$/) do |arg|
  expect(on(CheckoutPage).perks_already_member_messaage).to eq arg
end

When(/^the user fills in details for a home delivery order$/) do
  on(CheckoutPage) do |page|
    case @type_of_user
      when 'guest'
        page.hd
        page.enter_hd_first_name @person['fullname']['fname']
        page.enter_hd_last_name @person['fullname']['lname']
        page.enter_hd_country @person['country_value']
        if page.is_full_form_hd_open
          page.click_full_form_hd
        end
      # to handle cases where state is a text field as opposed to a drop down
        case @person['country_value']
        when 'AU', 'NZ', 'ZA', 'US'
          page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state_abb'],  @person['house']['postcode']
        when 'GB', 'JP'
          page.enter_uk_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'],  @person['house']['postcode']
        end
        page.enter_hd_phone_number @person['phone']
        page.uncheck_save_del_add
      when 'registered'
        page.enter_hd_country @person['country_value']
        if !(page.saved_address_dropdown_present?)
          if page.is_full_form_hd_open
            page.click_full_form_hd
          end
          case @person['country_value']
            when 'AU', 'NZ', 'ZA', 'US'
              page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state_abb'],  @person['house']['postcode']
            when 'GB', 'JP'
              page.enter_uk_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'],  @person['house']['postcode']
          end
          page.enter_hd_phone_number @person['phone']
          page.uncheck_save_del_add
        end
    end
    page.click_cc
    if !(page.same_add_cc_billing_checked?)
      page.check_cc_use_billing_address
    end
    if page.auth_to_leave_present?
      page.select_auth_to_leave 'Leave out of the weather'
    end
  end
end

When(/^"([^"]*)" user fills in details for "([^"]*)" delivery$/) do |user_type, del_type|
  on(CheckoutPage) do |page|
    case user_type
      when 'guest'
        page.enter_email @person['email_info']['email_address']
        page.enter_first_name @person['fullname']['fname']
        page.enter_last_name @person['fullname']['lname']
        page.enter_phone_number @person['phone']
    end
    case del_type
      when 'home'
        if user_type == 'guest'
          page.hd
          page.enter_hd_first_name @person['fullname']['fname']
          page.enter_hd_last_name @person['fullname']['lname']
          page.enter_hd_country @person['country_value']
          if page.is_full_form_hd_open
            page.click_full_form_hd
          end
        end
        if user_type == 'registered'
          if !(page.saved_address_dropdown_present?)
            page.hd
            page.enter_hd_first_name @person['fullname']['fname']
            page.enter_hd_last_name @person['fullname']['lname']
            page.enter_hd_country @person['country_value']
            page.enter_hd_phone_number @person['phone']
            if page.is_full_form_hd_open
              page.click_full_form_hd
            end
            page.uncheck_save_del_add
          end
        end
        if !(page.saved_address_dropdown_present?)
          case @person['country_value']
            when 'AU', 'NZ', 'ZA', 'US', 'SG'
              page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state_abb'],  @person['house']['postcode']
            when 'GB', 'JP'
              page.enter_uk_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'],  @person['house']['postcode']
            when 'MY'
              page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'], @person['house']['postcode']
            end
        end
        if (page.auth_to_leave_present? && @person['country_value'] == 'AU')
          page.select_auth_to_leave 'Leave out of the weather'
        end
    when 'cnc'
        page.cnc
        page.cnc
        page.enter_first_name @person['fullname']['fname']
        page.enter_last_name @person['fullname']['lname']
        page.enter_phone_number @person['phone']
        page.find_my_store @person['store_postcode']
        page.store_search_button
        # page.click_store @person['store_id']
        @cnc_store_value = page.select_cnc_store_co_pg @person['store_id']
        @status = (@cnc_store_value == "store-details select-checkbox active")
        if @status == 'false'
          # page.click_store @person['store_id']
          page.select_cnc_store_co_pg @person['store_id']
        else
        end
        sleep 2
        @order_total_checkout_page = page.order_summary_total
    end
  end
end

When(/^"([^"]*)" user fills in details for "([^"]*)" delivery on checkout page$/) do |user_type, del_type|
  on(CheckoutPage) do |page|
    case user_type
    when 'guest'
      page.enter_email @person['email_info']['email_address']
      page.enter_first_name @person['fullname']['fname']
      page.enter_last_name @person['fullname']['lname']
      page.enter_phone_number @person['phone']
    end
    case del_type
    when 'home'
      if user_type == 'guest'
        page.hd
        page.enter_hd_first_name @person['fullname']['fname']
        page.enter_hd_last_name @person['fullname']['lname']
        page.enter_hd_country @person['country_value']
        if page.is_full_form_hd_open
          page.click_full_form_hd
        end
      end
      if user_type == 'registered'
        if !(page.saved_address_dropdown_present?)
          page.hd
          page.enter_hd_first_name @person['fullname']['fname']
          page.enter_hd_last_name @person['fullname']['lname']
          page.enter_hd_country @person['country_value']
          page.enter_hd_phone_number @person['phone']
          if page.is_full_form_hd_open
            page.click_full_form_hd
          end
          page.uncheck_save_del_add
        end
      end
      if !(page.saved_address_dropdown_present?)
        case @person['country_value']
        when 'AU', 'NZ', 'ZA', 'US'
          page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state_abb'],  @person['house']['postcode']
        when 'GB', 'JP'
          page.enter_uk_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'],  @person['house']['postcode']
        when 'MY'
          page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'], @person['house']['postcode']
        end
      end
      if (page.auth_to_leave_present? && @person['country_value'] == 'AU')
        page.select_auth_to_leave 'Leave out of the weather'
      end
    when 'cnc'
      page.cnc
      page.cnc
      page.enter_first_name @person['fullname']['fname']
      page.enter_last_name @person['fullname']['lname']
      page.enter_phone_number @person['phone']
      page.find_my_store @person['store_postcode']
      page.store_search_button
      page.select_cnc_store_co_pg @person['store_id']
      sleep 2
      @order_total_checkout_page = page.order_summary_total
    end
  end
end

And(/^"(.*)" user fills in billing address details for "([^"]*)"$/) do |user_type, pay_type|
  on(CheckoutPage) do |page|
    case pay_type
    when 'adyen_valid_creditcard'
      if !(page.cc_bill_add_block_present?)
        page.check_cc_use_billing_address
      end
      # case @country
      # when 'AU'
      if (@person['country_value'] == 'AU')
        #to_do remove sleep at a later stage
        sleep 2
        if !(page.saved_cc_billing_address_container_present?)
          page.click_full_form_cc
        end
      end
      # when 'NZ', 'SA', 'US'
      if (@person['country_value']) == 'NZ' || (@person['country_value']) == 'SA' || (@person['country_value']) == 'US' || (@person['country_value']) == 'SG'
        if !(page.saved_cc_billing_address_container_present?)
          page.set_cc_billing_country @person['country_value']
          page.click_full_form_cc
        end
      end
      if (@person['country_value'] != 'GB')
        case user_type
        when 'guest'
          page.enter_cc_billing_fname @person['fullname']['fname']
          page.enter_cc_billing_lname @person['fullname']['lname']
        end
        if !(page.saved_cc_billing_address_container_present?)
          page.enter_cc_billing_fname @person['fullname']['fname']
          page.enter_cc_billing_lname @person['fullname']['lname']
          page.enter_cc_billing_address1 @person['house']['address1']
          page.enter_cc_billing_city @person['house']['city']
          page.select_cc_billing_state (@person['house']['state_abb'].to_s)
          page.enter_cc_billing_postcode @person['house']['postcode']
        end
      else
        if !(page.saved_cc_billing_address_container_present?)
          page.enter_uk_hd_delivery_address @person['house']['address1'], @person['house']['city'], (@person['house']['state']), @person['house']['postcode']
        end
      end
      case user_type
      when 'registered'
        if !(page.saved_cc_billing_address_container_present?)
          page.enter_cc_adyen_phone @person['phone']
          page.uncheck_add_to_addressbook
        end
      end
    when 'afterpay'
      page.click_afterpay_tab
      if page.same_add_afterpay_billing_checked?
        page.same_add_afterpay_billing_uncheck
      end
      if !(page.saved_afterpay_billing_address_container_present?)
        page.enter_afterpay_billing_fname @person['fullname']['fname']
        page.enter_afterpay_billing_lname @person['fullname']['lname']
        page.set_afterpay_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_afterpay
        page.enter_afterpay_billing_address1 @person['house']['address1']
        page.enter_afterpay_billing_city @person['house']['city']
        page.select_afterpay_billing_state(@person['house']['state'])
        page.enter_afterpay_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_afterpay
          page.enter_afterpay_phone @person['phone']
        end
      end
    when 'cod'
      page.click_cash_on_delivery_tab
    when 'zip'
      page.click_zip_tab
      if page.same_add_zip_billing_checked?
        sleep 2
        page.same_add_zip_billing_uncheck
      end
      if !(page.saved_zip_billing_address_container_present?)
        page.enter_zip_billing_fname @person['fullname']['fname']
        page.enter_zip_billing_lname @person['fullname']['lname']
        page.set_zip_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_zip
        page.enter_zip_billing_address1 @person['house']['address1']
        page.enter_zip_billing_city @person['house']['city']
        page.select_zip_billing_state(@person['house']['state'])
        page.enter_zip_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_zip
          page.enter_zip_phone @person['phone']
        end
      end
    when 'quadpay'
      page.click_quadpay_tab
      sleep 2
      page.same_add_quadpay_billing_uncheck
      if !(page.saved_quadpay_billing_address_container_present?)
        page.enter_quadpay_billing_fname @person['fullname']['fname']
        page.enter_quadpay_billing_lname @person['fullname']['lname']
        page.set_quadpay_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_quadpay
        page.enter_quadpay_billing_address1 @person['house']['address1']
        page.enter_quadpay_billing_city @person['house']['city']
        page.select_quadpay_billing_state(@person['house']['state'])
        page.enter_quadpay_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_quadpay
          page.enter_quadpay_phone @person['phone']
        end
      end
    when 'laybuy'
      page.click_laybuy_tab
      if page.same_add_laybuy_billing_checked?
        sleep 2
        page.same_add_laybuy_billing_uncheck
      end
      if !(page.saved_laybuy_billing_address_container_present?)
        page.enter_laybuy_billing_fname @person['fullname']['fname']
        page.enter_laybuy_billing_lname @person['fullname']['lname']
        page.set_laybuy_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_laybuy
        page.enter_laybuy_billing_address1 @person['house']['address1']
        page.enter_laybuy_billing_city @person['house']['city']
        page.select_laybuy_billing_state(@person['house']['state'])
        page.enter_laybuy_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_laybuy
          page.enter_laybuy_phone @person['phone']
        end
      end
    when 'latpay'
      page.click_latpay_tab
      if page.same_add_latpay_billing_checked?
        sleep 2
        page.same_add_latpay_billing_uncheck
      end
      if !(page.saved_latpay_billing_address_container_present?)
        page.enter_latpay_billing_fname @person['fullname']['fname']
        page.enter_latpay_billing_lname @person['fullname']['lname']
        page.set_latpay_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_latpay
        page.enter_latpay_billing_address1 @person['house']['address1']
        page.enter_latpay_billing_city @person['house']['city']
        page.select_latpay_billing_state(@person['house']['state'])
        page.enter_latpay_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_latpay
          page.enter_latpay_phone @person['phone']
        end
      end
    when 'payflex'
      page.click_payflex_tab
      sleep 2
      if page.same_add_payflex_billing_checked?
        sleep 2
        page.same_add_payflex_billing_uncheck
      end
      if !(page.saved_payflex_billing_address_container_present?)
        page.enter_payflex_billing_fname @person['fullname']['fname']
        page.enter_payflex_billing_lname @person['fullname']['lname']
        page.set_payflex_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.enter_payflex_billing_address1 @person['house']['address1']
        page.enter_payflex_billing_city @person['house']['city']
        page.select_payflex_billing_state(@person['house']['state'])
        page.enter_payflex_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_payflex
          page.enter_payflex_phone @person['phone']
        end
      end
    when 'klarna'
      page.click_klarna_tab
      sleep 2
      if page.same_add_klarna_billing_checked?
        sleep 2
        page.same_add_klarna_billing_uncheck
      end
      if !(page.saved_klarna_billing_address_container_present?)
        page.enter_klarna_billing_fname @person['fullname']['fname']
        page.enter_klarna_billing_lname @person['fullname']['lname']
        page.set_klarna_billing_country @person['country_value']
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_klarna
        page.enter_klarna_billing_address1 @person['house']['address1']
        page.enter_klarna_billing_city @person['house']['city']
        page.select_klarna_billing_state(@person['house']['state'])
        page.enter_klarna_billing_postcode @person['house']['postcode']
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_klarna
          page.enter_klarna_phone @person['phone']
        end
      end
    end
  end
end

And(/^the user clicks on "([^"]*)" link$/) do |arg|
  on(CheckoutPage).my_account
end

And(/^clicking on How are my points calculated link reveals text "(.*)"$/) do |arg|
  on(CheckoutPage).how_points_calculated
  expect(on(CheckoutPage).point_pop_up_box).to include arg
end


And(/^clicking on How are my points calculated link reveals text$/) do |table|
  # table is a table.hashes.keys # => [:line]
  on(CheckoutPage).how_points_calculated
  expect(on(CheckoutPage).point_pop_up_box).to include table.hashes[0]['line']
  expect(on(CheckoutPage).point_pop_up_box).to include table.hashes[1]['line']
end

And(/^clicking again on How are my points calculated link hides the text$/) do
  on(CheckoutPage).how_points_calculated
  expect(on(CheckoutPage).is_point_pop_up_box_visible).to be_falsey
end

And(/^the Join CottonOn & Co\. Perks section has content$/) do |table|
  expect(on(CheckoutPage).perks_subscribe_box_content).to include table.hashes[0]['line']
  expect(on(CheckoutPage).perks_subscribe_box_content).to include table.hashes[1]['line']
  expect(on(CheckoutPage).perks_subscribe_box_content).to include table.hashes[2]['line']
  expect(on(CheckoutPage).perks_subscribe_box_content).to include table.hashes[3]['line']
  expect(on(CheckoutPage).perks_subscribe_box_content).to include table.hashes[4]['line']
end

And(/^the user applies gift cards$/) do |table|
  on(CheckoutPage) do |page|
    @applied_gift_cards = []
    page.expand_giftcard_textbox
    table.hashes.each {|data|
      @applied_gift_cards << data['gift_card_no']
      page.gift_card_no = data['gift_card_no']
      page.gift_card_pin = data['pin']
      page.apply_gift_card
      page.wait_for_ajax
    }
  end
end

Then(/^the gift card is applied under gift card section and the amount taken as$/) do |table|
  # table is a table.hashes.keys # => [:gift_card_no, :amount_taken]
  @order_balance_remaining = on(CheckoutPage).order_balance_amount.gsub(/[^.0-9\-]/,"")
  index = 0
  table.hashes.each {|data|
    expect(on(CheckoutPage).applied_gift_card index).to eq data['gift_card_no']
    expect(on(CheckoutPage).amount_taken_gift_card index).to include data['amount_taken']
    expect(on(CheckoutPage).amount_taken_gift_card index).to include data['amount_left'] unless data['amount_left'] == 0
    index = index+1
  }
end

And(/^the payment tabs are hidden$/) do
  on(CheckoutPage) do |page|
    expect(page.is_cc_visible).to be_falsey
    expect(page.is_paypal_visible).to be_falsey
    expect(page.is_afterpay_visible).to be_falsey
  end
end

And(/^the payment tabs are visible$/) do
  on(CheckoutPage) do |page|
    expect(page.is_cc_visible).to be_truthy
    expect(page.is_paypal_visible).to be_truthy
    expect(page.is_afterpay_visible).to be_truthy
  end
end

And(/^the order balance remaining is "(.*)"$/) do |arg|
  @order_balance_remaining = on(CheckoutPage).order_balance_amount.gsub(/[^.0-9\-]/,"")
  expect(on(CheckoutPage).order_balance_amount).to include arg
end

Then(/^the gift card section displays the error "([^"]*)"$/) do |arg|
  expect(on(CheckoutPage).gift_card_error_message).to eq arg
end

And(/^clicking on Add another card link takes the focus to gift card text field$/) do
  on(CheckoutPage).add_another_gift_card
  expect(on(CheckoutPage).verify_gift_card_focus).to be_truthy
end

And(/^Add another gift card link is "(.*)"$/) do |arg|
  expect(on(CheckoutPage).add_another_gift_card_visible).to be_falsey if arg == "hidden"
  expect(on(CheckoutPage).add_another_gift_card_visible).to be_truthy if arg == "visible"

end

And(/^the user removes gift cards$/) do |table|
  table.hashes.each {|data|
    on(CheckoutPage) do |page|
      page.remove_gift_card data['gift_card_no']
      page.wait_for_ajax
    end
  }
end

Then(/^the giftcard box is expanded$/) do
  expect(on(CheckoutPage).gift_card_box_expanded).to be_truthy
end

And(/^the user places order with only gift cards$/) do
  on(CheckoutPage) do |page|
    page.place_order_gift_card
  end

end

Then(/^Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    @order_number = page.find_dw_order_number
    expect(page.order_confirmation_text).to include (page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include (@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']).to_s,(@person['phone']).to_s,(@person['house']['postcode']).to_s
  end
end

And(/^user changes the delivery method to "([^"]*)"(.*)$/) do |arg1, arg2|
  on(CheckoutPage) do |page|
    page.wait_for_ajax
    page.select_delivery_method arg1
    page.wait_for_ajax
  end
end

And(/^the gift card is automatically dropped from checkout page$/) do |table|
  on(CheckoutPage) do |page|
    page.wait_for_ajax
    table.hashes.each do |data|
      expect(page.is_giftcard_present data['gift_card_no']).to be_falsey
    end
  end
end


Then(/^the user is presented with the error message "([^"]*)" on the checkout global overlay$/) do |arg|
  on(CheckoutPage) do |page|
    expect(page.err_msg_checkout).to eq arg
  end
end

And(/^the perks voucher section is hidden$/) do
  #expect(on(CheckoutPage).is_perks_section_visible?).to be_falsey
  expect(on(CheckoutPage).present_perks_voucher_box?).to be_falsey
end

And(/^I fill all the order details from "order_details.yml" file$/) do
  on(CheckoutPage) do |page|
    page.hd
    if Orderinfo.get_orderinfo['user_type'] == 'reg_without_saved_add'
      page.enter_email 'cottononqa+testorderutilnsa@gmail.com'
      page.click_sign_in_here
      page.enter_pass 'Cottonon123'
      page.sign_me_btn
      page.enter_hd_country Orderinfo.get_orderinfo['country']
      if page.is_full_form_hd_open
        page.click_full_form_hd
      end
      page.populate_check_out_page_with_data
      page.uncheck_add_to_addressbook
    elsif Orderinfo.get_orderinfo['user_type'] == 'reg_with_saved_add'
      case Orderinfo.get_orderinfo['site']
      when 'au'
        page.enter_email 'cottononqa+testorderutilAU@gmail.com'
      when 'nz'
        page.enter_email 'cottononqa+testorderutilNZ@gmail.com'
      when 'us'
        page.enter_email 'cottononqa+testorderutilUS@gmail.com'
      end
      page.click_sign_in_here
      page.enter_pass 'Cottonon123'
      page.sign_me_btn
    elsif Orderinfo.get_orderinfo['user_type'] == 'guest'
      page.enter_hd_country Orderinfo.get_orderinfo['country']
      if page.is_full_form_hd_open
        page.click_full_form_hd
      end
      page.populate_check_out_page_with_data
    end
    if (page.auth_to_leave_present? && @site_country.to_s == 'au')
      page.auth_to_leave_list="Leave out of the weather"
    end
    if !(page.same_add_billing_checked?)
      page.check_use_billing_address
    end
    begin
      case Orderinfo.get_orderinfo['payment_type']
      when 'afterpay'
        page.click_afterpay_tab
      when 'creditcard'
        page.click_cc
      when 'paypal'
        page.click_paypal_tab
      end
    end
  end
  if @vouchers_checkout.length != 0
    on(CheckoutPage) do |page|
      page.expand_perks_section
      @vouchers_checkout.each {|voucher|
        page.enter_voucher voucher
        page.click_apply_voucher_btn
        page.wait_for_ajax
      }
    end
  end
  on(CheckoutPage) do |page|
    page.expand_giftcard_textbox
    index = 0
    @gift_card_nos.length.times do
      page.gift_card_no = @gift_card_nos[index]
      page.gift_card_pin = @gift_card_pins[index]
      page.apply_gift_card
      page.wait_for_ajax
      index = index+1
    end
  end
end

And(/^I place the order$/) do
  on(CheckoutPage) do |page|
    if (page.is_cc_visible == false && page.is_paypal_visible == false && page.is_afterpay_visible == false) then
     page.place_order
    else
      begin
        case  Orderinfo.get_orderinfo['payment_type']
        when 'creditcard'
          page.place_order
          page.enter_adyen_valid_cc_details 'adyen_valid_creditcard' '4444 3333 2222 1111', "Nav Han", "03", "2030", "737"
          page.uncheck_saved_card_adyen
          page.place_order_adyen
        when 'paypal'
          page.click_paypal_button
          on(PaypalPage) do |page|
            page.paypal_login 'testsideconnectionmaster+cogaubuyer@gmail.com', 'Cotton01'
            page.paypal_spinner_visible?
            page.click_continue_to_paypal if @site_country != 'au'
            page.click_continue_paypal_store
          end
        when 'afterpay'
          page.click_afterpay_tab
          page.place_order
          on(AfterpayPopup_Page) do |page|
            begin
              case @site_country
              when 'au'
                page.afterpay_login 'lohit.kotian@cottonon.com.au', 'Pleasedontgo28!'
              when 'nz'
                page.afterpay_login 'autotest@email.com', 'Pleasedontgo28!'
              when 'us'
                page.afterpay_login 'autotest@email.com', 'Pleasedontgo28!'
              end
            end
            page.afterpay_due_today_check
            page.enter_cvc_afterpay_page
            page.check_over_eighteen_checkbox
            page.place_order_afterpay
          end
        end
      end
    end
  end
end


Then(/^I see the thank you page$/) do
  on(ThankyouPage) do |page|
    expect(page.is_Thankyou_page_displayed?).to be(true)
    page.browser.cookies.clear
    page.execute_script("javascript:localStorage.clear();")
    case  Orderinfo.get_orderinfo['payment_type']
      when 'paypal'
        on(PaypalPage) do |page|
          page.navigate_to "https://www.sandbox.paypal.com"
          page.paypal_sign_out
        end
     end
  end
end

When(/^the error message text on "([^"]*)" tab is:$/) do |arg, table|
  table.hashes.each do |row|
    @err_msg = row['error_msg']
    case arg
      when 'afterpay'
        on(CheckoutPage) do |page|
          page.err_msg_afterpay_tab
          expect(page.err_msg_afterpay_tab).to eq @err_msg
        end
    end
  end
end

Then(/^the customer sees the error message "([^"]*)" below the voucher input box on Checkout page$/) do |arg|
  expect(on(CheckoutPage).perks_error_message_co).to eq arg
end

Then(/^user changes to the address "([^"]*)" from the saved addresses$/) do |int|
  on(CheckoutPage) do |page|
    page.click_address_deliver_to int
  end
end


And(/^the "([^"]*)" is displayed on Checkout page below Cash On Delivery payment method$/) do |arg, table|
  on(CheckoutPage) do |page|
    table.hashes.each {|data|
      case arg
      when 'message'
        expect(page.cod_tab_message).to include data['message']
      when 'error message'
        expect(page.cod_error_message).to include data['error_message']
      end
    }
   end
end

And(/^clicking on Find out more link reveals text$/) do |table|
  # table is a table.hashes.keys # => [:line]
  on(CheckoutPage).how_points_calculated
  expect(on(CheckoutPage).point_pop_up_box).to include table.hashes[0]['line']
  expect(on(CheckoutPage).point_pop_up_box).to include table.hashes[1]['line']
end

And(/^clicking again on Find out more link hides the text$/) do
  on(CheckoutPage).how_points_calculated
  expect(on(CheckoutPage).is_point_pop_up_box_visible).to be_falsey
end


When(/^"([^"]*)" user fills in contact details$/) do |user_type|
  on(CheckoutPage) do |page|
    case user_type
      when 'registered'
        if !(page.saved_address_dropdown_present?)
          page.enter_first_name @person['fullname']['fname']
          page.enter_last_name @person['fullname']['lname']
          page.enter_phone_number @person['phone']
        end
      end
    end
  end

Then(/^zip Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    page.order_confirm_mesage_visible?
    @order_number = page.find_dw_order_number
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['phone'].to_s),(@person['house']['postcode'].to_s))
  end
end

And(/^"([^"]*)" delivery address is shown on the zip Thankyou page$/) do |arg|
  case arg
  when 'HD'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['house']['postcode'].to_s))
    end
  when 'CNC'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']), (@person['fullname']['lname']),(@person['store_address']),(@person['store_city']), (@person['store_postcode'].to_s))
      expect(page.confirm_delivery_method).to include('Click & Collect')
    end
  end
end

When(/^"([^"]*)" user fills in details for "([^"]*)" international delivery address$/) do |user_type, country|
  on(CheckoutPage) do |page|
    case user_type
    when 'guest'
      page.enter_email @person['email_info']['email_address']
      page.enter_first_name @person['fullname']['fname']
      page.enter_last_name @person['fullname']['lname']
      page.enter_phone_number @person['phone']
    end
    if user_type == 'guest'
      page.hd
      page.enter_hd_first_name @person['fullname']['fname']
      page.enter_hd_last_name @person['fullname']['lname']
      page.enter_hd_country country
      if page.is_full_form_hd_open
        page.click_full_form_hd
      end
    end
    if user_type == 'registered'
      if !(page.saved_address_dropdown_present?)
        page.hd
        page.enter_hd_first_name @person['fullname']['fname']
        page.enter_hd_last_name @person['fullname']['lname']
        page.enter_hd_country country
        page.enter_hd_phone_number @person['phone']
        if page.is_full_form_hd_open
          page.click_full_form_hd
        end
        page.uncheck_save_del_add
      end
    end
    if !(page.saved_address_dropdown_present?)
      case country
      when 'US'
        page.enter_hd_delivery_address '13 California Ave', 'Bakersfield', 'CA',  '93304'
      when 'GB'
        page.enter_uk_hd_delivery_address '10 downing street', 'london', '' , 'SW1A 2AA'
      when 'AU'
        page.enter_hd_delivery_address '11 Waldburg Grove', 'Tarneit', 'VIC',  '3029'
      end
    end
    if (page.auth_to_leave_present? && @person['country_value'] == 'AU')
      page.select_auth_to_leave 'Leave out of the weather'
    end
  end
end

And(/^user sees the global error message:$/) do |table|
  table.hashes.each {|data|
  on(CheckoutPage) do |page|
    expect((page.error_msg_checkout) == data['error_message']).to be_truthy
  end
  }
end

And(/^"([^"]*)" user fills in billing details for "([^"]*)" with "([^"]*)" international address$/) do |user_type, pay_type, country|
  on(CheckoutPage) do |page|
    case pay_type
    when 'zip'
      page.click_zip_tab
      if page.same_add_zip_billing_checked?
        sleep 2
        page.same_add_zip_billing_uncheck
      end
      if !(page.saved_zip_billing_address_container_present?)
        page.enter_zip_billing_fname @person['fullname']['fname']
        page.enter_zip_billing_lname @person['fullname']['lname']
        if country == "US"
          page.set_zip_billing_country "US"
          Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          page.click_full_form_zip
          page.enter_zip_billing_address1 "13 California Ave"
          page.enter_zip_billing_city "Bakersfield"
          page.select_zip_billing_state "CA"
          page.enter_zip_billing_postcode "93304"
        end
      if user_type == 'registered'
        page.uncheck_add_to_addressbook_zip
        page.enter_zip_phone @person['phone']
      end
      end
    when 'quadpay'
      sleep 2
      page.same_add_quadpay_billing_uncheck
      if !(page.saved_quadpay_billing_address_container_present?)
        page.enter_quadpay_billing_fname @person['fullname']['fname']
        page.enter_quadpay_billing_lname @person['fullname']['lname']
        if country == "AU"
          page.set_quadpay_billing_country "AU"
          Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          page.click_full_form_quadpay
          page.enter_quadpay_billing_address1 "11 waldburg grove"
          page.enter_quadpay_billing_city "Tarneit"
          page.select_quadpay_billing_state "VIC"
          page.enter_quadpay_billing_postcode "3029"
        end
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_quadpay
          page.enter_quadpay_phone @person['phone']
        end
      end
    when 'laybuy'
      page.click_laybuy_tab
      if page.same_add_laybuy_billing_checked?
        sleep 2
        page.same_add_laybuy_billing_uncheck
      end
      if !(page.saved_laybuy_billing_address_container_present?)
        page.enter_laybuy_billing_fname @person['fullname']['fname']
        page.enter_laybuy_billing_lname @person['fullname']['lname']
        if country == "US"
          page.set_laybuy_billing_country "US"
          Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          page.click_full_form_laybuy
          page.enter_laybuy_billing_address1 "13 California Ave"
          page.enter_laybuy_billing_city "Bakersfield"
          page.select_laybuy_billing_state "CA"
          page.enter_laybuy_billing_postcode "93304"
        end
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_laybuy
          page.enter_laybuy_phone @person['phone']
        end
      end
    when 'latpay'
      page.click_latpay_tab
      if page.same_add_latpay_billing_checked?
        sleep 2
        page.same_add_latpay_billing_uncheck
      end
      if !(page.saved_latpay_billing_address_container_present?)
        page.enter_latpay_billing_fname @person['fullname']['fname']
        page.enter_latpay_billing_lname @person['fullname']['lname']
        if country == "US"
          page.set_latpay_billing_country "US"
          Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          page.click_full_form_latpay
          page.enter_latpay_billing_address1 "13 California Ave"
          page.enter_latpay_billing_city "Bakersfield"
          page.select_latpay_billing_state "CA"
          page.enter_latpay_billing_postcode "93304"
        end
        if user_type == 'registered'
          page.uncheck_add_to_addressbook_latpay
          page.enter_latpay_phone @person['phone']
        end
      end
    when 'genoapay'
      page.click_genoapay_tab
      if page.same_add_genoapay_billing_checked?
        sleep 2
        page.same_add_genoapay_billing_uncheck
      end
      page.enter_genoapay_billing_fname @person['fullname']['fname']
      page.enter_genoapay_billing_lname @person['fullname']['lname']
        if country == "US"
          page.set_genoapay_billing_country "US"
          Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          page.click_full_form_genoapay
          page.enter_genoapay_billing_address1 "13 California Ave"
          page.enter_genoapay_billing_city "Bakersfield"
          page.select_genoapay_billing_state "CA"
          page.enter_genoapay_billing_postcode "93304"
        end
    when 'humm'
      page.click_humm_tab
      if page.same_add_humm_billing_checked?
        sleep 2
        page.same_add_humm_billing_uncheck
      end
      page.enter_humm_billing_fname @person['fullname']['fname']
      page.enter_humm_billing_lname @person['fullname']['lname']
        if country == "US"
          page.set_humm_billing_country "US"
          Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
          page.click_full_form_humm
          page.enter_humm_billing_address1 "13 California Ave"
          page.enter_humm_billing_city "Bakersfield"
          page.select_humm_billing_state "CA"
          page.enter_humm_billing_postcode "93304"
        end
      if user_type == 'registered'
        page.uncheck_add_to_addressbook_humm
        page.enter_humm_phone @person['phone']
      end
    when 'klarna'
      page.click_klarna_tab
      if page.same_add_klarna_billing_checked?
        sleep 2
        page.same_add_klarna_billing_uncheck
      end
      page.enter_klarna_billing_fname @person['fullname']['fname']
      page.enter_klarna_billing_lname @person['fullname']['lname']
      if country == "AU"
        page.set_klarna_billing_country "AU"
        Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
        page.click_full_form_klarna
        page.enter_klarna_billing_address1 "11 Waldburg grove"
        page.enter_klarna_billing_city "Tarneit"
        page.select_klarna_billing_state "VIC"
        page.enter_klarna_billing_postcode "3029"
      end
      if user_type == 'registered'
        page.uncheck_add_to_addressbook_klarna
        page.enter_klarna_phone @person['phone']
      end
    end
  end
end

Then(/^laybuy Thankyou page is shown with details for the user$/) do
  on(ThankyouPage) do |page|
    page.order_confirm_mesage_visible?
    @order_number = page.find_dw_order_number
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['phone'].to_s),(@person['house']['postcode'].to_s))
  end
end

And(/^"([^"]*)" delivery address is shown on the "([^"]*)" Thankyou page$/) do |address_type, payment_type|
  case address_type
  when 'HD'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['house']['postcode'].to_s))
    end
  when 'CNC'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']), (@person['fullname']['lname']),(@person['store_address']),(@person['store_city']), (@person['store_postcode'].to_s))
      expect(page.confirm_delivery_method).to include('Click & Collect')
    end
  when 'International'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),("13 California Ave"),("Bakersfield"),("CA"),("93304"))
    end
  end
end

Then(/^"([^"]*)" payment method is not present on the checkout page$/) do |arg|
  on(CheckoutPage) do |page|
    case arg
    when 'laybuy'
      expect((page.laybuy_tab_presence).to_s == "false").to be_truthy
    when "zip"
      expect((page.zip_tab_presence).to_s == "false").to be_truthy
    when "latpay"
      expect((page.latpay_tab_presence).to_s == "false").to be_truthy
    when "humm"
      expect((page.humm_tab_presence).to_s == "false").to be_truthy
    end
  end
end

Then(/^laybuy Thankyou page is shown with details for the user with international billing address$/) do
  on(ThankyouPage) do |page|
    page.order_confirm_mesage_visible?
    @order_number = page.find_dw_order_number
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include("13 California Ave","Bakersfield","CA",(@person['phone'].to_s),"93304")
  end
end

Then(/^global error message for declined laybuy order is displayed on the CO page$/) do
  on(CheckoutPage) do |page|
    expect((page.global_err_msg_text) == "Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience!").to be_truthy
  end
end

Then(/^"([^"]*)" Thankyou page is shown with details for the user$/) do |arg|
  on(ThankyouPage) do |page|
    page.order_confirm_mesage_visible?
    @order_number = page.find_dw_order_number
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['phone'].to_s),(@person['house']['postcode'].to_s))
  end
end

And(/^"([^"]*)" delivery address is shown on the latpay Thankyou page$/) do |arg|
  case arg
  when 'HD'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['house']['postcode'].to_s))
    end
  when 'CNC'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']), (@person['fullname']['lname']),(@person['store_address']),(@person['store_city']), (@person['store_postcode'].to_s))
      expect(page.confirm_delivery_method).to include('Click & Collect')
    end
  end
end

And(/^on humm page user places an order with an existing user in "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    if arg == "AU"
      @payment_info = Payment.get_payment_info 'humm'
      page.humm_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    end
    if arg == "NZ"
      @payment_info = Payment.get_payment_info 'humm_nz'
      page.humm_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
    end
  end
end

And(/^on humm page user selects to go back to checkout "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    page.humm_click_back_to_CO
  end
end


And(/^I enter DOB under allowed age on Checkout page$/) do
  on(CheckoutPage) do |page|
    page.enter_DOB_under_age
  end
end

Then(/^the correct error message for DOB should be displayed$/) do
  on(CheckoutPage) do |page|
    expect(page.DOB_error_message =~ /US Privacy Laws prohibit anyone under 13yrs/).to be_truthy
  end
end

And(/^I validate "([^"]*)" text for qty "([^"]*)" on checkout page$/) do |arg1, arg2|
  on(CheckoutPage) do |page|
    case arg1
    when "Save RRP"
      if arg2 == "1"
        expect(page.save_rrp_text_CO == "Save$9.85off RRP").to be_truthy
      end
      if arg2 == "2"
        expect(page.save_rrp_text_CO == "Save$19.70off RRP").to be_truthy
      end
    when "Save Percent"
      if arg2 == "1"
        expect(page.save_rrp_text_CO == "Save13%off RRP").to be_truthy
      end
      if arg2 == "2"
        expect(page.save_rrp_text_CO == "Save13%off RRP").to be_truthy
      end
    end
  end
end

And(/^order total on checkout page "([^"]*)" promotion applied is "([^"]*)"$/) do |arg1, arg2|
  on(CheckoutPage) do |page|
    expect((page.order_summary_total) == arg2).to be_truthy
  end
end

When(/^promo or voucher is applied on the Checkout page$/) do |table|
  on(CheckoutPage) do |page|
    page.expand_perks_section
    @voucher_list = table.hashes
    @voucher_list.each {|data|
    sleep 2
    page.enter_voucher data['promos_vouchers']
    page.click_apply_voucher_btn
    page.wait_for_ajax
    }
  end
end

Then(/^the "([^"]*)" discount applied is "([^"]*)"$/) do |arg1, arg2|
  on(CheckoutPage) do |page|
    sleep 2
    expect((page.discount_line_item_CO) == arg2).to be(true)
  end
end

And(/^the product price "([^"]*)" product promotion applied is "([^"]*)"$/) do |arg1, arg2|
  on(CheckoutPage) do |page|
    expect(page.product_price_CO).to include arg2
  end
end

And(/^I remove the "([^"]*)" from CO page$/) do |arg, table|
  on(CheckoutPage) do |page|
    case arg
    when "vouchers"
      @remove_vouchers_list = table.hashes
      @remove_vouchers_list.each {|data|
      page.remove_voucher data['promos_vouchers']
      }
    when "promo codes"
      @remove_promos_list = table.hashes
      @remove_promos_list.each {|data|
      page.remove_promo_code data['promos_vouchers']
      }
    end
    page.wait_for_ajax
  end
end

Then(/^promo code and perks voucher section displays "([^"]*)" as:$/) do |arg, table|
    case arg
    when "vouchers"
      on(CheckoutPage) do |page|
        page.applied_vouchers
        expect(page.applied_vouchers).to include table.hashes[0].values[0]
      end
    when "promo codes"
      on(CheckoutPage) do |page|
        expect(page.applied_promos 0).to include table.hashes[0].values[0]
      end
    when "both"
      on(CheckoutPage) do |page|
        expect(page.applied_promos 0).to include table.hashes[0].values[0]
        expect(page.applied_promos 1).to include table.hashes[1].values[0]
      end
    end
  end

Then(/^I validate the selected delivery method:$/) do |table|
  # table is a table.hashes.keys # => [:Standard Shipping (US)USD 6.00FREE on orders over $55 - UPS SurePost]
      @delivery_method = table.hashes
      @delivery_method.each {|data|
        expect(on(CheckoutPage).delivery_type).to include data['selected_delivery_method']
      }
end

And(/^user clicks on bonus product message$/) do
  on(CheckoutPage).click_bonus_gift_msg
end

And(/^the customer sees the success message "([^"]*)" below the voucher input box on Checkout page$/) do |arg|
  expect(on(MybagPage).CO_success_message == arg)
end

And(/^the first installment amount for klarna is "([^"]*)" on "([^"]*)" site$/) do |amt, site|
  case site
  when "AU"
    expect(on(CheckoutPage).klarna_installment_amount == amt).to be(true)
  when "US"
    expect(on(CheckoutPage).klarna_installment_amount == amt).to be(true)
  when "GB"
    expect(on(CheckoutPage).klarna_installment_amount_GB == amt).to be(true)
  end
end

And(/^"([^"]*)" delivery address is shown on the klarna Thankyou page$/) do |arg|
  case arg
  when 'HD'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']),(@person['fullname']['lname']),(@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']),(@person['house']['postcode'].to_s))
    end
  when 'CNC'
    on(ThankyouPage) do |page|
      expect(page.confirm_delivery_address).to include((@person['fullname']['fname']), (@person['fullname']['lname']),(@person['store_address']),(@person['store_city']), (@person['store_postcode'].to_s))
      expect(page.confirm_delivery_method).to include('Click & Collect')
    end
  end
end

Then(/^klarna should not be available on CO page$/) do
  on(CheckoutPage) do |page|
    expect(page.klarna_tab_not_present).to_s == "false"
  end
end

When(/^"([^"]*)" user with "([^"]*)" delivery fills in details for a klarna declined order$/) do |user_type, del_type|
  on(CheckoutPage) do |page|
    case user_type
    when 'guest'
      page.enter_email "johnsmith+denied@gmail.com"
      page.enter_first_name @person['fullname']['fname']
      page.enter_last_name @person['fullname']['lname']
      page.enter_phone_number @person['phone']
    end
    case del_type
    when 'home'
      if user_type == 'guest'
        page.hd
        page.enter_hd_first_name @person['fullname']['fname']
        page.enter_hd_last_name @person['fullname']['lname']
        page.enter_hd_country @person['country_value']
        if page.is_full_form_hd_open
          page.click_full_form_hd
          page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state_abb'],  @person['house']['postcode']
        end
      end
    end
  end
end

And(/^the user clicks Continue to Payment button on the Checkout page of "([^"]*)" site for klarna$/) do |arg|
  on(CheckoutPage) do |page|
    if defined? @order_balance_remaining
      @order_total_checkout_page = @order_balance_remaining
    else
      @order_total_checkout_page = page.order_summary_total
    end
    case arg
    when "AU","US"
      page.get_order_total
      page.klarna_installment_amount
      page.klarna_place_order arg
    when "GB"  
      page.clear_phone_number
      page.enter_phone_number_gb('+' + @person['phone'].to_s)
      page.klarna_installment_amount_GB
      page.klarna_place_order arg
    end

  end
end

And(/^the "([^"]*)" checkbox is displayed on Perks section$/) do |arg|
  expect(on(CheckoutPage).join_perks_chkbx_present).to be_truthy
end

Then(/^on CO page user clicks edit button in summary section$/) do
  on(CheckoutPage) do |page|
    page.click_edit_CO_pg
  end
end

And(/^the user enters adyen details for "([^"]*)" for single page checkout form$/) do |arg|
  on(CheckoutPage) do |page|
    if defined? @order_balance_remaining
      @order_total_checkout_page = @order_balance_remaining
    else
      @order_total_checkout_page = page.order_summary_total
    end
    if arg == "Credit Card"
      begin
        case @pay_type
        when 'adyen_valid_creditcard'
          page.enter_spc_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], (@person["#{@pay_type}"]['exp_date'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s), (@person['fullname']['fname'] +" "+ @person['fullname']['lname'])
        when 'adyen_invalid_creditcard'
          page.enter_spc_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], ((@person["#{@pay_type}"]['exp_date']).to_s), (@person["#{@pay_type}"]['sec_code'].to_s), ("#{@hpp_card_name}" +" "+ @person['fullname']['lname'])
        when 'adyen_invalid_cvc_creditcard'
          page.enter_spc_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], (@person["#{@pay_type}"]['exp_date'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s), (@person['fullname']['fname'] +" "+ @person['fullname']['lname'])
        when 'adyen_3DS_valid_creditcard'
          page.enter_spc_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], (@person["#{@pay_type}"]['exp_date'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s), (@person['fullname']['fname'] +" "+ @person['fullname']['lname'])
        when 'adyen_3DS_invalid_creditcard'
          page.enter_spc_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], ((@person["#{@pay_type}"]['exp_date']).to_s), (@person["#{@pay_type}"]['sec_code'].to_s), ("#{@hpp_card_name}" +" "+ @person['fullname']['lname'])
        when 'adyen_3DS_invalid_error'
          page.enter_spc_adyen_valid_cc_details @person["#{@pay_type}"]['cc_number'], ((@person["#{@pay_type}"]['exp_date']).to_s), (@person["#{@pay_type}"]['sec_code'].to_s), (@hpp_card_name +" "+ @person['fullname']['lname'])
        end
      end
    end
  end
end

And(/^the user places order on the Checkout page for "([^"]*)"$/) do |arg|
  on(CheckoutPage) do |page|
    case arg
    when 'Credit Card'
     @order_total_checkout_page = page.order_summary_total_spc
      page.cc_place_order
    when 'Saving Credit Card'
      page.select_save_card_chkbx
      page.cc_place_order
    end
  end
end

Then(/^Adyen Thankyou page is shown for the SPC with details for the user$/) do
  on(ThankyouPage) do |page|
    @order_number = page.find_dw_order_number
    on(Utility_Functions) do |page|
      expect(page.return_browser_url).to include 'checkout/complete'
    end
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house']['address1']),(@person['house']['city']),(@person['house']['state_abb']).to_s,(@person['phone']).to_s,(@person['house']['postcode']).to_s)
  end
end


Then (/^"([^"]*)" error message is displayed for the "([^"]*)" order as "([^"]*)"$/) do |error_type,order_type, error_message|
  on(CheckoutPage) do |page|
    case order_type
    when 'HD'
      expect((page.is_hd_checked).to_s == ("true")).to be(true)
    when 'CNC'
      expect((page.is_cnc_checked).to_s == ("true")).to be(true)
    end
    expect(page.error_msg_checkout).to include error_message
  end
end

Then(/^based on the (.*), error message is displayed for the "([^"]*)" order$/) do |response_codes, order_type|
  on(CheckoutPage) do |page|
    case order_type
    when 'HD'
      expect((page.is_hd_checked).to_s == ("true")).to be(true)
    when 'CNC'
      expect((page.is_cnc_checked).to_s == ("true")).to be(true)
    end
    if @pay_type == "adyen_invalid_creditcard"
      begin
      case response_codes
      when 'ERROR' || 'UNKNOWN'
        expect((page.error_msg_checkout).to_s).to include('Sorry there has been a problem with your payment and your order could not be placed (Acquirer Error). Please check your details or try a different payment method if the problem persists.')
      when 'BLOCK_CARD'
        expect((page.error_msg_checkout).to_s).to include("Sorry there has been a problem with your payment and your order could not be placed (Blocked Card). Please check your details or try a different payment method if the problem persists.")
      when 'DECLINED'
        expect((page.error_msg_checkout).to_s).to include("Sorry there has been a problem with your payment and your order could not be placed (Refused). Please check your details or try a different payment method if the problem persists.")
      when 'CANCELLED'
        expect((page.error_msg_checkout).to_s).to include("Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience! (Cancelled)")
      when 'CARD_EXPIRED'
        expect((page.error_msg_checkout).to_s).to include("Sorry there has been a problem with your payment and your order could not be placed (Expired Card). Please check your details or try a different payment method if the problem persists.")
      when 'REFERRAL'
        expect((page.error_msg_checkout).to_s).to include("Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience! (Referral)")
      when 'NOT_3D_AUTHENTICATED'
        expect((page.error_msg_checkout).to_s).to include("Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience! (3D Not Authenticated)")
      when 'NOT_ENOUGH_BALANCE'
        expect((page.error_msg_checkout).to_s).to include("Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience! (Not enough balance)")
      when 'NOT_SUPPORTED'
        expect((page.error_msg_checkout).to_s).to include("Your order could not be submitted. Please review your payment settings and try again. Thank you for your patience! (Not supported)")
      end
      end
    end
    if @pay_type == "adyen_3DS_invalid_creditcard"
      begin
      case response_codes
      when 'ERROR' || 'UNKNOWN'
        expect((page.error_msg_checkout).to_s).to include('Sorry there has been a problem with your payment and your order could not be placed (Acquirer Error). Please check your details or try a different payment method if the problem persists.')
      when 'DECLINED'
        expect((page.error_msg_checkout).to_s).to include("Sorry there has been a problem with your payment and your order could not be placed (Refused). Please check your details or try a different payment method if the problem persists.")
      end
      end
    end
  end
end


And(/^on 3DS page user enters the password as "([^"]*)"$/) do |arg|
  on(Utility_Functions) do |page|
    sleep 5
    expect(page.return_browser_url).to include 'Adyen-Authorize3DS2'
  end
  on(CheckoutPage) do |page|
    page.enter_3DS_password arg
    page.click_submit_3DS_page
  end
end

And(/^on 3DS page user clicks browser back$/) do
  on(CheckoutPage) do |page|
    page.hit_browser_back_btn
  end
end

And(/^user is redirected to refused single page checkout url$/) do
  on(Utility_Functions) do |page|
    sleep 5
    expect(page.return_browser_url).to include 'checkout/Submit'
  end
end

And(/^user selects the saved card ending with "([^"]*)" on single page checkout form$/) do |arg|
  on(CheckoutPage) do |page|
    if defined? @order_balance_remaining
      @order_total_checkout_page = @order_balance_remaining
    else
      @order_total_checkout_page = page.order_summary_total
    end
    page.select_saved_credit_card arg
    page.enter_saved_card_cvc @person["#{@pay_type}"]['sec_code'].to_s
  end
end


When(/^user changes to the address "([^"]*)" from the saved delivery addresses for single page checkout$/) do |arg|
  on(CheckoutPage) do |page|
    page.select_delivery_address arg
  end
end

Then(/^Adyen Thankyou page is shown for the SPC with "([^"]*)" details for the user$/) do |arg|
  on(ThankyouPage) do |page|
    @order_number = page.find_dw_order_number
    on(Utility_Functions) do |page|
      expect(page.return_browser_url).to include 'COCheckout-ShowConfirmationAdyen'
    end
    expect(page.order_confirmation_text).to include(page.assert_transaction_id)
    expect(page.billing_address_conf_page).to include((@person['house 2']['address2']),(@person['house 2']['city']),(@person['house 2']['state_abb']).to_s,(@person['phone']).to_s,(@person['house 2']['postcode']).to_s)
  end
end


When(/^registered user fills in details for home delivery by adding new address$/) do
  on(CheckoutPage) do |page|
      page.add_new_address
      page.enter_hd_first_name @person['fullname']['fname']
      page.enter_hd_last_name @person['fullname']['lname']
      page.enter_hd_country @person['country_value']
      page.enter_hd_phone_number @person['phone']
      if page.is_full_form_hd_open
        page.click_full_form_hd
      end
      page.uncheck_save_del_add
    case @person['country_value']
    when 'AU', 'NZ', 'ZA', 'US', 'SG'
      page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state_abb'],  @person['house']['postcode']
    when 'GB', 'JP'
      page.enter_uk_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'],  @person['house']['postcode']
    when 'MY'
      page.enter_hd_delivery_address @person['house']['address1'], @person['house']['city'], @person['house']['state'], @person['house']['postcode']
    end
    if (page.auth_to_leave_present? && @person['country_value'] == 'AU')
      page.select_auth_to_leave 'Leave out of the weather'
    end
  end
end

And(/^user adds a new card on single page checkout form$/) do
  on(CheckoutPage) do |page|
    if defined? @order_balance_remaining
      @order_total_checkout_page = @order_balance_remaining
    else
      @order_total_checkout_page = page.order_summary_total
    end
    page.add_new_card
    page.enter_spc_adyen_valid_new_cc_details @person["#{@pay_type}"]['cc_number'], (@person["#{@pay_type}"]['exp_date'].to_s), (@person["#{@pay_type}"]['sec_code'].to_s), (@person['fullname']['fname'] +" "+ @person['fullname']['lname'])
  end
end

And(/^"([^"]*)" user selects same as shipping checkbox for billing address$/) do |arg|
  on(CheckoutPage) do |page|
    page.select_cc_use_billing_address
  end
end

And(/^user deletes the saved card ending with "([^"]*)" on single page checkout form$/) do |arg|
  on(CheckoutPage) do |page|
    page.select_saved_credit_card arg
    page.click_delete_card
  end
end

# And(/^on Afterpay page user places an order on "([^"]*)" site$/) do |arg|
#   on(AfterpayPopup_Page) do |page|
#     if arg = "AU"
#     @payment_info = Payment.get_payment_info 'afterpay'
#     page.afterpay_login @payment_info[@country]['user_email'], @payment_info[@country]['password']
#     page.afterpay_due_today_check
#     @afterpay_order_total = page.validate_afterpay_page
#     expect((page.validate_afterpay_page).to_f).to eq(@order_total_checkout_page.to_f);
#     page.enter_cvc_afterpay_page
#     page.check_over_eighteen_checkbox
#     page.place_order_afterpay
#     sleep 5
#   end
# end