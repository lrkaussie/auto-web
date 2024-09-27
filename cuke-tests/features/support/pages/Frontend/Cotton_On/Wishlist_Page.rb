require 'page-object'
require 'page-object/page_factory'

class WishlistPage
  include PageObject
  include Utilities

  div(:msg_wishlist_no_items, :css => ".empty-wishlist-msg")
  a(:start_shopping_link, :css => "a.start-shopping")
  span(:wishlist_items_count, :css => "span.wishlist-items-count")
  links(:product_names, :css => ".price-and-quick-add-button-wrapper a.name-link")
  links(:product_thumbnails, :css => "a.thumb-link")
  div(:msg_wishlist_no_items, :class => "empty-wishlist-msg")
  buttons(:products_on_wishlist, :class => 'product-quick-add')
  buttons(:add_to_bag, :css => "[data-title='Add'][type='button']")
  div(:added_to_bag_message, :css => ".added-wishlist-item")
  span(:green_tick_add_to_bag, :css => ".icon-green-tick-big")
  div(:size_selector, :css => ".selectsize[style='display: block;']")
  links(:remove_products_from_wishlist, :class => 'remove-from-wishlist')
  link(:remove_all_link, :title=> "Remove all")
  div(:remove_overlay_container_wishlist, :id => "slide-dialog-container")
  div(:remove_all_message_wishlist_overlay, :class => "wishlist-confirm-msg")
  button(:remove_all_items_wishlist_overlay, :class => "remove-all-items")
  button(:no_thanks_button_wishlist_overlay, :css => "button.close-remove-wishlist-dialog")
  span(:cross_icon_wishlist_overlay, :css => "span.close-remove-wishlist-dialog")
  divs(:out_of_stock_badge_wishlist, :css => ".product-stock-label")
  buttons(:disabled_add_btn_wishlist, :css => ".disabled[data-title='Add']")
  div(:product_tile, :css => ".product-tile")
  div(:my_wishlisttext, :css => ".wishlist-title")

  def sku_present? sku
    wait_for_ajax
    (@browser.hiddens(name:"pid").each{ |hidden| return true if hidden.value == sku })
  end

  def remove_wishlist_item product
    sleep 2
    remove_products_from_wishlist_elements.find{|el| el.data_product_id.to_s == product.to_s}.click
    wait_for_ajax
  end

  def check_message_wishlist_page
    wait_for_ajax
    wait_and_get_text msg_wishlist_no_items_element
  end


  def number_of_items_wishlist_page
   return wishlist_items_count_element.text
  end

  def click_start_shopping_link
    start_shopping_link_element.click
  end

  def click_product_name sku
    wait_for_ajax
    product_names_elements.find{|x| x.attribute_value("href")=~ /#{sku}/}.click
  end

  def validate_products_on_wishlist products
    products_on_wishlist = products_on_wishlist_elements.map(&:data_product_id)
    if products.sort == products_on_wishlist.sort
      true
    else
      false
    end
  end

  def click_product_thumbnail sku
    product_thumbnails_elements.find{|x| x.attribute_value("href")=~ /#{sku}/}.click
  end

  def remove_all_link
    remove_all_link_element.click
  end

  def clicking_add_to_bag_button product_id
    add_to_bag_elements.find{|x| x.attribute_value("data-product-id") == product_id}.click
  end

  def clear_wishlist
    return if !products_on_wishlist_elements.any?
    remove_products_from_wishlist_elements.each{|el|
      el.click
      wait_for_ajax
    }
  end

  def added_to_bag_message
  return wait_and_get_text(added_to_bag_message_element).gsub(/\n/," ")
  end

  def size_selection_wishlist arg
  size_selector_element.ul.lis.find{|x| x.a.span.text.include? arg}.click
  end

  def check_wishlist_remove_all_overlay_message
    remove_overlay_container_wishlist_element.wait_until do |s|
    s.present? && s.style('overflow') == 'visible'
    end
    return remove_all_message_wishlist_overlay_element.text
  end

  def remove_all_items_wishlist_overlay
    remove_all_items_wishlist_overlay_element.click
    remove_overlay_container_wishlist_element.wait_while(&:present?)
  end

  def no_thanks_button_wishlist_overlay
    no_thanks_button_wishlist_overlay_element.click
    remove_overlay_container_wishlist_element.wait_while(&:present?)
  end

  def cross_icon_wishlist_overlay
    remove_overlay_container_wishlist_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
      end
    cross_icon_wishlist_overlay_element.click
  end

 def remove_all_wishlist_overlay_disappear
   remove_overlay_container_wishlist_element.wait_while(&:present?)
   return remove_overlay_container_wishlist_element.style('display') == 'none'
 end

  def verify_out_of_stock_badge_wishlist arg
    begin
      retries ||= 0
      @browser.refresh
      # product_tile_elements.find{|x| x.attribute_value("data-itemid") == arg}.div(:class => "product-stock-label").wait_until(&:present?)
      product_tile_element.div(:class => "product-stock-label").wait_until(&:present?)
    rescue Watir::Wait::TimeoutError
      retry if (retries += 1) < 5
    end
  end

  def out_of_stock_badge_wishlist_text arg
    return out_of_stock_badge_wishlist_elements.find{|x| x.div(:class => "product-stock-label")}.text
  end

  def verify_disabled_add_to_bag_btn_wishlist arg
    return disabled_add_btn_wishlist_elements.find{|x| x.attribute_value("data-product-id") == arg}.present?
  end

  def number_of_products_wishlist
    return products_on_wishlist_elements.length
  end

  def get_wishlist_present_text
    wait_and_get_text my_wishlisttext_element
  end

  def start_shopping_link_presence
    return start_shopping_link_element.present?
  end
end