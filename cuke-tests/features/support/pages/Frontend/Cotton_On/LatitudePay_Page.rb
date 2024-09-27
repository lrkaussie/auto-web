require 'page-object'
require 'Watir'
require 'page-object/page_factory'
require_relative '../../../../../features/support/utils'

class Latitude_Page
  include PageObject
  include Utilities
  link(:latpay_login_tab, :css => "a[href='#login']", :index => 0)
  text_field(:latpay_login_email, :id => "loginEmail")
  text_field(:latpay_login_password, :id => "loginPassword")
  button(:latpay_sign_in, :class => "btn btn-primary btn-block btn-submit", :index => 0)
  link(:latpay_sign_up, :css => "a[href='#register']", :index => 0)
  text_field(:latpay_email_sign_up, :id => "registerEmail")
  text_field(:latpay_mobile_sign_up, :id => "registerPhoneNumber")
  button(:latpay_verify_sign_up, :class => "btn btn-primary btn-block btn-submit verify", :index => 0)
  text_fields(:latpay_verify_code, :class => "auth-code-field")
  button(:latpay_final_verify_sign_up, :class => "btn btn-primary btn-block btn-submit submit-verification", :index => 0)
  text_field(:latpay_first_name, :id => "inputFirstName")
  text_field(:latpay_surname, :id => "inputSurname")
  text_field(:latpay_date_dob, :class => "gen-date-field day")
  text_field(:latpay_month_dob, :class => "gen-date-field month")
  text_field(:latpay_year_dob, :class => "gen-date-field year")
  link(:latpay_address_manually, :id => "enterAddressManually")
  text_field(:latpay_address_line, :id =>"inputAddressLine1_0")
  text_field(:latpay_suburb, :id => "locality_0")
  element(:latpay_state, :id => "administrative_area_level_1_0")
  element(:latpay_state_option, :css => "#administrative_area_level_1_0 option[value='Victoria']")
  text_field(:genoapay_state, :css => "#administrative_area_level_1_0", :index => 0)
  text_field(:latpay_postcode, :id => "postal_code_0")
  button(:latpay_continue, :id => "continue")
  div(:latpay_spinner, :class => "application-processing-wrapper")
  text_field(:latpay_driver_licence, :id => "inputDriversLicenseNumber")
  select_list(:latpay_driver_licence_soi, :css => "#driversLicenseStateOfIssue", :index => 0)
  text_field(:genoapay_driver_licence_version, :id => "inputDriversLicenseVersion")
  div(:latpay_blank_click, :css => "div.spacing", :index => 0)
  # element(:latpay_driver_licence_state, :css => "driversLicenseStateOfIssue option[value='VIC']")
  element(:latpay_driver_licence_state, :css => "option[value='VIC']")
  checkbox(:latpay_agree_first, :id => "externalCreditConsent")
  checkbox(:latpay_agree_second, :id => "australianGovernmentConsent")
  button(:latpay_proceed, :class => "btn btn-primary", :index => 1)
  button(:latpay_add_card, :class => "btn btn-primary do-change-payment-method")
  text_field(:latpay_card_number, :name => "CardNumber")
  text_field(:latpay_card_holder_name, :name => "CardHolderName")
  select_list(:latpay_expiry_date, :id => "DateExpiry_1")
  element(:latpay_expiry_date_option, :css => "option[value='12']")
  select_list(:latpay_expiry_year, :id => "DateExpiry_2")
  text_field(:latpay_cvc, :name => "Cvc2")
  button(:latpay_card_submit, :name => "Add")
  text_field(:genoapay_card_number, :id => "input_cn")
  text_field(:genoapay_card_holder_name, :id => "input_cardname")
  text_field(:genoapay_expiry_date, :id => "input_expiry")
  text_field(:genoapay_cvc, :id => "input_cvv")
  button(:genoapay_card_submit, :id => "btn_card_submit")
  span(:latpay_page_order_total, :class => "amount", :index => 0)
  span(:latpay_page_instl_amt, :class => "amount", :index => 10)
  checkbox(:latpay_final_agree, :id => "checkboxInput")
  button(:latpay_pay, :id => "setupPayments")
  link(:latpay_cross_link, :class => "closeIcon hide-on-submit", :index => 0)
  link(:latpay_return_to_merchant_sign_up, :class => "btn-link", :index => 0)
  text_field(:genoapay_3D_password, :name => "password", :index => 0)
  element(:genoapay_3D_submit, :name => "Submit", :index => 0)


  def latpay_create_account_details
    wait_and_click(latpay_sign_up_element)
    @random_word = 5.times.map{ ('a'..'z').to_a.sample }.join
    latpay_email_sign_up_element.set(@random_word + "@gmail.com")
    @random_number = 5.times.map{ ('0'..'9'). to_a.sample }.join
    latpay_mobile_sign_up_element.set("04915" + @random_number )
    latpay_verify_sign_up_element.click
    sleep 2
    latpay_verify_code_elements[0].set(0)
    latpay_verify_code_elements[1].set(0)
    latpay_verify_code_elements[2].set(0)
    latpay_verify_code_elements[3].set(0)
    latpay_final_verify_sign_up_element.click
    @random_firstname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{latpay_first_name_element}.wait_until_present.set @random_firstname
    @random_surname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{latpay_surname_element}.wait_until_present.set @random_surname
    latpay_date_dob_element.set(14)
    latpay_month_dob_element.set("08")
    latpay_year_dob_element.set(1982)
    latpay_address_manually_element.click
    wait_and_set_text latpay_address_line_element,"11 waldburg grove"
    latpay_suburb_element.set("tarneit")
    latpay_postcode_element.set("3029")
    latpay_state_element.click
    latpay_state_option_element.click
    latpay_continue_element.click
  end

  def genoapay_create_account_details
    wait_and_click(latpay_sign_up_element)
    @random_word = 5.times.map{ ('a'..'z').to_a.sample }.join
    latpay_email_sign_up_element.set(@random_word + "@gmail.com")
    @random_number = 5.times.map{ ('0'..'9'). to_a.sample }.join
    latpay_mobile_sign_up_element.set("022222" + @random_number )
    latpay_verify_sign_up_element.click
    latpay_verify_code_elements[0].set(0)
    latpay_verify_code_elements[1].set(0)
    latpay_verify_code_elements[2].set(0)
    latpay_verify_code_elements[3].set(0)
    latpay_final_verify_sign_up_element.click
    @random_firstname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{latpay_first_name_element}.wait_until_present.set @random_firstname
    @random_surname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{latpay_surname_element}.wait_until_present.set @random_surname
    latpay_date_dob_element.set(14)
    latpay_month_dob_element.set("08")
    latpay_year_dob_element.set(1982)
    latpay_address_manually_element.click
    wait_and_set_text latpay_address_line_element,"97 Corbett-Scott Avenue"
    latpay_suburb_element.set("Epsom")
    latpay_postcode_element.set("1023")
    genoapay_state_element.set("AUK")
    latpay_continue_element.click
  end

  def latpay_driver_licence_details
    latpay_spinner_element.wait_until_present
    wait_and_set_text latpay_driver_licence_element, "AB123456"
    wait_and_select_option(latpay_driver_licence_soi_element, "VIC")
    wait_and_click(latpay_agree_first_element)
    wait_and_click(latpay_agree_second_element)
    latpay_proceed_element.click
  end

  def genoapay_driver_licence_details
    latpay_spinner_element.wait_until_present
    wait_and_set_text latpay_driver_licence_element, "AB123456"
    wait_and_set_text(genoapay_driver_licence_version_element, "111")
    latpay_proceed_element.click
  end

  def latpay_add_card_details
    wait_and_click(latpay_add_card_element)
    wait_and_set_text latpay_card_number_element, "4111 1111 1111 1111"
    wait_and_set_text latpay_card_holder_name_element, "vincy"
    latpay_expiry_date_element.click
    latpay_expiry_date_option_element.click
    latpay_cvc_element.set("111")
    wait_and_click(latpay_card_submit_element)
  end

  def genoapay_add_card_details
    wait_and_click(latpay_add_card_element)
    wait_and_set_text genoapay_card_number_element, "4111 1111 1111 1111"
    wait_and_set_text genoapay_card_holder_name_element, "vincy"
    wait_and_set_text genoapay_expiry_date_element, "1221"
    genoapay_cvc_element.set("111")
    wait_and_click(genoapay_card_submit_element)
  end

  def genoapay_3D_security
    if genoapay_3D_password_element.present?
      wait_and_set_text genoapay_3D_password_element, "secret"
      wait_and_click(genoapay_3D_submit_element)
    end
  end

  def latpay_pay_order
    wait_and_click(latpay_final_agree_element)
    wait_and_click(latpay_pay_element)
  end

  def latpay_page_instl_amt
    wait_and_get_text(latpay_page_instl_amt_element).gsub(/[^.0-9\-]/,"")
  end

  def latpay_page_order_total
    $latpay_page_order_total = wait_and_get_text(latpay_page_order_total_element).gsub(/[^.0-9\-]/,"")
  end

  def click_latpay_browser_back
    @browser.execute_script('window.history.back();')
    @url = browser.url
    if(@url =~ /bagpage=true/)
      return true
    else
      @browser.execute_script('window.history.back();')
    end
  end

  def latpay_login_exisitng_user
    wait_and_click(latpay_login_tab_element)
    wait_and_set_text(latpay_login_email_element, "cottononqa+latpayacc@gmail.com")
    wait_and_set_text(latpay_login_password_element, "Cottononqa123")
    wait_and_click(latpay_sign_in_element)
    if latpay_final_verify_sign_up_element.present?
      latpay_verify_code_elements[0].set(0)
      latpay_verify_code_elements[1].set(0)
      latpay_verify_code_elements[2].set(0)
      latpay_verify_code_elements[3].set(0)
      latpay_final_verify_sign_up_element.click
    end
  end

  def genoapay_login_exisitng_user
    wait_and_click(latpay_login_tab_element)
    wait_and_set_text(latpay_login_email_element, "cottononqa+genoapayacc@gmail.com")
    wait_and_set_text(latpay_login_password_element, "Cottononqa123")
    wait_and_click(latpay_sign_in_element)
    if latpay_final_verify_sign_up_element.present?
      latpay_verify_code_elements[0].set(0)
      latpay_verify_code_elements[1].set(0)
      latpay_verify_code_elements[2].set(0)
      latpay_verify_code_elements[3].set(0)
      latpay_final_verify_sign_up_element.click
    end
  end

  def latpay_click_cross_link
    wait_and_click(latpay_cross_link_element)
  end

  def latpay_return_to_merchant_link
    wait_and_click(latpay_return_to_merchant_sign_up_element)
  end

  def latpay_create_acc_to_return_merchant_link
    wait_and_click(latpay_sign_up_element)
    @random_word = 5.times.map{ ('a'..'z').to_a.sample }.join
    latpay_email_sign_up_element.set(@random_word + "@gmail.com")
    @random_number = 5.times.map{ ('0'..'9'). to_a.sample }.join
    latpay_mobile_sign_up_element.set("04915" + @random_number )
    latpay_verify_sign_up_element.click
    latpay_verify_code_elements[0].set(0)
    latpay_verify_code_elements[1].set(0)
    latpay_verify_code_elements[2].set(0)
    latpay_verify_code_elements[3].set(0)
    latpay_final_verify_sign_up_element.click
    @random_firstname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{latpay_first_name_element}.wait_until_present.set @random_firstname
    @random_surname = 5.times.map{ ('a'..'z').to_a.sample }.join
    Watir::Wait.until{latpay_surname_element}.wait_until_present.set @random_surname
    latpay_date_dob_element.set(14)
    latpay_month_dob_element.set("08")
    latpay_year_dob_element.set(1982)
    latpay_address_manually_element.click
    wait_and_set_text latpay_address_line_element,"11 waldburg grove"
    latpay_suburb_element.set("tarneit")
    latpay_postcode_element.set("3029")
    latpay_state_element.click
    latpay_state_option_element.click
  end
end