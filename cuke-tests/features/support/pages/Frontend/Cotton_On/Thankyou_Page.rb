require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'


class ThankyouPage
  include PageObject
  include Utilities

  div(:order_confirm_text, :class => 'confirmation-message')
  div(:txn_id, :class => 'order-num')
  div(:pmt_type, :class => 'payment-type')
  element(:ord_total_on_conf_page, :class => 'order-value')
  element(:credit_total_on_conf_page, :css => 'div.payment-amount span.value', :index => 1)
  div(:del_add, :class => 'address')
  div(:del_method, :css => '.order-shipping-instruments')
  div(:billing_add, :class => 'mini-address-location')
  element(:order_confirm_page_text, :css => "h2.small-12.columns", :index => 0)
  div(:order_number, :class => 'order-num')
  divs(:payment_type, :class => 'payment-type')
  divs(:payment_amount, :class => 'payment-amount')
  divs(:product_line_items_in_ty, :css=> ".line-item")
  div(:thanks_for_order, :class => 'confirmation-message')
  div(:payment_method_section, :css => ".order-payment-instruments")

  def order_page_url
    return (@browser.url)
  end

  def order_conf_page_loaded?
    return Watir::Wait.while {@browser.text.include?('Did you enjoy your shopping experience today')}
  end

  def order_confirmation_text
    # wait_for_ajax
    @order_confirm_txt = wait_and_get_text order_confirm_text_element
    return @order_confirm_txt
  end

  def assert_transaction_id
    # wait_for_ajax
    @transaction_id = wait_and_get_text txn_id_element
    @transaction_id = @transaction_id.gsub(/[^.0-9\-]/,"")
    return @transaction_id
  end

  def assert_payment_type index
    # wait_for_ajax
    sleep 2
    @index = index.to_i
    @payment_type = wait_and_get_text payment_type_elements[@index]
    return @payment_type
  end

  def assert_order_total_on_conf_page
    wait_for_ajax
    @order_tot_conf_page = wait_and_get_text(ord_total_on_conf_page_element)
    @order_tot_conf_page = @order_tot_conf_page.gsub(/[^.0-9\-]/,"")
    return @order_tot_conf_page
  end

  def assert_credit_total_on_conf_page
    wait_for_ajax
    @order_credit_tot_conf_page = wait_and_get_text(credit_total_on_conf_page_element)
    @order_credit_tot_conf_page = @order_credit_tot_conf_page.gsub(/[^.0-9\-]/,"")
    return @order_credit_tot_conf_page
  end

  def billing_address_conf_page
    # wait_for_ajax
    @billing_address_text = wait_and_get_text billing_add_element
    @billing_address_text = @billing_address_text.gsub("\n"," ")
    return @billing_address_text
  end

  def confirm_delivery_address
    @delivery_address_text = wait_and_get_text del_add_element
    @delivery_address_text = @delivery_address_text.gsub("\n"," ")
    return @delivery_address_text
  end

  def confirm_delivery_method
    @delivery_method_text = wait_and_get_text del_method_element
    @delivery_method_text = @delivery_method_text.gsub("\n"," ")
    return @delivery_method_text
  end

  def order_confirm_page_loaded?
    begin
      retries ||= 0
      return Watir::Wait.until {(order_confirm_page_text_element.text).include? 'Did you enjoy your shopping experience today?'}
    rescue Selenium::WebDriver::Error::UnknownError
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      retry if (retries += 1) < $code_retry
    end
  end

  def is_Thankyou_page_displayed?
    begin
      retries ||= 0
      return thanks_for_order_element.inner_text.include? "Thank You For Your Order"
    rescue Selenium::WebDriver::Error::UnknownError
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      retry if (retries += 1) < $code_retry
    end

  end

  def find_dw_order_number
    begin
      retries ||= 0
      return Watir::Wait.until {order_number_element.span_element(class: 'value')}.text
    rescue Selenium::WebDriver::Error::UnknownError
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      retry if (retries += 1) < $code_retry
    end
  end

  def order_confirm_mesage_visible?
    wait_and_check_element_present? order_confirm_text_element
  end

  def verify_payment_type_on_thankyou_page index
    return payment_type_elements[index.to_i].text
  end

  def verify_order_amount_on_thankyou_page index
    return payment_amount_elements[index.to_i].span_element(:index => 1).text
  end

  def line_items_thankyoupage line_item
    return product_line_items_in_ty_elements.find {|a| a.attribute_value('innerText').gsub("\n","").include? line_item.to_s}
  end

  def payment_method_section_text
    return wait_and_get_text payment_method_section_element
  end

end