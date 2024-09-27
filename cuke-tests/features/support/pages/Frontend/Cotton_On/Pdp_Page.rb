require 'page-object'
require 'page-object/page_factory'
require_relative '../../../monkey_patch.rb'


class PdpPage
  include PageObject
  include Utilities

  button(:add_to_bag, :css => '#add-to-cart')
  div(:overlapped_success_msg, :css => '.mini-cart-attributes')
  element(:olapped_sm_window, :css => 'span.icon.icon-cross-standard-big-black')
  link(:view_cart_link, :css => "#navigation .mini-cart-link[title='View Cart']", :index => 1)
  div(:cont_btn, :css => 'div.continue-shopping-button')
  link(:checkout_btn, :css=> "a.button[title='Checkout Now']")
  text_field(:personalised_input_text, :css => "[name='dwfrm_product_personalText']")
  links(:variation_groups, :title => /Select Colour:/)
  # span(:online_tab, :for => 'tab-online')
  span(:instore_tab, :for => 'tab-instore')
  spans(:sizes_online, :class => 'swatchanchor-value')
  unordered_list(:sizes_instore, :class => /swatches instore/)
  divs(:stock_status, :class => /^store-item availability/)
  text_field(:search_string, :id => 'dwfrm_stockinstoreavailability_textField')
  button(:check_stores, :class => 'stock-store-search-button')
  labels(:instore_size_selector, :for => /instore_size/)
  div(:pdp_success_msg_block, :css => "#slide-dialog-container")
  divs(:stores, :class => 'store-item')
  spans(:store_type, :class => 'store-type')
  element(:cart_items, :css => "#cart-items-form")
  #to_do: to be moved into the cart page rb file
  span(:online_tab, :css => ".tab-label[for='tab-online']", :index => 0)
  label(:cnc_accordian, :css => "[for='cncTab']", :index => 0)
  button(:cnc_find_store_pdp, :css => "button.button-cnc-find-your-store", :index => 0)
  # div(:cnc_accordian, :css => ".label.shipinfo-label.cnc")
  text_field(:cnc_store_name, :css => "[name='dwfrm_storelocator_textfield']", :index => 0)
  div(:cnc_store_pop_up, :id => "cnc-slide-dialog-container")
  button(:cnc_preferred_store_set, :css => "[style='display: block;'] button.button-set-as-store", :index => 0)
  link(:wishlist_link, :css => ".wishlist[data-action='wishlist']")
  select_list(:quantity, :css => "#Quantity", :index => 0)
  div(:sel_size_msg, :css => ".select-size-msg")
  span(:stock_msg, :css => ".in-stock-msg")
  list_item(:selected_colour, :css => 'li.column.selected.selectable')
  span(:viewbag_button, :css => "span.checkout-now-label")
  text_field(:delivery_postcode, :css=> "[name='_delivery_postal_code']")
  div(:select_suburb, :css => ".tt-selectable.tt-suggestion", :index => 0)
  divs(:delivery_method_pdp, :css => "div.delivery-method")
  spans(:delivery_price_pdp, :css => "span.price")
  span(:delivery_estimator_changebutton, :css => ".change-address-btn")
  link(:cnc_changebutton, :css => ".change-store")
  div(:continue_shopping_button, :css => "div.continue-shopping-button.button.close-button", :index => 0)
  # link(:primary_image_PDP, :css => "a.main-image", :index => 0)
  div(:primary_image_PDP,:class => "pdp-product-images swiper-container swiper-container-horizontal", :index => 0)
  link(:afterpay_logo_pdp_quick_view, :css => "#afterpay-product-widg")
  link(:zip_logo_pdp_quick_view, :class => "zip-learn-more open-bnpl-modal-info", :index => 0)
  link(:humm_logo_pdp_quick_view, :css => ".humm-learn-more", :index => 0)
  link(:laybuy_logo_pdp_quick_view, :css => ".laybuy-learn-more", :index => 0)
  link(:latpay_logo_pdp_quick_view, :css => ".latitude-learn-more", :index => 0)
  div(:bnpl_message_pdp_quick_view, :css => "div.pdp-bnpl-message")
  link(:afterpay_modal_window_pdp, :css => "div.ui-widget-content a", :index => 0)
  element(:zip_modal_window_pdp, :class => "zip-modal-container", :index => 0)
  element(:humm_modal_window_pdp, :class => "humm-modal-container")
  element(:laybuy_modal_window_pdp, :class => "laybuy-modal-container", :index =>0)
  div(:latpay_modal_window_pdp, :class => "lp-modal", :index => 0)
  span(:multipack_save_text_pdp, :css => "span.multipack-container", :index => 0)
  unordered_list(:color_swatches_pdp, :class => "swatches online size open  row", :index => 0)
  elements(:unavailable_sizes_pdp, :class => "unselectable shrink columns")
  div(:bnpl_see_more_link, :class => "bnpl-see-more", :index => 0)
  # span(:store_search_btn_pdp, :css => "[value='Search'] span.icon-header-search-white", :index => 0)
  button(:store_search_btn_pdp,:class => "button primary store-search-button", :index => 0)
  div(:store_list_pdp, :id => 'store-list')
  div(:store_list_pdp_heading, :class => "store-locator-paging", :index =>0)
  div(:selected_cnc_store, :class => "selected-store-locator hide")
  link(:change_store_pdp, :class => "change-store button-cnc-find-your-store", :index => 0)
  div(:selected_cnc_store_name, :css => "div.saved-store-container .store-name", :index => 0)
  link(:cnc_store_change_link, :class => "change-store button-cnc-find-your-store", :index => 0)
  div(:spinner_pdp_overlay, :class => "loader", :index => 0)
  unordered_list(:size_online, :class => /swatches online size open/, :index => 0)
  span(:pdp_list_price, :class => "price-standard", :index => 0)
  span(:pdp_sale_price, :class => "price-sales", :index => 0)

  def primary_image_presence
    wait_for_ajax
    primary_image_PDP_element.wait_until(&:present?)
  end

  def click_add_to_bag
    wait_and_click add_to_bag_element
  end

  def overlapped_success_message
    # sleep 2
    wait_for_ajax
    wait_and_get_text overlapped_success_msg_element
  end

  def close_ovelapped_success_message
    wait_for_ajax
    begin
      retries ||= 0
      if Watir::Wait.while {olapped_sm_window_element.present?}
        olapped_sm_window_element.click
      end
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    end
  end

  def click_view_cart
    begin
      retries ||= 0
      wait_and_click view_cart_link_element
      wait_for_ajax
    rescue Exception
      retry if (retries += 1) < $code_retry
    end
  end

  def get_cart_items_txt
    return (wait_and_get_text cart_items_element).gsub!(/[^0-9A-Za-z]/, '').upcase!
  end

  def click_continue_button
    wait_and_click cont_btn_element
  end

  def click_checkout_button
    wait_and_click checkout_btn_element
  end

  def fill_personalised_text personalised_msg
     # wait_for_ajax
     wait_and_set_text personalised_input_text_element,personalised_msg
  end

  def select_variation_group(color)
    # wait_for_ajax
    begin
      retries ||= 0
      puts "The retry from select_variation_group is #{retries}"
      variation_groups_elements.find { |el| el.when_present.title.include? color }.click
    rescue Exception
      sleep 5
      retry if (retries += 1) < $code_retry
    end
  end

  def verify_active_tab (tab)
    if tab == "Online"
      return online_tab_element.parent(index: 2).when_present.attribute('class')

    elsif tab == "In-Stock"
      instore_tab_element.parent(index: 2).when_present.attribute('class')
    end
  end

  def select_online_size (size)
    wait_for_ajax
    sizes_online_elements.find {|el| el.when_present.text.eql? size}.click
  end

  def select_instore_size (size)
    wait_for_ajax
    instore_size_selector_elements.find {|el| el.when_present.text.eql? size}.click
  end

  def select_stock_tab(tab)
    if (tab == "Online")
      wait_for_ajax
      online_tab_element.when_present.click
    else
      wait_for_ajax
      instore_tab_element.when_present.click
    end
  end

  def validate_stock_status(store_no)
    store_no = store_no.to_i-1
    stock_status_elements[store_no].span_element(class: 'stock-msg').when_present.text
  end

  def search_for_store_stock(search_string)
    search_string_element.when_present.set(search_string) if search_string != ""
    check_stores_element.when_present.click
  end

  def verify_online_selected_size(size)
    sizes_online_elements.map do |el|
      return el.parent(:index => 1).attribute('class') if el.when_present.text.eql? size
    end
  end

  def verify_instore_selected_size(size)
    instore_size_selector_elements.map do |el|
      return el.parent.attribute('class') if el.span_element.when_present.text.eql? size
    end
  end

  def verify_prefilled_postcode (post_code)
    return search_string_element.when_present.attribute('value')
  end

  def verify_prefilled_suburb (suburb)
    return search_string_element.when_present.attribute('value')
  end

  def check_pdp_success_msg_txt
    @succ_txt = wait_and_get_text pdp_success_msg_block_element
    @succ_txt = @succ_txt.gsub(/["\-]/,"")
    return @succ_txt
  end

  def add_to_bag_enabled?
    Watir::Wait.until(timeout: 30){add_to_bag_element.enabled?}
  end

  def verify_store_type(index)
    return store_type_elements[index].when_present.text
  end

  def verify_no_of_stores_displayed
    begin
      retries ||= 0
      puts "The retry from verify_no_of_stores_displayed is #{retries}"
      stores_elements[9].wait_until_present
      return stores_elements.length.to_i
    rescue Exception
      sleep 5
      retry if (retries += 1) < $code_retry
    end
  end

  def click_online_tab
    wait_and_click online_tab_element
  end

  def click_cnc_accordian
    wait_and_click cnc_accordian_element
    wait_and_click cnc_find_store_pdp_element
  end

  def enter_cnc_store_city city_name
    cnc_store_pop_up_element.wait_until(&:present?)
    wait_for_ajax
    wait_and_set_text cnc_store_name_element,city_name
    sleep 5
    wait_for_ajax
    store_search_btn_pdp_element.click
    while store_list_pdp_heading_element.present? == false do
      store_search_btn_pdp_element.click
    end
  end

  def set_preferred_cnc_store
    wait_for_ajax
    wait_and_click cnc_preferred_store_set_element
  end

  def click_wishlist_pdp
    wait_for_ajax
    wait_and_click wishlist_link_element
  end

  def select_qty qty
    # wait_for_ajax
    wait_and_select_option quantity_element, qty
    # wait_for_ajax
    sleep 2
  end

  def check_out_from_pdp_success_message
    pdp_success_msg_block_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    checkout_btn_element.click
  end

  def size_not_selected_err_msg
    wait_for_ajax
    return (wait_and_get_text sel_size_msg_element.span_element).gsub(/[^a-zA-Z. ]/,"")
  end

  def get_stock_msg
    wait_for_ajax
    return (wait_and_get_text stock_msg_element).gsub(/[^0-9a-zA-Z. ]/,"")
  end

  def click_tab_pdp arg
    case arg
      when 'In-Store'
        wait_and_click instore_tab_element
    end
  end

  def selected_colour arg
    return selected_colour_element.a.href.include? arg
  end

  def refresh_pdp_page
    (1..5).each {
      @browser.refresh
      sleep 5
    }
  end

  def verify_viewbagButton
    return Watir::Wait.until {wait_and_get_text viewbag_button_element}
  end

  def click_viewbagButton
    Watir::Wait.until {viewbag_button_element}.click
  end

  def delivery_enter_postcode postcode
    wait_for_ajax
    wait_and_click(delivery_postcode_element)
    wait_and_set_text delivery_postcode_element, postcode
    wait_for_ajax
    wait_and_click(select_suburb_element)
    wait_for_ajax
  end

  def verify_delivery_method arg
    case arg
      when "Standard Delivery"
        delivery_method_pdp_elements[1].text
      when "Express Delivery"
        delivery_method_pdp_elements[0].text
      when "Melbourne Metro"
        delivery_method_pdp_elements[2].text
    when "Personalised Delivery"
        wait_for_ajax
        delivery_method_pdp_elements[0].text
    end
  end

  def verify_delivery_price arg
    case arg
      when "Standard Delivery"
        delivery_price_pdp_elements[1].text
      when "Express Delivery"
        delivery_price_pdp_elements[0].text
      when "Melbourne Metro"
        delivery_price_pdp_elements[2].text
      when "Personalised Delivery"
        delivery_price_pdp_elements[0].text
    end
  end

  def verify_changetextbutton delivery_type
    case delivery_type
      when "Delivery Estimator"
        return wait_and_get_text delivery_estimator_changebutton_element
      when "cnc"
        return wait_and_get_text cnc_changebutton_element
    end
  end

  def continue_shopping_button_presence
    pdp_success_msg_block_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    return continue_shopping_button_element.present?
  end

  def click_see_more_link
    wait_and_click(bnpl_see_more_link_element)
  end

  def afterpay_logo_pdp_quick_view
    afterpay_logo_pdp_quick_view_element.present?
  end

  def zip_logo_pdp_quick_view
    zip_logo_pdp_quick_view_element.present?
  end

  def humm_logo_pdp_quick_view
    humm_logo_pdp_quick_view_element.present?
  end

  def laybuy_logo_pdp_quick_view
    laybuy_logo_pdp_quick_view_element.present?
  end

  def latpay_logo_pdp_quick_view
    latpay_logo_pdp_quick_view_element.present?
  end

  def bnpl_msg_pdp_quick_view
    bnpl_message_pdp_quick_view_element.text
  end

  def bnpl_msg_pdp_quick_view_presence
    bnpl_message_pdp_quick_view_element.present?
  end

  def afterpay_modal_window_presence
    wait_and_click(afterpay_logo_pdp_quick_view_element)
    wait_for_ajax
    afterpay_modal_window_pdp_element.attribute_value('style').include? "display: block"
  end

  def zip_modal_window_presence
    wait_and_click(zip_logo_pdp_quick_view_element)
    wait_for_ajax
    zip_modal_window_pdp_element.wait_until(&:present?)
  end

  def humm_modal_window_presence
    wait_and_click(humm_logo_pdp_quick_view_element)
    wait_for_ajax
    humm_modal_window_pdp_element.wait_until(&:present?)
  end

  def laybuy_modal_window_presence
    wait_and_click(laybuy_logo_pdp_quick_view_element)
    wait_for_ajax
    laybuy_modal_window_pdp_element.wait_until_present
  end

  def latpay_modal_window_presence
    wait_and_click(latpay_logo_pdp_quick_view_element)
    wait_for_ajax
    latpay_modal_window_pdp_element.wait_until_present
  end

  def humm_logo_quick_view
    humm_logo_pdp_quick_view_element.present?
  end

  def laybuy_logo_quick_view
    laybuy_logo_pdp_quick_view_element.present?
  end

  def latitude_pay_logo_quick_view
    latitude_pay_logo_pdp_quick_view_element.present?
  end

  def save_text_multipack_pdp
    wait_and_get_text(multipack_save_text_pdp_element)
  end

  def number_of_sizes_displayed
    color_swatches_pdp_element.links.count.to_s
  end

  def unavailable_sizes
    unavailable_sizes_pdp_elements.count.to_s
  end

  def store_search_button_pdp
    begin
      retries ||= 0
      wait_and_click store_search_btn_pdp_element
      store_list_pdp_element.wait_until(&:present?)
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue NoMethodError
      sleep 10
      retry if (retries += 1) < $code_retry
    end
  end

  def selected_cnc_store_presence
    wait_for_ajax
    return wait_and_check_element_present?(selected_cnc_store_element)
  end

  def click_change_store_link
    wait_and_click(change_store_pdp_element)
  end

  def selected_cnc_store_name
    wait_for_ajax
    return wait_and_get_text(selected_cnc_store_name_element)
  end

  def change_cnc_store city_name
    wait_and_click cnc_accordian_element
    wait_and_click cnc_store_change_link_element
    wait_and_set_text cnc_store_name_element,city_name
    sleep 5
    wait_for_ajax
    store_search_btn_pdp_element.click
    while store_list_pdp_heading_element.present? == false do
      store_search_btn_pdp_element.click
    end
  end

  def add_to_wishlist_quick_view
    wait_for_ajax
    wait_and_click wishlist_link_element
  end

  def size_class_text
    return size_online_element.attribute_value('class')
  end

  def sizes_online_class_text arg
    return sizes_online_elements[arg].parent.parent.parent.attribute_value('class')
  end

  def sizes_online_text arg
    return wait_and_get_text(sizes_online_elements[arg])
  end

  def pdp_list_price
    return wait_and_get_text(pdp_list_price_element)
  end

  def pdp_sale_price
    return (wait_and_get_text(pdp_sale_price_element)).gsub(" ", "")
  end
end
