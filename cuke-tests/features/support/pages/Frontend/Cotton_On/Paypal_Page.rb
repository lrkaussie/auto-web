require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'
require_relative '../../../monkey_patch.rb'

class PaypalPage
  include PageObject
  include Utilities

  p(:paypal_logo, :css => '.paypal-logo')
  text_field(:paypal_email_field, :css => '#email')
  element(:pay_with_heading, :class => "src_heading_1SHop", :index => 1)
  text_field(:paypal_password_field, :css => '#password')
  button(:paypal_sign_in, :css => '#btnLogin')
  div(:amt_paypal_page, :css => "div[data-testid='fi-amount']", :index => 0)
  button(:continue_to_paypal, :css => '.confirmButton')
  div(:visa_radio_btn, :class => "ppvx_radio")
  button(:continue_btn_paypal_store, :id => 'payment-submit-btn')
  span(:amt_paypal_bank_section, :css => '.methodAmount')
  div(:paypal_spinner, :css => "#preloaderSpinner.preloader.spinner[style='display: none;']")
  link(:sign_out, :id => 'header-logout')
  div(:user_signed_in_msg, :class => "xo-not-you-wrapper")
  button(:paypal_accept_cookies, :id => "acceptAllButton")
  radio_button(:payment_paypal_option, :css => "input.ppvx_radio__input___2-8-7[type='radio']" ,:index => 0)

  def accept_cookies_present
    return paypal_accept_cookies_element.present?
  end

  def accept_cookies_paypal
    wait_and_click(paypal_accept_cookies_element)
  end

  def pay_with_heading_presence
    wait_and_check_element_present? pay_with_heading_element
  end

  def paypal_logo_visible?
    Watir::Wait.while(timeout:30){paypal_logo_element.present?}
  end

  def paypal_spinner_visible?
    Watir::Wait.while(timeout:30){paypal_spinner_element.present?}
  end

  def paypal_login username, password
    wait_and_set_text paypal_email_field_element, username
    wait_and_set_text paypal_password_field_element, password
    wait_and_click paypal_sign_in_element
    sleep 2
  end

  def paypal_payment_option_selected?
    wait_is_checkbox_checked? payment_paypal_option_element
  end

  def click_continue_paypal_store
    # wait_and_click visa_radio_btn_element
    begin
      retries ||= 0
      pay_with_heading_element.wait_until(&:present?)
    rescue Watir::Wait::TimeoutError
      retry if (pay_with_heading_element.present? == "false")
    end
    wait_and_click continue_btn_paypal_store_element
  end

  def click_continue_to_paypal
    wait_and_click continue_to_paypal_element
  end

  def paypal_order_total
    @paypal_amt = wait_and_get_text amt_paypal_page_element
    @paypal_amt = @paypal_amt.gsub(/[^.0-9\-]/,"")
    return @paypal_amt
  end

  def paypal_order_total_bank_section
    @paypal_bank_amt = wait_and_get_text amt_paypal_bank_section_element
    @paypal_bank_amt = @paypal_bank_amt.gsub(/[^.0-9\-]/,"")
    return @paypal_bank_amt
  end

  def paypal_sign_out
    if sign_out_element.present?
      wait_and_click sign_out_element
    else
      return
    end
  end

end
