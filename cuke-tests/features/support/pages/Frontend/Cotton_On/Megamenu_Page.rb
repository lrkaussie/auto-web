require 'page-object'
require 'page-object/page_factory'
require 'rspec'

class MegamenuPage
  include PageObject

		link(:cat_women,:link_text => "Women")
		link(:sub_cat_tops, :css => 'ul.row:nth-child(15) > ul:nth-child(2) > li:nth-child(7) > span:nth-child(2) > a:nth-child(1)')
		link(:sub_cat_women_tops, :class => 'last-category')
		div(:sub_cat_tops_custom, :"data-gtag" => "Women|Tops")




  def click_women_cat
    Watir::Wait.until {cat_women_element}.when_present.click
  end


  def click_tops_subcat
    Watir::Wait.until {sub_cat_tops_element}.when_present.click
    @current_url = @browser.url
    p @current_url
  end

  def assert_tops_women_sub
    @sub_cat_page_title = sub_cat_women_tops_element.attribute('title')
    raise 'Title of sub category page is NOT validated' if not ((@sub_cat_page_title).include?("Go to Tops"))
    @sub_cat_page_text = sub_cat_women_tops_element.text
    raise 'Text of sub category page is NOT validated' if not ((@sub_cat_page_text).include?("Tops"))
  end


end