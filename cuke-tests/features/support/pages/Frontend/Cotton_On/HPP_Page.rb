require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'


class HPPPage
  include PageObject
  include Utilities

  a(:top_back_btn, :css => '#wrapper > header > a')
  a(:bottom_back_btn, :css => '#pmcontent > a')

  def click_top_back_btn
    wait_and_click top_back_btn_element
  end

  def click_bottom_back_btn
    wait_and_click bottom_back_btn_element
  end

  def hit_back_btn_browser
    @browser.back
  end

end