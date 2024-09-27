require 'page-object'
require 'Watir'
require 'page-object/page_factory'
require_relative '../../../../../features/support/utils'


class Klarna_Page
  include PageObject
  include Utilities

  button(:klarna_buy_button, :id => "buy-button")
  div(:klarna_order_total, :id => "order-amount__container")
  text_field(:klarna_ph_number, :id => "login_phone")
  button(:klarna_text_code, :id =>"btn-continue")
  text_field(:klarna_OTP, :id => /withAutofillProps(Component)/)
  div(:klarna_DOB, :id => "date_of_birth__container")
  div(:klarna_agree_chkbx, :id => "new_account_terms__box")
  button(:klarna_cont_button, :id => "btn-continue")
  text_field(:klarna_card_number, :id => "cardNumber")
  text_field(:klarna_expiry_dt, :id => "expire")
  text_field(:klarna_cvc, :id => "securityCode")
  button(:klarna_cont_card_pg, :xpath => '//*[@id="payinparts_kp-card-collection-add-card__bottom"]/div[1]/div/div/button')
  button(:klarna_confirm_btn, :id => "payinparts_kp-purchase-review-continue-button")
  button(:klarna_back_btn, :id => "back-button")

  def klarna_page_order_total site
    if site == "US"
      return wait_and_get_text(klarna_order_total_element.h1)
    end
    if site == "AU"
      @order_amt = wait_and_get_text(klarna_order_total_element.h1)
      return @order_amt.gsub(/[^.0-9\-]/,"")
    end
    if site == "GB"
      return wait_and_get_text(klarna_order_total_element.h1)
    end
  end

  def klarna_click_buy
    wait_and_click(klarna_buy_button_element)
  end

  def klarna_click_back
    wait_and_click(klarna_back_btn_element)
  end

  def klarna_click_cont_payment
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen")
    @iframe.button(:id =>"btn-continue").click
  end

  def klarna_enter_otp
    @iframe =@browser.iframe(:id => "klarna-hpp-instance-fullscreen")
    @iframe.div(:id => "authentication-ui__container").label.text_field.set("123456")
    # @otp = @iframe.div(:id => "authentication-ui__container").text_field(:css => "#i-f7c3b397-b950-4a85-8f78-60d98cd8f1d6", :index => 0).set"123456"
    # @otp = @iframe.div(:id => "authentication-ui__container").label
    # @otp.div(:css => "#authentication-ui__container > div > span > div > div:nth-child(9) > label > div > div:nth-child(1)").h1.set("1")
    # @otp.div(:css => "#authentication-ui__container > div > span > div > div:nth-child(9) > label > div > div:nth-child(2)", :index => 0).h1.set("2")
    # @otp.div(:css => "#authentication-ui__container > div > span > div > div:nth-child(9) > label > div > div:nth-child(3)", :index => 0).h1.set("3")
    # @otp.div(:css => "#authentication-ui__container > div > span > div > div:nth-child(9) > label > div > div:nth-child(4)", :index => 0).h1.set("4")
    # @otp.div(:css => "#authentication-ui__container > div > span > div > div:nth-child(9) > label > div > div:nth-child(5)", :index => 0).h1.set("5")
    # @otp.div(:css => "#authentication-ui__container > div > span > div > div:nth-child(9) > label > div > div:nth-child(6)", :index => 0).h1.set("6")
  end

  def klarna_confirm_phone_gb
    sleep 5
    @iframe =@browser.iframe(:id => "klarna-hpp-instance-fullscreen")
    @iframe.div(:id => "root").span.div(:id => "authentication-ui").button(:id=> "otp-intro-send-button").click
    sleep 5
  end

  def klarna_confirm_email_screen
    sleep 3
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen")
    if (@iframe.button(:id =>"btn-continue").present?).to_s == "true"
      @iframe.button(:id =>"btn-continue").click
      sleep 5
      @iframe.div(:id => "authentication-ui__container").label.text_field.set("123456")
    end
  end

  def klarna_US_DOB_details
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    @iframe1 = @iframe.span.iframe(:id => "payment-gateway-frame")
    @iframe2 = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "root").span
    if (@iframe2.span.form.div(:id => "date_of_birth__root").present?).to_s == "true"
      @iframe2.span.form.text_field(:id => "date_of_birth").set("08141982")
      @iframe2.span.div(:id => "new_account_terms__box").click
      @iframe2.button(:id => "btn-continue").click
    end
  end

  def klarna_US_card_details
    sleep 2
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    @iframe1 = @iframe.span.iframe(:id => "payment-gateway-frame")
    sleep 8
    if (@iframe1.text_field(:id => "cardNumber").present?).to_s == "true"
      @iframe1.text_field(:id => "cardNumber").set("4111111111111111")
      @iframe1.text_field(:id => "expire").set("0330")
      @iframe1.text_field(:id =>"securityCode").set("737")
      @iframe.button(:xpath => '//*[@id="payinparts_kp-card-collection-add-card__bottom"]/div[1]/div/div/button').click
    end
  end

  def klarna_GB_card_details
    sleep 5
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-main").div(:id => "root")
    @iframe1 = @iframe.span.iframe(:id => "payment-gateway-frame")
    if (@iframe1.div(:id => "app").label(:for => "cardNumber").text_field(:id => "cardNumber").present?).to_s == "true"
      @iframe1.div(:id => "app").label(:for => "cardNumber").text_field(:id => "cardNumber").set("4111111111111111")
      @iframe1.div(:id => "app").label(:for => "expire").text_field(:id => "expire").set("0330")
      @iframe1.div(:id => "app").label(:for => "securityCode").text_field(:id =>"securityCode").set("737")
    end
  end

  def klarna_AU_DOB_details
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    @iframe1 = @iframe.span.iframe(:id => "payment-gateway-frame")
    @iframe2 = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "root").span
    @iframe2.span.form.div(:id => "date_of_birth__root").present?
    if (@iframe2.span.form.div(:id => "date_of_birth__root").present?).to_s == "true"
      @iframe2.span.form.text_field(:id => "date_of_birth").set("14081982")
      @iframe2.button(:id => "btn-continue").click
    end
    if (@iframe.div(:id => "authentication-ui__footer-button-wrapper").present?).to_s == "true"
      @iframe.div.button(:xpath => '//*[@id="authentication-ui__footer-button-wrapper"]/div[1]/button').click
    end

  end

  def klarna_AU_card_details
    sleep 5
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    @iframe1 = @iframe.span.iframe(:id => "payment-gateway-frame")
    if (@iframe1.text_field(:id => "cardNumber").present?).to_s == "true"
      @iframe1.text_field(:id => "cardNumber").set("4111111111111111")
      @iframe1.text_field(:id => "expire").set("0330")
      @iframe1.text_field(:id =>"securityCode").set("737")
      @iframe.button(:xpath => '//*[@id="payinparts_kp-card-collection-add-card__bottom"]/div[1]/div/div/button').click
    end
  end

  def klarna_authenticate_identity
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    if (@iframe.div(:id => "authentication-ui__container-wrapper").present?).to_s == "true"
      @iframe.div.span.select_list(:id => "state_of_issue").select_value("VIC")
      @iframe.div.span.text_field(:id => "license_number").set("11111111")
      @iframe.div.span.button(:xpath => '//*[@id="authentication-ui__container"]/div/span/div/button').click
    end
  end

  def confirm_klarna_order
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    @iframe.button(:id => "payinparts_kp-purchase-review-continue-button").wait_until(&:present?)
    @iframe.button(:id => "payinparts_kp-purchase-review-continue-button").click
  end

  def confirm_declined_klarna_order
    @iframe = @browser.iframe(:id => "klarna-hpp-instance-fullscreen").div(:id => "main-remote-root")
    @iframe.button(:id => "payinparts_kp-message-close-button").wait_until(&:present?)
    @iframe.button(:id => "payinparts_kp-message-close-button").click
  end

end