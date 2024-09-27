require 'page-object'
require 'page-object/page_factory'

class MinicartPage
  include PageObject
  include Utilities

  span(:mini_cart_qty, :class => 'minicart-qty-label')
  link(:mini_cart_icon, :css => "ul.show-for-large li.show-for-xlarge.nav-item.nav-minicart a.mini-cart-link[title='View Cart']", :index => 0)


  def click_mini_cart_icon
    sleep 2
    begin
      retries ||= 0
      mini_cart_icon_element.click
      # @browser.execute_script("document.getElementsByClassName('mini-cart-link')[1].click();")
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Selenium::WebDriver::Error::ElementClickInterceptedError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
      browser.refresh
      retry if (retries += 1) < $code_retry
    end
  end

  def mini_cart_quantity
    wait_for_ajax
    begin
      retries ||= 0
      return Watir::Wait.until {mini_cart_qty_element.inner_html}
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    end
  end

end