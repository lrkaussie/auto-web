require 'page-object'
require 'page-object/page_factory'
class SignInPage
  include PageObject

  text_field(:email_add, :id => /dwfrm_login_username/)
  text_field(:pass, :css => "input[type='password']")
  button(:sign_me_in, :css => '.sign-me-in')


  def enter_email email_address
    (email_add == "")? Watir::Wait.until {email_add_element}.set(email_address):return
  end

  def enter_pass password
    Watir::Wait.until {pass_element}.set(password)
  end

  def click_sign_me_in
    Watir::Wait.until {sign_me_in_element}.wait_until_present.click
  end

end