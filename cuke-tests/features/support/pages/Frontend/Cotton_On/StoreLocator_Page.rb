require 'page-object'
require 'page-object/page_factory'

class StoreLocator
  include PageObject
    h1(:store_locator_page_title, :class => 'title')
    element(:store_locator_brands_dd, :id => 'dwfrm_storelocator_brandsInStore')
    element(:store_locator_country_dd, :id => 'dwfrm_storelocator_country')
    element(:store_locator_text_field, :id => 'dwfrm_storelocator_textfield')
    element(:store_locator_use_my_loc_btn, :id => 'dwfrm_storelocator_findByLocation')
    element(:store_locator_search_btn, :id => 'dwfrm_storelocator_findByText')
    select_list(:store_locator_selected_brand, :id => 'dwfrm_storelocator_brandsInStore')
    select_list(:store_locator_selected_country, :id => 'dwfrm_storelocator_country')
    element(:store_city, :class => 'store-city')
    element(:store_name, :class => 'store-name')
    element(:store_brand_name, :class => 'store-brand')
    buttons(:store_brands_not_selected, :class => "search-brand pointer small-4 shrink ")
    buttons(:store_brands_selected, :class => 'search-brand pointer small-4 shrink selected')
    div(:store_locator_brands, :class => 'row storelocator-brands')

  def no_store_brands_selected
    store_brands_not_selected_elements.length
  end

  def store_brands_selected
    store_brands_selected_elements.length
  end

  def select_brand arg
    (store_locator_brands_element.buttons.find{|el| el.attribute_value("data-brandid") == arg}).click
  end

  def assert_store_locator_title
    @@store_locator_title = store_locator_page_title
    raise 'Cannot validate Store Locator Title page' if not (@@store_locator_title .include? 'Store Finder')
  end

  def assert_store_locator_brands_drop_down
    raise 'Cannot find Store Locator Brands Dropdown' if not (store_locator_brands_dd_element.present?)
  end

  def assert_store_locator_country_drop_down
    raise 'Cannot find Store Locator Country Dropdown' if not (store_locator_country_dd_element.present?)
  end

  def assert_store_locator_text_field
    raise 'Cannot find Store Locator Text Field' if not (store_locator_text_field_element.present?)
  end

  def assert_store_locator_use_my_loc
    raise 'Cannot find Store Locator Use my location button' if not (store_locator_use_my_loc_btn_element.present?)
  end

  def assert_store_locator_search_button
    raise 'Cannot find Store Locator search button' if not (store_locator_search_btn_element.present?)
  end

  def assert_selected_brand arg
    raise 'Cannot validate the Selected Brand drop down default value' if not (store_locator_selected_brand == arg)
  end

  def assert_selected_country arg
    raise 'Cannot validate the Selected Country drop down default value' if not (store_locator_selected_country == arg)
  end

  def click_search_btn_store_finder_page
    Watir::Wait.until {store_locator_search_btn_element}.when_present.click
    wait_for_ajax
  end

  def click_first_store
    Watir::Wait.until {store_city_element}.when_present.click
  end

  def assert_store_city arg
    raise 'Cannot validate the Store City' if not (store_city == arg)
  end

  def assert_store_name arg
    raise 'Cannot validate the Store Name' if not (store_name == arg)
  end

  def assert_store_brand_name arg
    raise 'Cannot validate the Store Brand Name' if not (store_brand_name == arg)
  end

end