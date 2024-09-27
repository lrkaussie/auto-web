require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'

class IpayPage
  include PageObject
  include Utilities

  a(:success_response_link, :css => '.btn-success')
  a(:cancel_response_link, :css => '.btn-danger')

  def click_success_response
    wait_and_click success_response_link_element
  end

  def click_cancel_response
    wait_and_click cancel_response_link_element
  end

end