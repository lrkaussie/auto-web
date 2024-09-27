require 'page-object'
require 'page-object/page_factory'
require_relative '../../../../../features/support/utils'
require 'watir'
require_relative '../../../monkey_patch.rb'


class Gift_Wrap
  include PageObject
  include Utilities

    link(:giftwrap_dd, :css => ".giftwrap-title")
    link(:start_wrap, :css => ".giftwrap-start" )
    element(:giftwrap_title, :css => "span.giftwrap-title")
    elements(:giftbags, :css => "#giftwrap-products .product-tile")
    div(:basket_items, :css => ".basket-items")
    divs(:basket_line_items, :css => ".gw-product-tile")
    div(:giftwrap_items, :css => ".giftwrap-items.columns")
    text_field(:to_field, :css=> "#dwfrm_giftwrap_messageTo")
    text_field(:from_field, :css => "#dwfrm_giftwrap_messageFrom")
    text_area(:message_field, :css => "#dwfrm_giftwrap_messageText")
    button(:create_my_gift_btn, :css => ".save-gift-wrap")
    divs(:gw_sign, :css => ".gw-sign")
    divs(:tp_gift_bag_page, :css => ".gw-product-tile")
    elements(:err_msg_gift_bag, :css => ".section-error")
    span(:giftwrap_close, :css => ".giftwrap-close")
    div(:giftwrap_dis_block, :css => "#slide-dialog-container[style='display: block;']")
    link(:cont_gift_bag, :css=> ".button.continue-wrap")
    link(:back_to_bag, :css => ".button.back-cart")
    link(:checkout_now_btn, :css => ".button.checkout-now")
    div(:giftwrap_dis_dialog, :css=> ".gift-wrap-slide-dialog")
    div(:add_giftwrap_block, :css => ".giftwrap-message.expanded.giftwrap-light")
    buttons(:giftwrap_remove_btn_mybag, :css => ".pointer.giftwrap-remove")
    divs(:giftwrap_block, :css => ".giftbag-personlisation")
    div(:gift_products_details, :css => ".giftbag-product-details")
    form(:giftwrap_remove, :id => ".giftwrap-remove")
    h2(:giftwrap_titleline, :css => ".gift-wrap-headline", :index => 0)
    span(:empty_giftwrap_teaser_msg, :css => ".empty-bag-teaser")
    div(:giftwrap_img_placeholder, :css => ".gift-wrap-image")
    div(:carousel_right_arrow, :class => "icon icon-arrow-on-circle giftwrap-swiper-next swiper-button-next", :index => 1)
    list_items(:gift_message_cards, :class => "swiper-slide")

  def giftwrap_dd_click
    wait_for_ajax
    if !(add_giftwrap_block_element.present?)
      wait_and_click giftwrap_dd_element
    end
  end

  def start_wrapping_btn_click
    wait_for_ajax
    wait_and_click start_wrap_element
  end

  def assert_gift_page
    return wait_and_get_text giftwrap_title_element
  end

  def assert_add_your_items_section
    @basket_items = wait_and_get_text basket_items_element
    @basket_items = @basket_items.gsub!(/[^A-Za-z]/, '').upcase!
    return @basket_items
  end

  def click_basket_line_items arg
    wait_for_ajax(timeout=180)
    wait_and_click basket_line_items_elements[arg]
  end

  def check_giftwrap_add_remove_sym
    return gw_sign_elements.count
  end

  def total_products_on_gift_bag_page
    return tp_gift_bag_page_elements.count
  end

  def gift_wrap_items_txt
    wait_for_ajax
    return wait_and_get_htmltext giftwrap_items_element
  end

  def enter_to_msg arg
    wait_for_ajax
    wait_and_set_text to_field_element,arg
  end

  def enter_from_msg arg
    wait_for_ajax
    wait_and_set_text from_field_element,arg
  end

  def enter_opt_msg_txt arg
    wait_for_ajax
    wait_and_set_text message_field_element,arg
  end

  def click_create_my_gift_btn
    @element_count = tp_gift_bag_page_elements.count
    @element_count = @element_count - 1
    gw_sign_elements[@element_count].wait_until(&:present?)
    begin
      retries ||= 0
      @browser.execute_script("document.getElementsByClassName('button primary save-gift-wrap')[0].click();")
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    end
  end

  def err_msg_gift_bag_page
    error_message = ""
    err_msg_gift_bag_elements.map do |el|
      error_message << el.text
    end
    return error_message
  end

  def select_giftbag arg
    wait_for_ajax
    giftbags_elements.find{|el| el.data_itemcolor.to_s == "#{arg}"}.wait_until(&:present?).click
    giftwrap_img_placeholder_element.wait_until(&:present?)
  end

  def click_gw_close_btn
    wait_and_click giftwrap_close_element
  end

  def giftwrap_dismiss_confirm_block
    return (wait_and_get_text giftwrap_dis_block_element).gsub!(/["\n"]/,'')
  end

  def assert_cont_gift_bag
    return cont_gift_bag_element.present?
  end

  def assert_back_to_bag
    return back_to_bag_element.present?
  end

  def assert_back_to_bag_link
    return back_to_bag_element.attribute('href')
  end

  def assert_checkout_now
    return checkout_now_btn_element.attribute('href')
  end

  def click_cont_gift_bag
    wait_and_click cont_gift_bag_element
  end

  def gift_bag_dismiss_opt_click arg
    @browser.a(:class => /#{arg}/).click
  end

  def bag_line_item_text title
    @all_basket_items = basket_items_element.children
    @all_basket_items.find{|e| e.children[1].title == "#{title}"}.click
    # basket_line_items_elements.find{|e| e.children[1].title == "#{title}"}.click
  end

  def get_uuid_gift_bag
    wait_for_ajax
    $uuid = Array[]
    return $uuid = giftwrap_remove_btn_mybag_elements.map{|e| e.data_uuid}
  end

  def remove_giftcard_mybag giftcard_index
    @browser.button(:css=> ".giftwrap-remove.pointer[data-giftwrapindex='#{giftcard_index}']").click
    wait_for_ajax
  end

  def get_giftwrap_txt
    wait_for_ajax
    return giftwrap_block_elements.map{|e| e.attribute_value("innerText").gsub!(/[^0-9A-Za-z]/, '')}
  end

  def check_giftwrap_lineitem_text(line_item)
    Watir::Wait.until { gift_products_details_elements.find{|el|
      messageto = el.span(:class => 'messageto').attribute_value("innerText")
      messagefrom = el.span(:class => 'messagefrom').attribute_value("innerText")
      messagetext = el.span(:class => 'messagetext').attribute_value("innerText")
      return messageto == line_item["To"] && messagefrom == line_item["From"] && messagetext == line_item["Message"]
    }}
  end

  def assert_giftwrap_line_items_qty(qty)
    return gift_products_details_elements.count == qty
  end

  def check_giftwrap_line_item_on_position(pos)
    return Watir::Wait.until {giftwrap_remove_elements.find{|e| e.data_giftwrapindex == pos}}.present?
  end

  def remove_giftwrap_line_item(pos)
    wait_for_ajax
    Watir::Wait.until {giftwrap_remove_elements.find{|e| e.data_giftwrapindex == pos}}.click
  end

  def assert_gift_wrap_title_items
    return wait_and_get_text giftwrap_titleline_element
  end

  def reduce_qty_giftwrap_section index
    wait_and_click gw_sign_elements[index]
  end

  def empty_msg_present?
    empty_giftwrap_teaser_msg_element.wait_while{|el| el.style =~ /none/}
    return empty_giftwrap_teaser_msg_element.present?
  end

  def carousel_right_arrow_click
    wait_and_click(carousel_right_arrow_element)
  end

  def select_card arg
    wait_for_ajax
    gift_message_cards_elements.find{|el| el.attribute_value('innerHTML').to_s =~ /#{arg}/}.click
  end

  def enter_single_gift_message arg
    wait_and_click(message_field_element)
    wait_and_set_text(message_field_element, arg)
    sleep 5
  end

end