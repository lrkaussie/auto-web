require 'page-object'
require 'watir'
require 'page-object/page_factory'
require_relative '../../../../../features/support/utils'


class ZipPopup_Page
  include PageObject
  include Utilities
  button(:zip_account_sign_in, :class => "multi-product md-button-large md-button ng-scope md-reserved-theme md-ink-ripple", :index => 0)
  # text_field(:zip_email_sign_up, :id => "emailAddress")
  # text_field(:zip_password_sign_up, :id => "password")
  # button(:zip_submit_sign_up, :class => "md-raised md-primary md-button-large md-button ng-binding md-ink-ripple")
  text_field(:zip_email, :css => ".zip-input[type='email']", :index => 0)
  text_field(:zip_password, :css => ".zip-input[type='password']", :index => 0)
  button(:zip_sign_in, :css => "button.primary[type='submit']", :index => 0)
  button(:zip_continue_order, :id => "completeOrder")
  element(:zip_order_total, :id => "shoppingCart-orderTotal")
  div(:zip_order_total_new_user, :id => "sideCart-orderTotal")
  element(:zip_shipping_cost, :css => "div.ng-binding[ng-bind='vm.model.order.shipping_value | zipCurrency:true']", :index => 0)
  span(:zip_available_amount, :id => "retransaction-availableFunds")
  button(:zip_send_code, :class => "md-raised md-primary md-button-medium e2e-smsVerification_sendCode md-button ng-binding ng-isolate-scope md-ink-ripple", :index => 0)
  text_field(:zip_verification_code, :id => "verificationCode")
  button(:zip_complete_order, :css => "#smsVerification-submit", :index => 0)
  div(:zip_preloader, :class => "zip-spinner")
  div(:zip_complete_order_loader, :class => "panel ng-scope layout-align-start-center layout-column", :index => 0)
  span(:zip_create_account, :class => 'brand"', :index => 1)
  button(:zip_create_account_submit, :css => ".primary[type='submit']", :index => 0)
  links(:zip_pay_arrow, :css => "zip-panel a")
  div(:select_account_section, :css => "div.zip-panel-heading", :index => 0)
  # button(:zip_create_account_submit, :css => "#emailSignup")
  text_field(:zip_first_name, :css => "#firstName")
  text_field(:zip_last_name, :css => "#lastName")
  text_field(:zip_dob, :css => "#dateOfBirth")
  element(:zip_gender, :css => "#gender", :index => 0)
  element(:zip_select_gender, :css => "[value='Female']", :index => 0)
  text_field(:zip_address, :css => "#home")
  span(:zip_select_address, :css => "span.highlight")
  div(:zip_checkbox_over18, :css => "div[md-ink-ripple-checkbox='']")
  button(:zip_step1_create_account, :css => "#goToNextStep")
  link(:zip_skip_step, :css => "a[ng-bind='::vm.content.skip']")
  text_field(:zip_mobile_number, :css => "#mobilePhone")
  element(:zip_security_code_page, :name => "vm.mobilePhoneForm")
  button(:zip_send_code_button, :css => "body > div.layout-column.flex > md-content > div.main-content.layout-align-start-center.layout-column.flex > div > div > zip-loading > div > ng-transclude > div > div > div > zip-checkout-sms-verification > form.ng-pristine.ng-valid > div.layout-row > div.l-padding-left-medium.l-padding-top-small.layout-align-start-start.layout-column.flex > button")
  button(:zip_send_code_create_account, :class => "md-raised md-primary md-button-medium e2e-smsVerification_sendCode md-button ng-binding md-ink-ripple", :index => 0)
  button(:zip_step2_create_account, :css => "#smsVerification-submit")
  text_field(:zip_card_holder, :class =>"required payment-input card-holder", :index => 0)
  text_field(:zip_card_number, :class => "required payment-input card-type card-number card-number-logo")
  text_field(:zip_expiry_date, :class => "payment-input input-small expiry-date error")
  text_field(:zip_security_code, :class => "number payment-input security-code")
  button(:zip_complete_create_account, :class => "md-raised md-primary md-button-large md-button ng-binding md-ink-ripple loader")
  div(:zip_complete_process_loader, :css => "div.ng-scope[ng-if='vm.isPolling']")
  button(:zip_complete_purchase, :css => "#approved-continue")
  button(:zip_return_to_sandbox, :id => "referred-returnToStore")
  button(:zip_accept_contract, :css => "#acceptContract")
  link(:zip_manual_add_link, :css => "a[ng-click='vm.enterManualAddress()']")
  text_field(:zip_street_number, :id => "homeStreetNumber")
  text_field(:zip_street_name, :id => "homeStreetName")
  text_field(:zip_suburb, :id => "homeSuburb")
  text_field(:zip_postcode, :id => "homePostCode")
  element(:zip_state_dropdown, :id => "homeState")
  element(:zip_select_state, :css => "md-option[value='ACT']", :index => 0)
  button(:zip_set_address, :class => "md-primary md-button-medium md-button md-ink-ripple", :index => 0)
  button(:zip_return_to_store, :class => "md-primary md-button-large md-button ng-binding md-ink-ripple loader", :index => 0)
  button(:back_to_cottonon_sanbox, :css => "[ng-click='vm.returnToMerchant()']", :index => 0)
  button(:zip_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 2)
  button(:zip_main_menu_icon, :class => "md-icon-button headerItem-e2e-icon md-button md-reserved-theme md-ink-ripple")
  button(:zip_logout, :id => "logOut")
  button(:zip_continue_button, :class => "margin-top-lv3 md-raised md-primary md-button-large md-button ng-binding md-ink-ripple loader" )

  # QUADPAY PAGE OBJECTS
  text_field(:quadpay_phone_number, :css => "input[type='tel']", :index => 0)
  button(:quadpay_force_new_cust, :class => "v-btn v-btn--block v-btn--depressed theme--light v-size--large secondary", :index => 0)
  button(:quadpay_next_button, :class => "qp-primary v-btn v-btn--block v-btn--has-bg theme--light v-size--large")
  elements(:quadpay_verification_code, :css => "table.messagesTable td")
  # div(:quadpay_code_field, :css => "div.qp-input-code-container")
  text_field(:quadpay_code1, :id => "input-37")
  text_field(:quadpay_code2, :id => "input-38")
  text_field(:quadpay_code3, :id => "input-39")
  text_field(:quadpay_code4, :id => "input-40")
  text_field(:quadpay_code5, :id => "input-41")
  text_field(:quadpay_code6, :id => "input-42")
  text_field(:quadpay_email, :id => "input-49")
  text_field(:quadpay_fname, :id => "input-53")
  text_field(:quadpay_lname, :id => "input-56")
  text_field(:quadpay_address, :class => "pac-target-input")
  text_field(:quadpay_birth_date, :id => "birthdate")
  element(:quadpay_term_chkbx, :id => "input-71")
  button(:quadpay_create_acc, :class => "qp-primary v-btn v-btn--block v-btn--depressed theme--light v-size--large")
  text_field(:quadpay_name_card, :id => "input-100")
  text_field(:quadpay_card_number, :name => "cardnumber")
  text_field(:quadpay_card_expiry_dt, :name=> "exp-date")
  text_field(:quadpay_card_cvc, :name=> "cvc")
  # button(:quadpay_complete_order, :class => "qp-primary v-btn v-btn--block v-btn--depressed theme--light v-size--large")
  span(:quadpay_complete_order, :class => "v-btn__content")
  div(:quadpay_page_order_amt, :class => "layout justify-space-between", :index => 0)
  div(:quadpay_page_instl_amt, :class => "layout justify-space-between", :index => 1)
  button(:quadpay_back_to_cart, :css => "button.qp-primary", :index => 0)
  element(:quadpay_declined_msg, :css => "h1.qp-page-title", :index => 0)
  div(:quadpay_declined_lock_icon, :css => "div.qp-header-image-container", :index => 0)
  link(:quadpay_cross_icon, :css => "a[aria-label='Back to cart']", :index => 0)
  div(:quadpay_mobile_error, :class => "qp-validation-error")
  link(:quadpay_resend_code, :class => "qp-verify-password-action")

  # def validate_zip_page
  #   zip_order_total_element.text.gsub(/[^.0-9\-]/,"")
  # end

  def enter_verification_code_zip_page
    if zip_verification_code_element.present?
      wait_and_set_text zip_verification_code_element,'123456'
    end
  end

  def zip_continue_order_presence
    if zip_continue_order_element.present? != "true"
      return "false"
    else
      return "true"
    end
  end

  def zip_place_order_existing_user
    wait_and_click zip_continue_order_element
    $zip_order_total = zip_order_total_element.text.gsub(/[^.0-9\-]/,"")
    if zip_verification_code_element.present?
      zip_send_code_element.wait_until_present.click
      wait_and_set_text zip_verification_code_element,'123456'
    end
    wait_and_click zip_complete_order_element
  end

  def zip_login_page_presence
    zip_email_element.present?
  end

  def zip_login username, password
    Watir::Wait.while(timeout:30) {zip_preloader_element.present?}
    # Watir::Wait.until{zip_account_sign_in_element}.click
    sleep 2
    Watir::Wait.until{zip_email_element}.wait_until_present.click
    Watir::Wait.until{zip_email_element}.set username
    Watir::Wait.until{zip_password_element}.wait_until_present.click
    Watir::Wait.until{zip_password_element}.set password
    Watir::Wait.until{zip_sign_in_element}.wait_until_present.click
  end

  def zip_new_user_create_account
    wait_and_click(zip_create_account_element)
    # return @zip_order_total = zip_order_total_new_user_element.text
  end

  def zip_existing_partial_account
    sleep 5
    if (zip_pay_arrow_elements.any?).to_s == "true"
      wait_and_click(zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/})
    end
  end

  def zip_fail_existing_account_user_flow
    sleep 2
    wait_and_click(zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/})
    wait_and_click(zip_complete_create_account_element)
  end

  def zip_existing_account_user_flow
    sleep 5
    if (zip_continue_button_element.present?).to_s == "true"
      $zip_order_total = zip_order_total_element.text.gsub(/[^.0-9\-]/,"")
      wait_and_click(zip_continue_button_element)
      sleep 5
    else
      wait_and_click(zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/})
      sleep 5
      $zip_order_total = zip_order_total_element.text.gsub(/[^.0-9\-]/,"")
      wait_and_click(zip_complete_create_account_element)
    end
  end

  def zip_security_code_presence
    wait_for_ajax
    # zip_send_code_create_account_element.present?
    if (zip_security_code_page_element.present?).to_s != "true"
      return "false"
    else
      return "true"
    end
  end


  def zip_enter_security_code
    wait_and_click zip_send_code_button_element
    zip_verification_code_element.set("123456")
    wait_and_click(zip_complete_create_account_element)
  end

  def zip_select_account_presence
    return ((zip_create_account_element.present?).to_s)
    #   if (p(zip_pay_arrow_elements).present?).to_s != "true"
    #   return "false"
    # else
    #   return "true"
    # end
  end

  def zip_create_account_details arg
    sleep 2
    if arg == "Random"
      @random_word = 5.times.map{ ('a'..'z').to_a.sample }.join
      zip_email_element.set(@random_word + "@gmail.com")
      Watir::Wait.until{zip_password_element}.wait_until_present.click
      Watir::Wait.until{zip_password_element}.set("suvisuvi14")
      zip_create_account_submit_element.click
      sleep 5
      Watir::Wait.until{zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/}}.wait_until(&:present?)
      zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/}.click
      @random_firstname = 5.times.map{ ('a'..'z').to_a.sample }.join
      Watir::Wait.until{zip_first_name_element}.wait_until_present.set @random_firstname
      Watir::Wait.until{zip_last_name_element}.wait_until_present.set "APPROVETEST"
    end
    $zip_order_total = zip_order_total_new_user_element.text
    zip_dob_element.set(14081982)
    zip_gender_element.click
    zip_select_gender_element.click
    wait_and_click(zip_address_element)
    wait_and_set_text zip_address_element,"11 Wal"
    @browser.send_keys :tab
    wait_and_click(zip_manual_add_link_element)
    zip_street_number_element.set("11")
    zip_street_name_element.set("waldburg grove")
    zip_suburb_element.set("tarneit")
    zip_postcode_element.set("3029")
    wait_and_click zip_state_dropdown_element
    wait_and_click(zip_select_state_element)
    wait_and_click(zip_checkbox_over18_element)
    wait_and_click(zip_step1_create_account_element)
    wait_and_click(zip_skip_step_element)
    wait_and_set_text zip_mobile_number_element,"0400000000"
    wait_and_click zip_send_code_create_account_element
    zip_verification_code_element.set("123456")
    zip_step2_create_account_element.click
    return $zip_order_total
  end

  def zip_create_account_failed_orders arg
    sleep 2
    @random_word = 5.times.map{ ('a'..'z').to_a.sample }.join
    zip_email_element.set(@random_word + "@gmail.com")
    Watir::Wait.until{zip_password_element}.wait_until_present.click
    Watir::Wait.until{zip_password_element}.set("suvisuvi14")
    zip_create_account_submit_element.click
    Watir::Wait.until{select_account_section_element}.wait_until(&:present?)
    if (select_account_section_element.present?).to_s == "true"
      sleep 5
      p zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/}
      zip_pay_arrow_elements.find{|x| x.text =~ /Zip Pay/}.click
    end
    @random_firstname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{zip_first_name_element}.wait_until_present.set @random_firstname
    if arg == "Declined"
      @random_lastname = "DECLINETEST"
      Watir::Wait.until{zip_last_name_element}.wait_until_present.set @random_lastname
    end
    if arg == "Referral"
      @random_lastname = "REFERTEST"
      Watir::Wait.until{zip_last_name_element}.wait_until_present.set @random_lastname
    end
    zip_dob_element.set(14081982)
    zip_gender_element.click
    zip_select_gender_element.click
    wait_and_click(zip_address_element)
    wait_and_set_text zip_address_element,"11 Wal"
    @browser.send_keys :tab
    wait_and_click(zip_manual_add_link_element)
    zip_street_number_element.set("11")
    zip_street_name_element.set("waldburg grove")
    zip_suburb_element.set("tarneit")
    zip_postcode_element.set("3029")
    wait_and_click zip_state_dropdown_element
    wait_and_click(zip_select_state_element)
    wait_and_click(zip_checkbox_over18_element)
    wait_and_click(zip_step1_create_account_element)
    wait_and_click(zip_skip_step_element)
    wait_and_set_text zip_mobile_number_element,"0400000000"
    wait_and_click zip_send_code_create_account_element
    zip_verification_code_element.set("123456")
    zip_step2_create_account_element.click
  end

  def zip_new_user_card_details arg
    @random_cardholdername = 5.times.map{ ('a'..'z').to_a.sample }.join
    @iframe_card = @browser.iframe(:id => "hosted-payment-page").iframe(:id => "fzHpp").div(:id => "card")
    @iframe_card.text_field(:id => "payment_request_card_holder").set(@random_cardholdername + " bedi")
    @iframe_card.text_field(:id => "payment_request_card_number").set("4726780000001232")
    @value1 = "0"
    @value2 = "5"
    @value3 = "2023"
    @iframe_card.text_field(:id =>"payment_request_expiry_date").set(":tab + #{@value1} + #{@value2} + #{@value3}+ :tab")
    @iframe_card.text_field(:id =>"payment_request_security_code").set("123")
    @iframe_complete_button = @browser.iframe(:id => "hosted-payment-page").div(:class => "page-content")
    @iframe_complete_button.button(:class =>"md-raised md-primary md-button-large md-button ng-binding md-ink-ripple loader").click
    Watir::Wait.while(timeout:30) {zip_complete_process_loader_element.present?}
    if arg == "Random"
      Watir::Wait.until{zip_complete_purchase_element}.wait_until_present.click
      Watir::Wait.until{zip_accept_contract_element}.wait_until_present.click
    end
    if arg == "Referral"
      Watir::Wait.until{zip_return_to_sandbox_element}.wait_until_present.click
    end
    if arg == "Declined"
      Watir::Wait.until{zip_return_to_store_element}.wait_until_present.click
    end
  end

  def zip_click_browser_back
    @browser.execute_script('window.history.back();')
  end

  def zip_click_return_to_sandbox
    wait_and_click back_to_cottonon_sanbox_element
  end

  def zip_main_menu_icon
    wait_and_click zip_main_menu_icon_element
  end

  def zip_logout
    wait_and_click(zip_logout_element)
  end

  def quadpay_login_verify_mobile
    count = 0
    while quadpay_phone_number_element.value != "" && count < 20
      quadpay_phone_number_element.send_keys(:backspace)
      count += 1
    end
    # quadpay_phone_number_element.send_keys(:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace,:backspace)
    wait_and_set_text(quadpay_phone_number_element, "7015168317")
    # wait_and_click(quadpay_next_button_element)
    wait_and_click(quadpay_force_new_cust_element)
    sleep 2
    # browser = Watir::Browser.start "https://www.receivesms.co/us-phone-number/3017/"
    browser = Watir::Browser.start "https://freephonenum.com/us/receive-sms/7015168317"
    sleep 3
    browser.refresh
    # @quadpay_code = browser.elements(:class, "col-xs-12 col-md-8").find{|el| el.text =~ /Your QuadPay verification code is/}.text
    @quadpay_code = browser.elements(:css, "td").find{|el| el.text =~ /Your QuadPay verification code is/}.text
    $quadpay_code = @quadpay_code.gsub(/[^.0-9\-]/,"")
    browser.driver.switch_to.window(browser.driver.window_handles[0])
    @quadpay_code_arr = $quadpay_code.split(//)
    wait_and_set_text(quadpay_code1_element, @quadpay_code_arr[0])
    wait_and_set_text(quadpay_code2_element, @quadpay_code_arr[1])
    wait_and_set_text(quadpay_code3_element, @quadpay_code_arr[2])
    wait_and_set_text(quadpay_code4_element, @quadpay_code_arr[3])
    wait_and_set_text(quadpay_code5_element, @quadpay_code_arr[4])
    wait_and_set_text(quadpay_code6_element, @quadpay_code_arr[5])
  end

  def quadpay_verify_mobile_again
    if quadpay_mobile_error_element.present? == "true"
      wait_and_click(quadpay_resend_code_element)
      sleep 2
      browser = Watir::Browser.start "https://www.receivesms.co/us-phone-number/3017/"
      sleep 3
      browser.refresh
      @quadpay_code = browser.elements(:class, "col-xs-12 col-md-8").find{|el| el.text =~ /Your QuadPay verification code is/}.text
      $quadpay_code = @quadpay_code.gsub(/[^.0-9\-]/,"")
      browser.driver.switch_to.window(browser.driver.window_handles[0])
      @quadpay_code_arr = $quadpay_code.split(//)
      wait_and_set_text(quadpay_code1_element, @quadpay_code_arr[0])
      wait_and_set_text(quadpay_code2_element, @quadpay_code_arr[1])
      wait_and_set_text(quadpay_code3_element, @quadpay_code_arr[2])
      wait_and_set_text(quadpay_code4_element, @quadpay_code_arr[3])
      wait_and_set_text(quadpay_code5_element, @quadpay_code_arr[4])
      wait_and_set_text(quadpay_code6_element, @quadpay_code_arr[5])
    end
  end

  def quadpay_enter_personal_details user_type
    count = 0
    while quadpay_email_element.value != "" && count < 25
      quadpay_email_element.send_keys(:backspace)
      count += 1
    end
    case user_type
    when "random approved"
      @random_email = 5.times.map{ ('a'..'z').to_a.sample }.join
      quadpay_email_element.set(@random_email + "+score-5200" + "@quadpay.com")
    when "declined"
      @random_number = 5.times.map{rand(10)}.join
      quadpay_email_element.set("rcfailedscenario"+ "+score-199" + "@quadpay.com")
      # + @random_number
    end
    wait_and_set_text(quadpay_birth_date_element, "08141982")
    wait_and_click(quadpay_term_chkbx_element)
  end

  def quadpay_click_create_account
    wait_and_click(quadpay_create_acc_element)
    sleep 5
  end

  def quadpay_enter_card_details
    sleep 5
    @iframe_card_number = @browser.iframe(:title => "Secure card number input frame")
    @iframe_card_number.text_field(:name => "cardnumber").set("{42}"+"{42}"+"{42}"+"{4}"+"{2}"+"{42}"+"{42}"+"{42}"+"{42}")
    @iframe_card_exp = @browser.iframe(:title => "Secure expiration date input frame").span(:class => "InputContainer")
    @iframe_card_exp.text_field(:name => "exp-date").set("0222")
    @iframe_card_cvc = browser.iframe(:title => "Secure CVC input frame").span(:class => "InputContainer")
    @iframe_card_cvc.text_field(:name => "cvc").set("222")
    # wait_and_click(quadpay_term_chkbx_element)
  end

  def quadpay_complete_order
    wait_and_click(quadpay_complete_order_element)
  end

  def quadpay_page_order_total
    @quadpay_page_order_total = wait_and_get_text(quadpay_page_order_amt_element)
    @quadpay_page_order_total = @quadpay_page_order_total.gsub(/[^.0-9\-]/,"")
  end

  def quadpay_page_instl_amt
    @quadpay_page_instl_amt = wait_and_get_text(quadpay_page_instl_amt_element)
    @quadpay_page_instl_amt = @quadpay_page_instl_amt.gsub(/[^.0-9\-]/,"")
  end

  def get_quadpay_declined_msg
    quadpay_declined_lock_icon_element.wait_until(&:present?)
    return wait_and_get_text(quadpay_declined_msg_element)
  end

  def click_back_to_cart_declined
    quadpay_back_to_cart_element.click
    @browser.wait_until{browser.url =~ /checkout/}
  end

  def quadpay_click_cross_icon
    quadpay_cross_icon_element.div.svg.click
  end

  def zip_payment_method_presence
    return zip_cont_to_payment_btn_element.present?
  end

end

