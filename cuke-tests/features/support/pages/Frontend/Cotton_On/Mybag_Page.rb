require 'page-object'
require 'page-object/page_factory'
require_relative '../../../monkey_patch.rb'


class MybagPage
  include PageObject
  include Utilities

  list_items(:select_delivery_method, :css => "li.pointer")
  button(:dm_dd_title, :class => 'dropdown-title')
  unordered_list(:delivery_options, :css => '#primary > div > div:nth-child(2) > div.small-12.large-6.xlarge-4.xxlarge-3.column > div > div:nth-child(2) > div > ul')
  span(:order_tot,:class => 'order-total', :index => 0)
  element(:order_dis,:css => 'div.order-discount-row.row')
  div(:pro_sale_price_bef_disc,:css => ".big-product-price")
  a(:promo_code,:class => 'apply-promo-code')
  text_field(:promo_code_value, :id => 'promo-code')
  button(:apply_cpn_btn, :id => 'add-coupon')
  span(:pro_sale_price_aft_disc,:class => 'product-price-sales')
  select_list(:qty_dd,:css => '.input-select')
  elements(:product_line_items_in_bag, :name => /^dwfrm_cart_shipments/)
  div(:ship_msg_block, :css => ".free-shipping")
  div(:voucher_message, :class => 'success-message')
  div(:applied_coupons, :class => 'all-applied-coupons')
  spans(:voucher_remove_link, :class=>'remove-promo-code')
  div(:voucher_error_message, :class => 'error-response')
  div(:sticky_global_error, :class => 'error-message')
  buttons(:delete_coupon, :css => '.delete-promo-code')
  form(:bag_line_items, :css => "#cart-items-form")
  list_items(:del_meth, :css => "li[role='button']")
  span(:sel_del_method, :css => ".selected-delivery-method")
  div(:mybag_page_txt, :css => ".row.empty-cart-msg")
  button(:cont_shopping_link, :css => "[name='dwfrm_cart_continueShopping']")
  buttons(:add_to_wishlist , :class => 'wishlist-container')
  link(:wishlist_header_link, :class => "wishlist-link", :index => 0)
  div(:gift_bag_price, :css => ".giftbag-product-details .big-product-price")
  unordered_list(:avail_del_meth, :css => ".delivery-methods-cart")
  buttons(:checkout_now, :class =>'checkout-now-button')
  div(:get_rec_name, :css => ".gift-cert-to")
  div(:get_sender_name, :css => ".gift-cert-from")
  div(:get_sender_msg, :css => ".message")
  spans(:get_dsgn, :class => "product-name")
  divs(:product_line_item_link_in_mybag, :css => ".product-details" )
  buttons(:delete_egiftcard, :css=> "[name='deleteGiftCertificate']")
  # buttons(:remove_line_items, :name => /deleteProduct/)
  buttons(:remove_line_items, :css => "button.remove-container")
  div(:empty_cart_page, :css => '.empty-cart-msg')
  span(:move_to_wishlist, :css => ".moved-to-wishlist-message", :index => 1)
  spans(:vouchers_on_bag, :class => 'promo-code-item')
  links(:product_titles_on_mybag, :class => 'product-name')
  spans(:egift_card_product_titles_on_mybag, :class => 'product-name')
  a(:giftwrap_mybag_dd, :css => ".giftwrap-title")
  a(:create_more_giftwrap_btn, :css => ".giftwrap-start")
  span(:edit_giftwrap_btn, :css=> ".edit-giftbag-button-text")
  div(:my_bagtext, :css => ".bag-header.small-7")
  span(:title_return_section, :css=> "span.free-returns")
  span(:description_returns_section, :css=> ".free-retutns-wrapper div span", :index => 2)
  buttons(:remove_button, :class => "pointer remove-container")
  spans(:remove_giftwrap_line_items, :css=> "button.giftwrap-remove span.remove-button-text")
  divs(:remove_giftcard_line_items, :css => "div.gift-cert-remove-button-container")
  link(:my_initials_link, :class => "user-account", :index => 0)
  link(:my_account_link, :css => "a[title='Go to: My Details']", :index=> 0)
  element(:bnpl_logos_top_bag_pg, :css => "div.payment-methods-logos-top div.content-asset p", :index => 0)
  element(:zip_logo_top_bag_pg, :css => "div.payment-methods-logos-top [alt='Zip logo']", :index => 0)
  element(:afterpay_logo_top_bag_pg, :css => "div.payment-methods-logos-top [alt='Afterpay logo']", :index => 0)
  element(:bnpl_logos_bottom_bag_pg, :css => "div.payment-methods-logos-bottom p", :index => 0)
  element(:zip_logo_bottom_bag_pg, :css => "div.payment-methods-logos-bottom [alt='Zip logo']", :index => 0)
  element(:afterpay_logo_bottom_bag_pg, :css => "div.payment-methods-logos-bottom [alt='Afterpay logo']", :index => 0)
  div(:bnpl_top_tagline_bag_pg, :css => ".bnpl-message-top div.product-bnpl-message.cart-bnpl-message", :index => 0)
  div(:bnpl_bottom_tagline_bag_pg, :css => ".payment-box div.cart-bnpl-message.product-bnpl-message", :index => 0)
  div(:spinner_my_bag, :css => "div.fixed.loader[style='display: none;']", :index => 0)
  span(:multipack_save_text_mybag, :class => "multipack-container")
  div(:bonus_gift_heading, :css => "div.bonus-product-alert", :index => 0)
  button(:quick_add_gift_carousel, :class => "button swiper-quickadd bonus-product-quick-add", :index => 0)
  span(:gift_card_text, :class => "messagetext")

  def bag_checkout
    sleep 2
    begin
      retries ||= 0
      checkout_now_elements[2].click
    rescue NoMethodError
      browser.refresh
      retry if (retries += 1) < $code_retry
      #@browser.execute_script("document.getElementsByClassName('button action checkout-now-button')[1].click();")
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Selenium::WebDriver::Error::JavascriptError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    else
      @url = @browser.url
    end
  end

  def click_checkout
    sleep 2
    wait_for_ajax
    if !empty_cart_page_element.present?
      begin
        retries ||= 0
        checkout_now_elements[2].click
          #@browser.execute_script("document.getElementsByClassName('button action checkout-now-button')[1].click();")
      rescue Selenium::WebDriver::Error::UnknownError
        wait_for_ajax
        retry if (retries += 1) < $code_retry
      rescue Watir::Exception::UnknownObjectException
        wait_for_ajax
        retry if (retries += 1) < $code_retry
      end
    end
  end

  def click_delivery_methods_dd
    wait_for_ajax
    wait_and_click dm_dd_title_element
  end

  def select_delivery_method arg
    wait_for_ajax
    select_delivery_method_elements.find {|el| el.text =~ /#{arg}/}.click
    wait_for_ajax
  end

  def sel_del_method arg
    begin
      retries ||= 0
      @browser.execute_script("document.getElementsByClassName('row delivery-wrapper')[#{arg}].click();")
    rescue Selenium::WebDriver::Error::UnknownError
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      retry if (retries += 1) < $code_retry
    end
  end

  def order_total
    # wait_for_ajax
    @order_ttl = wait_and_get_text order_tot_element
    @order_ttl = @order_ttl.gsub(/[^.0-9\-]/,"")
    return @order_ttl
  end

  def order_discount
    # wait_for_ajax
    @order_dis = wait_and_get_text order_dis_element
    @order_dis = @order_dis.gsub(/[^.0-9]/,"")
    return @order_dis
  end

  def sale_price_before_disc
    begin
      retries ||= 0
      @pro_sale_price_before_disc = wait_and_get_text pro_sale_price_bef_disc_element
      @pro_sale_price_before_disc = @pro_sale_price_before_disc.gsub(/[^.0-9\-]/,"")
    rescue Selenium::WebDriver::Error::JavascriptError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    else
      @pro_sale_price_before_disc
    end
  end

  def apply_promo_code arg
    # wait_for_ajax
    wait_and_set_text promo_code_value_element, arg
    @browser.execute_script("document.getElementById('add-coupon').click();")
    sleep 2
  end

  def product_sale_price_after_disc
    # wait_for_ajax
    @pro_sale_price_after_disc = wait_and_get_text pro_sale_price_aft_disc_element
    @pro_sale_price_after_disc = @pro_sale_price_after_disc.gsub(/[^.0-9\-]/,"")
    return @pro_sale_price_after_disc
  end

  def update_qty arg
    wait_and_select_option qty_dd_element, arg
  end

  def modify_bag(line_item,line_item_qty)
    Watir::Wait.until {product_line_items_in_bag_elements.find{|e| e.data_product_id == line_item}}.select(line_item_qty) if (line_item_qty.to_i) != 0
    Watir::Wait.until {@browser.button(value: line_item)}.click if (line_item_qty.to_i) == 0
    wait_for_ajax
  end

  def check_mybag_shipping_msg
    @ship_msg_txt = Watir::Wait.until {ship_msg_block_element}.text
    @ship_msg_txt = @ship_msg_txt.gsub(/["\-]/,"")
    return @ship_msg_txt
  end

  def voucher_success_message
    wait_for_ajax
    return voucher_message_element.wait_until(&:present?).text
  end

  def voucher_error_message
    wait_for_ajax
    return voucher_error_message_element.wait_until(&:present?).text
  end

  def applied_coupons
    wait_for_ajax
    return applied_coupons_element.wait_until(&:present?).attribute_value("innerHTML")
  end

  def is_any_coupon_present
    wait_for_ajax
    return applied_coupons_element.wait_until(&:present?).text
  end

  def check_remove_link index
    wait_for_ajax
    return voucher_remove_link_elements[index].present?
  end

  def coupon_global_error
    wait_for_ajax
    return sticky_global_error_element.wait_until(&:present?).text
  end

  def remove_voucher_from_bag coupon_id
    wait_for_ajax
    #delete_coupon_elements.find{|el| el.value.to_s == coupon_id.to_s}.tap(&:click).wait_while(&:present?)
    delete_coupon_elements.find{|el| el.value.to_s == coupon_id.to_s}.click
    wait_for_ajax
  end

  def assert_my_bag_page_url
    # wait_for_ajax
    sleep 3
    return @browser.url
  end

  def mybag_line_items_txt
    return wait_and_get_text bag_line_items_element
  end

  def mybag_line_items_html
    return wait_and_get_htmltext bag_line_items_element
  end

  def check_bag_line_item line_item
    return Watir::Wait.until {product_line_items_in_bag_elements.find{|e| e.data_product_id == line_item}}.present?
  end

  def check_bag_personalised_line_item line_item
     return Watir::Wait.until {product_line_items_in_bag_elements.find{|e| e.value == line_item}}.present?
  end

  def check_bag_line_item_sku(line_item, item_qty)
     return Watir::Wait.until {product_line_items_in_bag_elements.find{|e| e.data_product_id == line_item}}.text == item_qty
  end

  def click_delivery_method del_method
    wait_for_ajax
    del_meth_elements.find{|el| el.text.to_s =~ /#{del_method}/}.click
    wait_for_ajax
  end

  def return_delivery_method_text
    return wait_and_get_text sel_del_method_element
  end

  def return_mybag_page_text
    wait_for_ajax
    return (wait_and_get_text mybag_page_txt_element).gsub(/[\n]/,"")
  end

  def return_cont_shop_btn_mybag
    return wait_and_check_element_present? cont_shopping_link_element
  end

  def click_cont_shopp_btn_link
    wait_and_click cont_shopping_link_element
  end

  def click_wishlist_mybag
    wait_for_ajax
    wait_and_click add_to_wishlist_element
  end

  def giftbag_price
    wait_for_ajax
    @gift_bag_price = wait_and_get_text giftbag_price_element
    return @gift_bag_price
  end

  def return_avail_del_methods_text
    wait_for_ajax
    return (wait_and_get_text avail_del_meth_element).gsub(/[\n]/,"")
  end

  def get_recipient_name
    wait_for_ajax
    return wait_and_get_text get_rec_name_element
  end

  def get_senders_name
    wait_for_ajax
    return wait_and_get_text get_sender_name_element
  end

  def get_senders_msg
    wait_for_ajax
    return wait_and_get_text get_sender_msg_element
  end

  def get_design des_name
    wait_for_ajax
    return get_dsgn_elements.find{|el| el.text == des_name}.present?
  end

  def remove_egiftcard_from_mybag egiftcard
    wait_for_ajax
    product_line_item_link_in_mybag_elements.find{|e| e.div.text.include? egiftcard}.parent.div(:css => ".gift-cert-remove-button-container").click
    wait_for_ajax
  end

  def delete_line_items
    no_of_line_items = remove_line_items_elements.size
    no_of_giftwrap_line_items = remove_giftwrap_line_items_elements.length
    no_of_giftcard_line_items = remove_giftcard_line_items_elements.length
    no_of_applied_vouchers = delete_coupon_elements.length
    if no_of_applied_vouchers != 0
      while no_of_applied_vouchers !=0 do
        delete_coupon_elements[no_of_applied_vouchers-1].click
        wait_for_ajax
        no_of_applied_vouchers = no_of_applied_vouchers - 1
      end
    end
    if !empty_cart_page_element.present?
      sleep 3
      while no_of_line_items != 0 do
        wait_and_click(remove_line_items_elements[no_of_line_items-1])
        wait_for_ajax
         no_of_line_items = no_of_line_items - 1
       end
       while no_of_giftwrap_line_items != 0 do
         remove_giftwrap_line_items_elements[no_of_giftwrap_line_items-1].click
         wait_for_ajax
         no_of_giftwrap_line_items = no_of_giftwrap_line_items - 1
      end
      while no_of_giftcard_line_items != 0 do
        remove_giftcard_line_items_elements[no_of_giftcard_line_items-1].click
        wait_for_ajax
        no_of_giftcard_line_items = no_of_giftcard_line_items - 1
      end
    end
  end

  def add_products_to_wishlist product
    add_to_wishlist_elements.find{|el| el.data_variationgroup == product}.click
    wait_for_ajax
  end

  def move_to_wishlist_message
    move_to_wishlist_element.text
  end

  def check_move_to_wishlist_link_presence product
    return product_titles_on_mybag_elements.find{|el| el.href =~ /#{product}/}.present? && !@browser.button(data_variationgroup: product).present?
  end

  def check_move_to_wishlist_link_presence_eGiftCard product, design
    return egift_card_product_titles_on_mybag_elements.find{|el| el.text.strip == design}.present? && !@browser.button(data_variationgroup: product).present?
  end

  def check_vouchers_on_bag voucher_id
    return vouchers_on_bag_elements.find{|el| el.text == voucher_id}.present?
  end

  def total_vouchers_on_bag
    return vouchers_on_bag_elements.size
  end

  def check_number_of_product_line_items_on_bag
    return product_line_items_in_bag_elements.length
  end

  def edit_giftwrap
    wait_and_click edit_giftwrap_btn_element
  end

  def get_cart_present_text
   wait_and_get_text my_bagtext_element
  end

  def title_returns_section
     wait_for_ajax
     return wait_and_get_text title_return_section_element
  end

  def description_returns_section
     wait_for_ajax
     return wait_and_get_text description_returns_section_element
  end

  def click_remove_button sku_id
    wait_and_click remove_button_elements.find{|el| el.value == sku_id}
  end

  def empty_cart_page_presence
    return empty_cart_page_element.present?.to_s
  end

  def go_to_my_account_page
    sleep 2
    my_initials_link_element.click
    sleep 2
    my_account_link_element.click
  end

  def bnpl_logos_top_bag_pg
    bnpl_logos_top_bag_pg_element.attribute_value('innerHTML')
  end

  def zip_logo_top_bag_pg
    zip_logo_top_bag_pg_element.present?
  end

  def afterpay_logo_top_bag_pg
    afterpay_logo_top_bag_pg_element.present?
  end

  def bnpl_logos_bottom_bag_pg
    bnpl_logos_bottom_bag_pg_element.attribute_value('innerHTML')
  end

  def zip_logo_bottom_bag_pg
    zip_logo_bottom_bag_pg_element.present?
  end

  def afterpay_logo_bottom_bag_pg
    afterpay_logo_bottom_bag_pg_element.present?
  end

  def bnpl_top_tagline_text_bag_pg
    wait_and_get_text(bnpl_top_tagline_bag_pg_element)
  end

  def bnpl_bottom_tagline_text_bag_pg
    wait_and_get_text(bnpl_bottom_tagline_bag_pg_element)
  end

  def save_rrp_text
    sleep 2
    wait_and_get_text(multipack_save_text_mybag_element)
  end

  def save_rrp_text_present
    wait_and_check_element_present?(multipack_save_text_mybag_element)
  end

  def bonus_gift_heading
    return wait_and_get_text(bonus_gift_heading_element)
  end

  def click_quick_add_gift_carousel
    wait_and_click(quick_add_gift_carousel_element)
  end

  def CO_success_message
    return wait_and_get_text(voucher_message_element)
  end

  def gift_card_text
    return wait_and_get_text(gift_card_text_element)
  end
end