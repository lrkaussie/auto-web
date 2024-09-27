require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'
require 'addressable/uri'


class BusinessManagerPage
  include PageObject
  include Utilities
  include DataMagic

  element(:customers_bm, :css => ".overview_subtitle[href*='customers']")
  element(:customers, :css => ".overview_subtitle[href*='ViewCustomers-List']")
  element(:advanced_tab_customers, :class => "switch_link", :index => 1)
  text_field(:customer_email, :name =>'WFCustomerAdvancedSearch_Email')
  element(:find_customer, :name => "parametricSearch", :index => 1)
  element(:customer_list, :css => ".aldi p")
  checkbox(:select_customer, :css => "[type='checkbox'][name='DeleteCustomer']")
  button(:delete_customer, :css => ".button[name='confirmDelete']")
  button(:delete_customer_ok,   :css => ".button[name='delete']")
  a(:registered_email, :css => ".table_detail_link", :index => 1)
  element(:bm_order_attributes, :css => "[href*='attributes']")
  element(:loyalty_sub_data, :css =>".table_detail .inputfield_en[type='text']", :index => 3)
  table(:payment_method_details, :css => '.infobox_item.top table', :index => 0)
  element(:order_confirmation_status, :xpath => '//*[@id="bm_content_column"]/table/tbody/tr/td/table/tbody/tr/td[2]/table[2]/tbody/tr/td/form/table[2]/tbody/tr[12]/td[4]')
  element(:order_shipping_status, :xpath => '//*[@id="bm_content_column"]/table/tbody/tr/td/table/tbody/tr/td[2]/table[2]/tbody/tr/td/form/table[2]/tbody/tr[14]/td[2]')
  element(:order_export_status, :xpath => '//*[@id="bm_content_column"]/table/tbody/tr/td/table/tbody/tr/td[2]/table[2]/tbody/tr/td/form/table[2]/tbody/tr[14]/td[4]')
  element(:orders_advanced, :css => '#C > form > table > tbody > tr:nth-child(1) > td.infobox_item_search > a:nth-child(2)')
  element(:order_general_clicked, :css => '#bm_content_column > table > tbody > tr > td > table > tbody > tr > td:nth-of-type(2) > table:nth-of-type(1) > tbody')
  element(:product_info_table, :css => "form[name='main'][method='post'] tbody", :index => 2)

  # text_field(:bm_username, :name => 'LoginForm_Login')
  text_field(:bm_username, :id => 'idToken1')
  element(:login_button, :id => "loginButton_0")
  # text_field(:bm_password, :name => 'LoginForm_Password')
  text_field(:bm_password, :id => 'idToken2')
  button(:bm_login_btn, :name => 'login')
  span(:bm_site_dd, :css => '.sod_select')
  element(:nz_dd, :class => 'table_detail_link', :index => 3)
  element(:rsa_dd, :class => 'table_detail_link', :index => 7)
  element(:au_dd,  :class => 'table_detail_link', :index => 0)
  element(:supre_au_dd, :class => 'table_detail_link', :index => 9)
  element(:us_dd, :class => 'table_detail_link', :index => 6)
  element(:my_dd,  :class => 'table_detail_link', :index => 2)
  element(:uk_dd, :class => 'table_detail_link', :index => 5)
  element(:sg_dd, :class => 'table_detail_link', :index => 4)
  a(:merchant_tools, :css => ".merchant-tools-link")
  element(:tools_ordering, :css => ".overview_subtitle[title='Manage the orders of this site.'] a")
  element(:ordering_orders, :css => ".overview_subtitle[title='Manage orders.'] a")
  text_field(:orders_ordernum, :name => 'OrderSearchForm2_SimpleSearchTerm')
  button(:orders_find_btn, :id => 'searchFocus')
  element(:order_result, :css => "a.table_detail_link")
  elements(:order_result_cust_name, :css => "td.table_detail.n")
  a(:order_general, :css => "[href*='general']")
  element(:order_gen_text, :css => '.infobox')
  element(:phone_number, :css => "td.s.top.infobox_item", :index => 0)
  element(:adj_price, :css => '#bm_content_column > table > tbody > tr > td > table > tbody > tr > td:nth-of-type(2) > table:nth-of-type(2) > tbody > tr > td > form > table:nth-of-type(3) > tbody > tr:nth-of-type(8) > td:nth-of-type(2)')
  element(:payment_tab, :css => "[href*='payment']")
  element(:pay_method_text, :class => 'infobox_item top s', :index => 0)
  element(:payment_tab_invoice, :class => "infobox_item top", :index => 3)
  element(:notes_tab, :css => "[href*='notes']")
  element(:adyen_pay_info_failed_txt, :css => 'tbody tr .table_detail.s', :index => 2)
  element(:adyen_spc_3DS, :css => 'tbody tr .table_detail.s', :index => 5)
  a(:bm_logout_btn, :css => ".headermenu[title='Log off.']")
  a(:attribute_tab, :css => "[href*='attributes']")
  element(:benefit_amount_field, :css => '.inputfield_en', :index => 5)
  button(:log_in_without_linking, :name=> "skipMerge", :index => 0)
  button(:acc_manager_login, :name => "loginSSO", :index => 0 )


  a(:products_and_catalog, :css => "[title='Manage catalogs and products of this site.'] .overview_subtitle")
  a(:products, :css => "[title='Manage products.'] .overview_subtitle")
  text_field(:product_id_input_field, :css => "[name='WFSimpleSearch_NameOrID']")
  button(:products_find_btn, :css => "[name='findSimple']")
  a(:product_result, :css => "[nowrap='nowrap'] a.table_detail_link")
  a(:inventory_tab, :css => "td [href*='ViewProductInventory']")
  span(:in_stock_row, :css => ".simpleGo")
  checkbox(:perpetual_checkbox, :css=> "#perpetual[type='checkbox']")
  button(:apply_stock_change_button, :css => "[name='update']")
  span(:not_available_row, :css => ".simpleStop.bold")
  a(:administration_link, :css => ".admin-link")
  a(:sites_link, :css => "[title='Manage sites.'] .overview_subtitle")
  a(:manage_site_link, :css => "[title='Manage the sites of this organization.'] .overview_subtitle")
  element(:cache_tab, :css => ".table_tabs_dis_background" , :index => 1)
  button(:invalidate_entire_site, :css => "#staticCacheRoot[value='Invalidate ']")
  button(:invalidate_entire_page, :css => "#pageCacheRoot[value='Invalidate ']")
  cells(:specific_site_inventory_row, :css => ".left.table_detail4")
  element(:zip_declined_status, :css => "td.table_detail.s", :index => 2)
  element(:order_confirm, :css => "td.table_detail [checked='checked'][value='true']", :index => 0)
  element(:personalised_order_confirm, :css => "td.table_detail [checked='checked'][value='true']", :index => 1)

  def goto_bm url
    @browser.goto url
  end

  def enter_username_bm username
    wait_and_set_text bm_username_element,username
    wait_and_click login_button_element
  end

  def enter_password_bm password
    wait_and_set_text bm_password_element,password
    wait_and_click login_button_element
  end

  def click_login_btn_bm
    wait_and_click bm_login_btn_element
  end

  def click_login_without_linking_btn_bm
    wait_and_click log_in_without_linking_element if log_in_without_linking_element.present?
  end

  def click_dd_site_bm
    wait_and_click bm_site_dd_element
  end

  def select_nz_dd_bm
    wait_and_click nz_dd_element
  end

  def select_rsa_dd_bm
    wait_and_click rsa_dd_element
  end


  def select_au_dd_bm
    wait_and_click au_dd_element
  end

  def select_au_supre_dd_bm
    wait_and_click supre_au_dd_element
  end

  def select_us_dd_bm
    wait_and_click us_dd_element
  end

  def select_my_dd_bm
    wait_and_click my_dd_element
  end

  def select_uk_dd_bm
    wait_and_click uk_dd_element
  end

  def select_sg_dd_bm
    wait_and_click sg_dd_element
  end

  def select_merchant_tools
    wait_and_click merchant_tools_element
  end

  def select_ordering_bm
    wait_and_click tools_ordering_element
  end

  def select_orders_bm
    wait_and_click ordering_orders_element
  end

  def orders_select_advanced_tab
    wait_and_click orders_advanced_element
  end

  def enter_order_num_bm order_num
    wait_and_set_text orders_ordernum_element, order_num
  end

  def find_orders_btn_bm
    wait_and_click orders_find_btn_element
  end

  def click_order_result_bm
    wait_and_click order_result_element
  end

  def cust_name_order_result_field cust_name
    order_result_cust_name_elements.find{|e| e.attribute_value('innerHTML').include? cust_name}
  end

  def order_gen_tab
    wait_and_click order_general_element
  end

  def order_gen_tab_text
    @order_general_text = wait_and_get_text order_gen_text_element
    @order_general_text = @order_general_text.gsub(/[\n\t\u00A0]/,"")
    return @order_general_text
  end

  def get_phone_number
    wait_and_get_text phone_number_element
  end

  def order_all_status
    return order_gen_text_element.text
  end

  def adj_order_price(arg)
    return adj_price_element.when_present.text.gsub(/[-A$]/,"")
  end

  def click_payment_tab
    wait_and_click payment_tab_element
  end

  def pay_method_text
    @payment_method_text = wait_and_get_text(pay_method_text_element)
    @payment_method_text = @payment_method_text.gsub(/[\n\t\u00A0]/,"")
    return @payment_method_text
  end

  def click_notes_tab
    wait_and_click notes_tab_element
  end

  def adyen_pay_info_failed
    @adyen_payment_failed_text = wait_and_get_text adyen_pay_info_failed_txt_element
    return @adyen_payment_failed_text
  end

  def adyen_3DS_info
    @adyen_payment_3DS_text = wait_and_get_text adyen_spc_3DS_element
    return @adyen_payment_3DS_text
  end

  def bm_logout
    wait_and_click bm_logout_btn_element
  end

  def delete_cc_user bm_url,email,bmusername,bmpassword,country,site
    goto_bm bm_url
    wait_and_click(acc_manager_login_element)
    wait_and_set_text bm_username_element,bmusername
    wait_and_click login_button_element
    wait_and_set_text bm_password_element,bmpassword
    wait_and_click login_button_element
    # enter_username_bm bmusername
    # enter_password_bm bmpassword
    # click_login_btn_bm
    # click_login_without_linking_btn_bm
    click_dd_site_bm
    select_merchant_tools
    case country
    when 'SA'
      select_rsa_dd_bm
    when 'US'
      select_us_dd_bm
    when 'NZ'
      select_nz_dd_bm
    when 'AU'
      if site == 'SUPRE'
        select_au_supre_dd_bm
      else
        select_au_dd_bm
      end
    when 'MY'
      select_my_dd_bm
    when 'UK'
      select_uk_dd_bm
    end
    customers_bm_element.when_present.click
    customers_element.when_present.click
    advanced_tab_customers_element.when_present.click
    customer_email_element.when_present.set(email)
    find_customer_element.when_present.focus
    find_customer_element.click
    return if (customer_list_element.present? && customer_list_element.attribute_value("innerText") == 'Your search didn\'t match any customers.')
    select_customer_element.when_present.focus
    select_customer_element.click
    delete_customer_element.when_present.focus
    delete_customer_element.click
    delete_customer_ok_element.when_present.focus
    delete_customer_ok_element.click
  end

  def verify_cc_user bm_url,email,bmusername,bmpassword,country,site
    goto_bm bm_url
    wait_and_click(acc_manager_login_element)
    wait_and_set_text bm_username_element,bmusername
    wait_and_click login_button_element
    wait_and_set_text bm_password_element,bmpassword
    wait_and_click login_button_element
    # enter_username_bm bmusername
    # enter_password_bm bmpassword
    # click_login_btn_bm
    # click_login_without_linking_btn_bm
    click_dd_site_bm
    select_merchant_tools
    case country
    when 'SA'
      select_rsa_dd_bm
    when 'US'
      select_us_dd_bm
    when 'NZ'
      select_nz_dd_bm
    when 'AU'
      if site == 'SUPRE'
        select_au_supre_dd_bm
      else
        select_au_dd_bm
      end
    when 'MY'
      select_my_dd_bm
    when 'UK'
      select_uk_dd_bm
    end
    customers_bm_element.when_present.click
    customers_element.when_present.click
    advanced_tab_customers_element.when_present.click
    customer_email_element.when_present.set(email)
    find_customer_element.when_present.focus
    find_customer_element.click
    return registered_email_element.attribute_value("innerText").strip
  end

  def click_order_attributes
    bm_order_attributes_element.click
  end

  def get_loyalty_sub_data
    begin
      retries ||= 0
      return loyalty_sub_data_element.attribute_value("value")
    rescue NoMethodError
      retry if (retries += 1) < $code_retry
    end
  end

  def get_prod_name_txt
    return wait_and_get_text product_info_table_element
  end

  def check_gift_card_number
    #return payment_method_details_element.attribute_value("innerText")
    return wait_and_get_text payment_method_details_element
  end


  def click_attributes_tab
    attribute_tab_element.click
  end

  def benefit_amount
   return benefit_amount_field_element.attribute_value("value")
  end

  def click_products_and_catalogs_link_bm
    wait_and_click products_and_catalog_element
  end

  def click_products_link_bm
    wait_and_click products_element
  end

  def enter_product_sku_id_bm sku
    wait_and_set_text product_id_input_field_element, sku
  end

  def find_products_btn_bm
    wait_and_click products_find_btn_element
  end

  def click_product_result_bm
    wait_and_click product_result_element
  end

  def click_inventory_tab_bm
    wait_and_click inventory_tab_element
  end

  def click_edit_link_bm
    specific_site_inventory_row_elements.find{|x| x.attribute_value("innerText") =~ /assigned to site/}.parent.button(:name => 'reset').click
  end

  def unselect_perpetual_checkbox_bm
    wait_and_click perpetual_checkbox_element if perpetual_checkbox_element.checked?
  end

  def select_perpetual_checkbox_bm
   wait_and_click perpetual_checkbox_element if !(perpetual_checkbox_element.checked?)
  end

  def click_apply_btn_bm
    wait_and_click apply_stock_change_button_element
  end

  def invalidate_cache_bm
    wait_and_click administration_link_element
    wait_and_click sites_link_element
    wait_and_click manage_site_link_element
    select_my_dd_bm
    wait_and_click cache_tab_element
    wait_for_ajax
    wait_and_click invalidate_entire_site_element
    wait_for_ajax
    wait_and_click invalidate_entire_page_element
  end

  def arr_pay_method_text
    @payment_method_text_initial = wait_and_get_text pay_method_text_element
    @payment_method_text1 = @payment_method_text_initial.gsub(/#{" "}/,'')
    @payment_method_text2 = @payment_method_text1.gsub(/#{"\n"}/,',')
    @payment_method_text3 = @payment_method_text2.gsub(/#{",,"}/,',')
    @payment_method_text4 = @payment_method_text3.gsub(/#{"Transaction:"}/,'')
    @payment_method_text5 = @payment_method_text4.gsub(/#{"ZipReceiptNumber:"}/,'')
    @payment_method_text_final = @payment_method_text5.split(',')
    return @payment_method_text_final
  end

  def zip_declined_status
    wait_and_get_text(zip_declined_status_element)
  end

  def zip_declined_status_presence
    zip_declined_status_element.present?
  end

  def laybuy_invoice_text_presence
   return !payment_tab_invoice_element.text.empty?
  end

  def laybuy_order_att_presence
    order_confirm_element.present?
  end

  def latpay_invoice_text_presence
    return !payment_tab_invoice_element.text.empty?
  end

  def latpay_order_att_presence
    order_confirm_element.present?
  end

  def latpay_personalised_order_att_presence
    personalised_order_confirm_element.present?
  end

  def humm_invoice_text_presence
    return !payment_tab_invoice_element.text.empty?
  end

  def humm_order_att_presence
    order_confirm_element.present?
  end

  def click_log_in_with_AM
    wait_and_click(acc_manager_login_element)
  end

end
