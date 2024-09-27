require 'page-object'
require 'Watir'
require 'page-object/page_factory'
require_relative '../../../../../features/support/utils'


class LaybuyPopup_Page
  include PageObject
  include Utilities

  link(:laybuy_log_in, :css => "a.u-full-width", :index => 1)
  button(:laybuy_cancel_order_before_login, :class => "s-btn s-btn--outline-white s-btn--sm u-inline-block", :index => 0)
  # text_field(:laybuy_email, :id => "login")
  text_field(:laybuy_email, :name => "email")
  # text_field(:laybuy_password, :id => "password")
  text_field(:laybuy_password, :name => "password")
  # button(:laybuy_login, :class => "s-btn s-btn--primary u-full-width s-btn--lg", :index => 0)
  button(:laybuy_login, :class => "sc-fzqBZW eRSfuC", :index => 0)

  # button(:laybuy_select_card_present, :css => "button.s-btn--lg")
  # button(:laybuy_continue_button, :css => "button.s-btn--lg", :index => 0)
  # element(:laybuy_order_total_amt, :class => "payment-total__sum", :index => 0)
  # element(:laybuy_page_inst_amt, :class => "payment-table__due-amount", :index => 0)
  element(:laybuy_page_inst_amt, :class => "sc-AxjAm sc-fzqAui wwiKh", :index => 1)
  # span(:laybuy_terms_chkbox, :class => "s-faux-pick s-faux-pick--checkbox", :index => 0)
  # button(:laybuy_complete_order, :class => "s-btn s-btn--primary s-btn--wide-lg s-btn--lg" , :index => 0)
  button(:laybuy_complete_order, :class => "sc-fzqBZW eRSfuC" , :index => 0)
  # button(:laybuy_cancel_order_after_login, :class => "s-btn s-btn--outline-grey-alt s-btn--sm u-inline-block", :index => 0)
  button(:laybuy_cancel_order_after_login, :class => "sc-AxjAm cTRjSe", :index => 0)


  def laybuy_login username, password
    Watir::Wait.until {laybuy_log_in_element}.wait_until_present
    Watir::Wait.until {laybuy_log_in_element}.click
    Watir::Wait.until {laybuy_email_element}.wait_until_present.click
    Watir::Wait.until {laybuy_email_element}.set username
    Watir::Wait.until {laybuy_password_element}.wait_until_present.click
    Watir::Wait.until {laybuy_password_element}.set password
  end

  def laybuy_logs_in
    wait_and_click(laybuy_login_element)
  end
  # def laybuy_continue_order
  #   wait_and_click(laybuy_select_card_present_element)
  #   sleep 2
  # end

  # def order_total_laybuy_page
  #   $laybuy_order_total = laybuy_order_total_amt_element.text.gsub(/[^.0-9\-]/,"")
  # end

  def laybuy_place_order_existing_user
    # wait_and_click laybuy_terms_chkbox_element
    wait_and_click laybuy_complete_order_element
  end

  def laybuy_page_instl_amt
    sleep 2
    @laybuy_page_instal_amt = wait_and_get_text(laybuy_page_inst_amt_element)
    @laybuy_page_instal_amt.gsub(/[^.0-9\-]/,"")
  end

  def click_laybuy_login
    Watir::Wait.until {laybuy_log_in_element}.wait_until_present
    Watir::Wait.until {laybuy_log_in_element}.click
  end

  def click_laybuy_browser_back
    @browser.execute_script('window.history.back();')
  end

  def laybuy_return_to_merchant_before_login
    wait_and_click laybuy_cancel_order_before_login_element
  end

  def laybuy_return_to_merchant_after_login
    wait_and_click laybuy_cancel_order_after_login_element
  end
end