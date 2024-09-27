require 'page-object'
require 'page-object/page_factory'
require_relative '../../../../../features/support/utils'


class AfterpayPopup_Page
  include PageObject
  include Utilities
  div(:amt_afterpay_page, :class =>"summary-accordion__col summary-accordion__quantity-or-price text--align-right text--weight-bold", :index => 0)
  text_field(:afterpay_cvc_field, :css => "[automation_id='input-cardCVC']")
  checkbox(:over_eighteen_cbox, :css => "[automation_id='input-termsAgreed']")
  button(:afterpay_confirm_btn, :css => "[automation_id='button-submit']")
  element(:afterpay_preloader_visible, :css => ".splash-screen.loading[ng-show='! applicationVisible']")
  element(:afterpay_preloader_hidden, :css => ".splash-screen.loading.ng-hide[ng-show='! applicationVisible']")
  text_field(:afterpay_email_field, :name => 'email', :index => 0)
  button(:afterpay_email_continue, :css => '[automation_id="button-submit"]')
  text_field(:afterpay_password_field, :name => 'password')
  button(:afterpay_sign_in, :css => "[automation_id='button-submit']")
  element(:afterpay_due_today_block_text, :css => "[automation_id='text-puf']")
  button(:afterpay_ok_payment_button, :css => "[automation_id='button-confirmPaymentUpFront']")
  text_field(:afterpay_v2_email_field, :css => "[data-testid='checkout-email-input']", :index => 0)
  button(:afterpay_v2_email_continue, :css => "[data-testid='login-email-button']", :index => 0)
  text_field(:afterpay_v2_password_field,:css => "[data-testid='login-password-input']",:index => 0)
  button(:afterpay_v2_password_continue, :css => "[data-testid='login-password-button']", :index => 0)
  button(:afterpay_v2_confirm_payment_button, :css => "[data-testid='summary-button']", :index => 0)
  span(:amt_v2_afterpay_page, :css => "span[data-testid='text-money']", :index => 0)


  def validate_afterpay_page
    sleep 2
    @afterpay_amt = wait_and_get_text amt_afterpay_page_element
    @afterpay_amt = @afterpay_amt.gsub(/[^.0-9\-]/,"")
    return @afterpay_amt
  end

  def enter_cvc_afterpay_page
    if afterpay_cvc_field_element.present?
      wait_and_set_text afterpay_cvc_field_element, '123'
    end
  end

  def check_over_eighteen_checkbox
    # wait_and_click over_eighteen_cbox_element
    @browser.execute_script ("document.getElementById('termsAgreed').click();")
  end

  def place_order_afterpay
    wait_and_click afterpay_confirm_btn_element
  end

  def afterpay_login username, password
    sleep 2
    Watir::Wait.while(timeout:30) {afterpay_preloader_visible_element.present?}
    if ((afterpay_preloader_visible_element.present?).to_s) == "false"
      Watir::Wait.until {afterpay_email_field_element}.wait_until_present.click
      Watir::Wait.until {afterpay_email_field_element}.set username
      Watir::Wait.until {afterpay_email_continue_element}.wait_until_present.click
      Watir::Wait.while(timeout:30) {afterpay_preloader_visible_element.present?}
      # Watir::Wait.until {afterpay_password_field_element}.wait_until_present.click
      wait_and_set_text(afterpay_password_field_element, password)
      Watir::Wait.until {afterpay_password_field_element}.set password
      Watir::Wait.until {afterpay_sign_in_element}.wait_until_present.click
      # wait_and_click(afterpay_sign_in_element)
    end
  end

  def afterpay_v2_login username, password
    sleep 2
    Watir::Wait.while(timeout:30) {afterpay_preloader_visible_element.present?}
    if ((afterpay_preloader_visible_element.present?).to_s) == "false"
      Watir::Wait.until {afterpay_v2_email_field_element}.wait_until_present.click
      Watir::Wait.until {afterpay_v2_email_field_element}.set username
      Watir::Wait.until {afterpay_v2_email_continue_element}.wait_until_present.click
      Watir::Wait.while(timeout:30) {afterpay_preloader_visible_element.present?}
      # wait_and_set_text(afterpay_v2_password_field_element, password)
      Watir::Wait.until {afterpay_v2_password_field_element}.set password
      wait_and_click(afterpay_v2_password_continue_element)
    end
  end

  def validate_v2_afterpay_page
    sleep 2
    @afterpay_amt = amt_v2_afterpay_page_element.text
    @afterpay_amt = @afterpay_amt.gsub(/[^.0-9\-]/,"")
    return @afterpay_amt
  end

  def place_order_v2_afterpay
    wait_and_click afterpay_v2_confirm_payment_button_element
  end

  def afterpay_due_today_check
    begin
      retries ||= 0
      afterpay_due_today_block_text_element.focus
      if (afterpay_due_today_block_text_element).present?
        Watir::Wait.until{afterpay_ok_payment_button_element}.wait_until_present.click
      end
    rescue Selenium::WebDriver::Error::UnknownError
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      retry if (retries += 1) < $code_retry
    end
  end

end

