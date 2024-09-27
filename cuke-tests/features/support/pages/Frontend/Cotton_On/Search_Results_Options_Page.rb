require 'page-object'
require 'page-object/page_factory'
require 'rspec'

class SearchResultsOptionsPage
  include PageObject
  @@position = 1
  h3(:dd_sby_title, :xpath => "//div[@id='primary']/div[3]/div/div[2]/span/div/h3")
  li(:hi_lo, :text => 'Price high to low')
  li(:lo_hi,:text => 'Price low to high')
  li(:whats_new, :text => "What's New")
  element(:show_dd, :css => "div.items-per-page.dropdown-wrapper > h3.dropdown-title")
  li(:twenty_four, :text => "24")
  li(:forty_eight, :text => "48")
  li(:ninety_six, :text => "96")
  div(:pagination, :class => "pagination")
  unordered_list(:sort_by, :class => "grid-sort-header")
  unordered_list(:show, :id => "grid-paging-header")
  element(:selected_filter, :class => "selected")
  li(:current_page, :class => "current-page")
  div(:sort_by_dd, :class => "sort-by dropdown-wrapper")
  spans(:sale_price, :class => 'product-sales-price')
  def price_sales_price i
    @prod_sale_price = Watir::Wait.until{@browser.spans(:class => 'product-sales-price')[i].attribute_value("innerHTML")}
    @prod_sale_price = @prod_sale_price.gsub!(/[^0-9A-Za-z.]/, '')
    @prod_sale_price = @prod_sale_price.to_f
    return @prod_sale_price
  end

  def product_count_on_page
    return @browser.divs(:class => 'product-tile').size
  end







  def assert_dd_sby_title
    return dd_sby_title
  end

  def click_sortby_dd
    dd_sby_title_element.click
  end

  def high_low_text
    return hi_lo
  end

  def low_high_text
    return lo_hi
  end

  def whats_new_text
    return whats_new
  end

  def show_dd_text
    return show_dd
  end

  def click_show_dd_text
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    @wait_for_page_to_load.page_wait
    Watir::Wait.until {show_dd_element}.scroll_into_view
    Watir::Wait.until {show_dd_element}.wait_until_present.click
  end

  def first_show_option
    return twenty_four
  end

  def second_show_option
    return forty_eight
  end

  def third_show_option
    return ninety_six
  end

  def pagination_present
    return (pagination_element.present?).to_s
  end

  def click_high_low
    hi_lo_element.wait_until_present.click
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    @wait_for_page_to_load.page_wait
  end

  def check_url
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    @wait_for_page_to_load.page_wait
    return @browser.url.downcase
  end

  def click_low_high
    lo_hi_element.click
  end

  def click_whats_new
    whats_new_element.click
  end

  def click_first_show_option
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    @wait_for_page_to_load.page_wait
    Watir::Wait.until {twenty_four_element}.scroll_into_view
    return twenty_four_element.click
  end

  def click_second_show_option
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    @wait_for_page_to_load.page_wait
    Watir::Wait.until {forty_eight_element}.scroll_into_view
    return forty_eight_element.wait_until_present.click
  end

  def click_third_show_option
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    @wait_for_page_to_load.page_wait
    Watir::Wait.until {ninety_six_element}.scroll_into_view
    return ninety_six_element.wait_until_present.click
  end

  def assert_sort_by_list
    return sort_by_element.attribute_value("innerText")
  end

  def assert_show_by_list
    return show_element.attribute_value("innerText")
  end

  def default_filter_selected
    return selected_filter_element.attribute_value("innerText")
  end

  def current_page_selected
    return current_page_element.attribute_value("innerText")
  end

  def sort_by_dd
    return Watir::Wait.until {sort_by_dd_element}.wait_until_present.click
  end


end