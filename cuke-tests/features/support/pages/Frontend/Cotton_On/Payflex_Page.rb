require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'
require "gmail"
require 'watir'
require_relative '../../../../../features/support/utils'
require_relative '../../../monkey_patch.rb'

class PayflexPage
  include PageObject
  include Utilities
  include DataMagic

  div(:payflex_page_instl_amt, :css => "div.installment-amount", :index => 0)
  div(:payflex_page_order_total, :css => "div.installment-amount", :index => 4)
  text_field(:payflex_email, :id => "mat-input-3")
  text_field(:payflex_mobile_number, :id => "mat-input-4")
  span(:payflex_id_confirmation_edit, :class => "yourdetails-edit", :index => 0)
  span(:payflex_confirm_id, :class => "link-cursor confirm-active", :index => 0)
  text_field(:payflex_id_number, :id => "idnumber")
  div(:payflex_terms, :css => "div.round.slider", :index => 0)
  button(:payflex_continue_order, :class => "sky-button ng-star-inserted", :index => 0)
  span(:payflex_cancel_order, :class => "return-merchant", :index => 0)
  text_field(:payflex_otp, :name => "code", :index => 0)
  button(:payflex_submit_otp, :class => "sky-button", :index => 0)
  element(:payflex_loader, :class => "loader")
  text_field(:payflex_card_number, :name => "card.number", :index => 0)
  text_field(:payflex_expiry_date, :class => "wpwl-control wpwl-control-expiry", :index => 0)
  text_field(:payflex_card_name, :name => "card.holder", :index => 0)
  text_field(:payflex_card_cvv, :name => "card.cvv", :index => 0)
  button(:payflex_pay_now, :class => "wpwl-button wpwl-button-pay", :index => 0)
  # in_iframe(:id => "myCustomIframe")
  element(:payflex_return_code, :id => "returnCode")
  element(:payflex_submit_button, :name => "B2", :index => 0)
  text_field(:payflex_password, :name => "password")
  button(:payflex_order_submit, :class => "sky-button ng-star-inserted")
  span(:payflex_edit, :class => "yourdetails-edit", :index => 0)
  element(:order_confirm_page_text, :css => "h2.small-12.columns" )
  text_field(:payflex_set_password, :id => "mat-input-0")
  button(:payflex_place_order, :class => "sky-button ng-star-inserted")
  element(:payflex_return_to_merchant, :class => "return-merchant")

  def payflex_go_for_it
    @iframe_main = @browser.iframe(:id => "myCustomIframe")
    @iframe_main.element(:class => "yourdetails-edit").click
    @random_text = 5.times.map{ ('a'..'z').to_a.sample }.join
    @iframe_main.text_field(:id => "mat-input-3").set("cottononqa+" + @random_text + "@gmail.com")
    @random_number = 5.times.map{rand(10)}.join
    @iframe_main.text_field(:id => "mat-input-4").set("78328" + @random_number)
    @iframe_main.element(:class => "link-cursor confirm-active", :index => 0).click
    @iframe_main.text_field(:id => "idnumber").set("7703275020081")
    @iframe_main.div(:css => "div.round.slider", :index => 0).click
    @iframe_main.button(:class => "sky-button ng-star-inserted", :index => 0).click
  end

 def payflex_enter_OTP
   @iframe_main = @browser.iframe(:id => "myCustomIframe")
   @iframe_main.text_field(:name => "code", :index => 0).set("911911")
   @iframe_main.button(:class => "sky-button", :index => 0).click
   # Watir::Wait.until(timeout: 500) {@iframe_main.iframe(:class => "wpwl-control wpwl-control-iframe wpwl-control-cardNumber", :index => 0).text_field(:name => "card.number", :index => 0)}.wait_until_present
 end

 def payflex_enter_card_details
   @iframe_main = @browser.iframe(:id => "myCustomIframe")
   @iframe_card = @browser.iframe(:id => "myCustomIframe").iframe(:class => "wpwl-control wpwl-control-iframe wpwl-control-cardNumber", :index => 0)
   # @iframe_card = @iframe_card_main.iframe(:class => "wpwl-control wpwl-control-iframe wpwl-control-cardNumber", :index => 0)
   @iframe_card.text_field(:name => "card.number", :index => 0).set("4111111111111111")
   @iframe_main.text_field(:class => "wpwl-control wpwl-control-expiry", :index => 0).set("0221")
   @iframe_main.text_field(:name => "card.holder", :index => 0).set("vincy")
   @iframe_cvv = @iframe_main.iframe(:class => "wpwl-control wpwl-control-iframe wpwl-control-cvv")
   @iframe_cvv.text_field(:name => "card.cvv", :index => 0).set("111")
   @iframe_main.button(:class => "wpwl-button wpwl-button-pay", :index => 0).click
   Watir::Wait.until {@iframe_main.element(:id => "returnCode")}.wait_until_present
 end

 def payflex_enter_return_code
   @iframe_main = @browser.iframe(:id => "myCustomIframe")
   @iframe_main.select_list(:id => "returnCode").options[1].select
   begin
     retries ||= 0
     Watir::Wait.until{@iframe_main.select_list(:id => "returnCode")}
     sleep 2
     @iframe_main.element(:xpath => '//*[@id="frameDiv"]/table/tbody/tr[18]/td[1]/input').click
     sleep 2
     Watir::Wait.until{@iframe_main.text_field(:name => "password", :index => 0)}
   rescue Selenium::WebDriver::Error::UnknownError
     retry if (retries += 1) < $code_retry
   rescue Selenium::WebDriver::Error::ElementNotInteractableError
     retry if (retries += 1) < $code_retry
   rescue Watir::Exception::UnknownObjectException
     retry if (retries += 1) < $code_retry
   rescue Watir::Exception::UnknownFrameException
     retry if (retries += 1) < $code_retry
   end
 end

  def payflex_enter_password
    sleep 5
    @iframe_main = @browser.iframe(:id => "myCustomIframe")
    @random_word = 7.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{@iframe_main.text_field(:name => "password", :index => 0)}
    @iframe_main.text_field(:name => "password", :index => 0).set("S" + @random_word + "1")
    @iframe_main.button(:class => "sky-button ng-star-inserted").click
    Watir::Wait.until(timeout: 500) {@browser.text.include?('Did you enjoy your shopping experience today')}
  end

  def payflex_return_to_CO_page
    @iframe_main = @browser.iframe(:id => "myCustomIframe")
    @iframe_main.element(:class => "return-merchant").click
  end

end
