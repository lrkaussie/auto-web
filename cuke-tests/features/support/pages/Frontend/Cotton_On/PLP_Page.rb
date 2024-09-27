require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'
require "gmail"
require_relative '../../../monkey_patch.rb'

class PLPPage
  include PageObject
  include Utilities

  divs(:product_results, :css => ".product-tile")
  list_items(:plp_product_results, :class => "grid-tile columns")
  div(:plp_qa_modal, :css => "#QuickViewDialog")
  button(:x_btn_modal_window, :css => ".ui-button[type='button']")
  button(:add_to_bag_modal_window, :css => "#add-to-cart")
  a(:view_more_details_modal_window, :css => "a.qv-view-more-details")
  div(:plp_mw_afterpay_msg, :css => ".pdp-afterpay-message.product-afterpay-message")
  links(:wishlist_icon, :title => "Add to Wishlist")
  links(:wishlist_remove_icon, :title => "Remove from Wishlist")
  span(:multipack_save_text_plp, :class => "multipack-container", :index => 0)
  select_list(:quantity_quick_view, :name => "Quantity", :index => 0)
  div(:shipping_text, :class => "free-retutns-wrapper", :index => 0)
  a(:see_all_colours_modal_window, :class => "qv-see-all-colours-wrapper", :index => 0)
  spans(:plp_list_price, :class => "product-standard-price")
  spans(:plp_sale_price, :class => "product-sales-price")
  links(:plp_pagination, :title => /Go to page number-/)
  link(:plp_load_more, :class => "load-more-btn button primary hollow", :index => 0)

  def select_product product_group_id
    product_results_elements.find{|e| e.data_itemid == product_group_id}.click
    wait_for_ajax
  end

  def select_quick_add_product product_group_id
    @indx = (plp_product_results_elements.collect{|e| e.data_colors_to_show == product_group_id}.index(true)).to_i
    @browser.execute_script("document.querySelectorAll('a.quick-view-hover')[#@indx].click();")
    wait_for_ajax
  end

  def check_quick_add_product_icon? product_group_id
    @indx = ((product_results_elements.collect{|e| e.data_itemid == product_group_id}.index(true)).to_i)
    @quickview_presence = @browser.execute_script("return document.querySelectorAll('div.product-actions')[#@indx].childElementCount;")
      if @quickview_presence != 0
        return true
      else
        return false
      end
  end

  def check_add_to_bag_btn_success_msg
    return add_to_bag_modal_window_element.data_success
  end

  def click_wishlist_icon_plp arg
    @wishlist_icon_plp = wishlist_icon_elements.find{|x| x.attribute_value("data-variationgroup") == arg}.wait_until(&:present?)
    wait_and_click @wishlist_icon_plp
  end

  def remove_wishlist_icon_plp arg
    @wishlist_icon_uncheck_plp = wishlist_remove_icon_elements.find{|x| x.attribute_value("data-variationgroup") == arg}.wait_until(&:present?)
    wait_and_click @wishlist_icon_uncheck_plp
  end

  def check_wishlist_icon_plp? arg
    wait_for_ajax
    product_results_elements.find{|e| e.data_itemid == arg}.div.link(:title => 'Add to Wishlist').present?
  end

  def save_text_multipack_plp
    wait_and_get_text(multipack_save_text_plp_element)
  end

  def select_qty_quick_view qty
    wait_and_select_option quantity_quick_view_element, qty
    sleep 10
  end

  def shipping_text_quick_view
    return wait_and_get_text shipping_text_element
  end

  def plp_list_price product_group_id
    return plp_list_price_elements.find{|e| e.parent.parent.data_itemid == product_group_id}.text
  end

  def plp_sale_price  product_group_id
    @indx = (product_results_elements.collect{|e| e.data_itemid == product_group_id}.index(true)).to_i
    return plp_sale_price_elements[@indx].text
  end

  def plp_navigate_page page_number
    @page = page_number
    wait_for_ajax
    @browser.execute_script("document.getElementsByClassName('#@page')[1].click();")
    wait_for_ajax
  end

  def click_load_more times
    i = 0
    loop do
      wait_and_click(plp_load_more_element)
      i = i + 1
      if i == times.to_i
        break
      end
    end
  end
end