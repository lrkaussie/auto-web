require 'page-object'
require 'page-object/page_factory'
require_relative '../../../monkey_patch.rb'

class SearchPage
  include PageObject
  include Utilities

  text_field(:search_fld, :css => "[name='q']", :index => 2)
  div(:search_suggestion_box, :css => '.search-suggestion-wrapper', :index => 1)
  div(:phrase_suggestion_box, :class => 'phrase-suggestions')
  div(:product_suggestion_box, :class => 'product-suggestions')
  button(:search_icon, :css => "button.float-right.pointer.search-magnifier", :index => 1)
  div(:search_result_text, :css => '.search-result-text')
  button(:cross_icon_btn, :css => ".js-clear-search.clear-button", :index => 2)
  button(:search_magnifying_glass, :css => ".search-magnifier-active[type='submit']", :index => 1)
  div(:search_hit_text, :css => ".hitgroup", :index => 1)
  a(:clear_recent_link, :css=> ".clear-recent-searches", :index => 1)
  # button(:search_icon_active_box, :css => "button.float-right.pointer[type='submit']", :index => 1)(it is completely changed but it is still there in DOM)
  div(:search_icon_active_box, :class => "search-magnifier-white", :index => 2)
  div(:no_search_result_pg_text, :css => "div.no-hits-message", :index => 0)


  def enter_search_key arg
    wait_and_set_text search_fld_element,arg
    @@search_key_string = arg
  end

  def click_search_icon
    wait_and_click search_icon_element
    wait_for_ajax
  end

  def click_search_icon_with_active_search_box
    wait_and_click search_icon_active_box_element
    wait_for_ajax
  end

  def assert_show_results_title arg
    raise 'search results text is NOT validated' if not (search_result_text.include? arg)
  end

  def click_search_field
    wait_and_click search_fld_element
  end

  def recent_search_term
    return search_hit_text_element.text.gsub(/[\n]/," ")
  end

  def recent_search_link
    return phrase_suggestion_box_element.present?
  end

  def no_search_result_page_text
    return wait_and_get_text(no_search_result_pg_text_element)
  end
end