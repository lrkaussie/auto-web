And(/^in BM last order for "([^"]*)" is:$/) do |arg, table|
  @data = table.hashes.first
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
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
      when 'SG'
        page.select_sg_dd_bm
    end
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@failed_order_number}" if defined? @failed_order_number
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    # page.wait_for_ajax
    sleep 5
    # expect(page.cust_name_order_result_field arg).to be_truthy
    page.click_order_result_bm
      if @data['order_status'] != nil
        @data['order_status'] =  (@data['order_status'].downcase).capitalize
        expect(page.order_gen_tab_text).to include @data['order_status']
      end
      if @data['product_name'] != nil
        expect(page.get_prod_name_txt).to include @data['product_name']
      end
    page.click_payment_tab
      if @data['adyen_status'] != nil
        expect(page.pay_method_text).to include @data['adyen_status']
      end
      if @data['eventcode'] != nil
        expect(page.pay_method_text).to include @data['eventcode']
      end
      if (@data['order_status'] != 'Open')
        expect(page.pay_method_text).to include @data['authResult']
      end
      if @data['payment_method'] != nil
        expect(page.pay_method_text).to include @data['payment_method']
      end
      if @data['order_amount'] != nil
        expect(page.pay_method_text).to include @data['order_amount']
      end
    page.click_notes_tab
      if (@data['order_status'] != 'Open')
        expect(page.adyen_pay_info_failed).to include @data['authResult']
      end
    if (@data['authResult_3DS'] != nil)
      expect(page.adyen_pay_info_failed).to include @data['authResult_3DS']
    end
      if (@data['3ds'] != nil)
        expect(page.adyen_pay_info_failed).to include @data['3ds']
      end
      if @data['3ds_status'] != nil
        expect((page.adyen_3DS_info).to_s).to include @data['3ds_status']
      end
    page.click_attributes_tab
      if @data['sms_opt_in'] != nil
        case @data['sms_opt_in']
        when '"sms_opt_in":true'
          expect(page.get_loyalty_sub_data).to include @data['sms_opt_in']
        when 'false'
          expect(((page.get_loyalty_sub_data).include?'sms_opt_in').to_s == @data['sms_opt_in']).to be_truthy
        end
      end
      if @data['phone_number_validation'] != nil
        expect(((page.get_loyalty_sub_data).include?(@person['phone'].to_s).to_s) == @data['phone_number_validation']).to be_truthy
      end
      if @data['mobile_number_validation'] != nil
        case @mobile_number
        when nil,""
          expect((((page.get_loyalty_sub_data).include?"phone_no").to_s) == @data['mobile_number_validation']).to be_truthy
        else
          @number = @mobile_number.gsub(' ','')
          expect((((page.get_loyalty_sub_data).include?@number).to_s) == @data['mobile_number_validation']).to be_truthy
        end
      end
      if @data['benefit_amount'] != nil
        expect(page.benefit_amount).to eq @data['benefit_amount']
      end
    page.bm_logout
  end
end

And(/^in BM the order of "(.*)" has attributes$/) do |arg, table|
  @data = table.hashes.first
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
    @data['order_status'] =  (@data['order_status'].downcase).capitalize
    expect(page.order_gen_tab_text).to include @data['order_status']
    expect(page.order_all_status).to include @data['confirmation_status']
    expect(page.order_all_status).to include @data['export_status']
    expect(page.order_all_status).to include @data['shipping_ststus']
    page.bm_logout
  end
end

And(/^the payment section in BM shows the applied gift cards$/) do
  @applied_gift_cards.each do |applied_gift_card|
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
      page.click_payment_tab
      expect(page.payment_method_details).to include applied_gift_card
      page.bm_logout
    end
  end
end


When(/^the inventory of the product is changed in the BM as below:$/) do |table|
  table.hashes.each do |row|
  @sku = row['sku']
  @inventory = row['inventory']
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
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
    page.click_products_and_catalogs_link_bm
    page.click_products_link_bm
    page.enter_product_sku_id_bm @sku
    page.find_products_btn_bm
    page.click_product_result_bm
    page.click_inventory_tab_bm
    page.click_edit_link_bm
    case @inventory
    when 'out_of_stock'
    page.unselect_perpetual_checkbox_bm
    when'in_stock'
    page.select_perpetual_checkbox_bm
    end
    page.click_apply_btn_bm
    page.invalidate_cache_bm
    page.bm_logout
  end
 end
end

And(/^in BM last zip order for "([^"]*)" is:$/) do |arg, table|
  @data = table.hashes.first
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
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
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@failed_order_number}" if defined? @failed_order_number
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    sleep 5
    page.click_order_result_bm
    if @data['zip_order_status'] != nil
      @data['zip_order_status'] =  (@data['zip_order_status'].downcase).capitalize
      expect(page.order_gen_tab_text).to include @data['zip_order_status']
    end
    page.click_payment_tab
    if @data['zip_processor'] != nil
      expect(page.pay_method_text).to include @data['zip_processor']
    end
    if @data['zip_transaction'] != nil
      expect(page.pay_method_text).to include @data['zip_transaction']
    end
    if @data['zip_receipt'] != nil
      expect(page.pay_method_text).to include @data['zip_receipt']
    end
    if @data['zip_receipt_trsct_same'] != nil
      @payment_array = page.arr_pay_method_text
      expect(@payment_array[2] == @payment_array[5]).to be(true)
    end
    if @data['zip_trsct_number_same'] != nil
      @payment_array = page.arr_pay_method_text
      expect(@payment_array[11] == @payment_array[14]).to be(true)
    end
    page.click_notes_tab
    if @data['zip_notes_status'] != nil
      if @data['zip_notes_status'] == "DECLINED"
        expect(page.zip_declined_status).to include "ZIP application declined"
      else
        expect(page.zip_declined_status_presence).to be_falsey
      end
    end
    page.click_attributes_tab
    page.bm_logout
  end
end

And(/^in BM last laybuy order for "([^"]*)" is:$/) do |arg, table|
  # table is a table.hashes.keys # => [:zip_order_status, :zip_processor, :zip_transaction, :zip_receipt, :zip_receipt_trsct_same]
  @data = table.hashes.first
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
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
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    sleep 5
    page.click_order_result_bm
    if @data['laybuy_order_status'] != nil
      @data['laybuy_order_status'] =  (@data['laybuy_order_status'].downcase).capitalize
      expect(page.order_gen_tab_text).to include @data['laybuy_order_status']
    end
    page.click_payment_tab
    if @data['laybuy_processor'] != nil
      expect(page.pay_method_text).to include @data['laybuy_processor']
    end
    if @data['laybuy_invoice'] != nil
      expect((page.laybuy_invoice_text_presence).to_s == @data['laybuy_invoice']).to be(true)
    end
    page.click_attributes_tab
    if @data['laybuy_order_true'] != nil
      expect((page.laybuy_order_att_presence).to_s == @data['laybuy_order_true']).to be(true)
    end
    page.bm_logout
  end
end

And(/^in BM last "([^"]*)" order for "([^"]*)" is:$/) do |payment_type, arg, table|
  @data = table.hashes.first
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
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
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    sleep 5
    page.click_order_result_bm
    if @data['latpay_order_status'] != nil
      @data['latpay_order_status'] =  (@data['latpay_order_status'].downcase).capitalize
      expect(page.order_gen_tab_text).to include @data['latpay_order_status']
    end
    if @data['genoapay_order_status'] != nil
      @data['genoapay_order_status'] =  (@data['genoapay_order_status'].downcase).capitalize
      expect(page.order_gen_tab_text).to include @data['genoapay_order_status']
    end
    page.click_payment_tab
    if @data['latpay_processor'] != nil
      expect(page.pay_method_text).to include @data['latpay_processor']
    end
    if @data['genoapay_processor'] != nil
      expect(page.pay_method_text).to include @data['genoapay_processor']
    end
    if @data['latpay_transaction'] != nil
      expect(page.pay_method_text).to include @order_number
    end
    if @data['latpay_invoice'] != nil
      expect((page.latpay_invoice_text_presence).to_s == @data['latpay_invoice']).to be(true)
    end
    if @data['genoapay_invoice'] != nil
      expect((page.latpay_invoice_text_presence).to_s == @data['genoapay_invoice']).to be(true)
    end
    page.click_attributes_tab
    if @data['latpay_order_true'] != nil
      expect((page.latpay_order_att_presence).to_s == @data['latpay_order_true']).to be(true)
    end
    if @data['latpay_personalised_order_true'] != nil
      expect((page.latpay_personalised_order_att_presence).to_s == @data['latpay_personalised_order_true']).to be(true)
    end
    if @data['genoapay_order_true'] != nil
      expect((page.latpay_order_att_presence).to_s == @data['genoapay_order_true']).to be(true)
    end
    page.bm_logout
  end
end

Then(/^in BM last humm order for "([^"]*)" is:$/) do |arg, table|
  # table is a table.hashes.keys # => [:humm_order_status, :humm_processor, :humm_invoice, :humm_order_true]
  @data = table.hashes.first
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
    case @country
    when 'AU'
      if @site == 'SUPRE'
        page.select_au_supre_dd_bm
      else
        page.select_au_dd_bm
      end
    when 'NZ'
      page.select_nz_dd_bm
    end
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    sleep 5
    page.click_order_result_bm
    if @data['humm_order_status'] != nil
      @data['humm_order_status'] =  (@data['humm_order_status'].downcase).capitalize
      expect(page.order_gen_tab_text).to include @data['humm_order_status']
    end
    page.click_payment_tab
    if @data['humm_processor'] != nil
      expect(page.pay_method_text).to include @data['humm_processor']
    end
    if @data['humm_transaction'] != nil
      expect(page.pay_method_text).to include @order_number
    end
    if @data['humm_invoice'] != nil
      expect((page.latpay_invoice_text_presence).to_s == @data['humm_invoice']).to be(true)
    end
    page.click_attributes_tab
    if @data['humm_order_true'] != nil
      expect((page.latpay_order_att_presence).to_s == @data['humm_order_true']).to be(true)
    end
    if @data['humm_personalised_order_true'] != nil
      expect((page.latpay_personalised_order_att_presence).to_s == @data['humm_personalised_order_true']).to be(true)
    end
    page.bm_logout
  end
  end


And(/^in BM last klarna order for "([^"]*)" is:$/) do |arg, table|
  # table is a table.hashes.keys # => [:klarna_order_status, :klarna_processor, :klarna_transaction, :klarna_fraud_status]
  @data = table.hashes.first
  on(BusinessManagerPage) do |page|
    page.goto_bm "#{@site_information['bm_url']}"
    page.click_log_in_with_AM
    page.enter_username_bm "#{@site_information['bm_username']}"
    page.enter_password_bm "#{@site_information['bm_password']}"
    # page.click_login_btn_bm
    # page.click_login_without_linking_btn_bm
    page.click_dd_site_bm
    page.select_merchant_tools
    case @country
    when 'US'
      page.select_us_dd_bm
    when 'AU'
        page.select_au_dd_bm
    when 'UK'
      page.select_uk_dd_bm
    end
    page.select_ordering_bm
    page.select_orders_bm
    page.enter_order_num_bm "#{@failed_order_number}" if defined? @failed_order_number
    page.enter_order_num_bm "#{@order_number}" if defined? @order_number
    page.find_orders_btn_bm
    sleep 5
    page.click_order_result_bm
    if @data['klarna_order_status'] != nil
      @data['klarna_order_status'] =  (@data['klarna_order_status'].downcase).capitalize
      expect(page.order_gen_tab_text).to include @data['klarna_order_status']
    end
    page.click_payment_tab
    if @data['klarna_processor'] != nil
      expect(page.pay_method_text).to include @data['klarna_processor']
    end
    if @data['klarna_transaction'] != nil
      expect(page.pay_method_text).to include @data['klarna_transaction']
    end
    if @data['klarna_fraud_status'] != nil
      expect(page.pay_method_text).to include @data['klarna_fraud_status']
    end
    page.bm_logout
  end
end
