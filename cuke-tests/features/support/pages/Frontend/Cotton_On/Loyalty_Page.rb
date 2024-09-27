require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'

class LoyaltyPage
  include PageObject

  div(:cta_description, :css => '.homepage-clicktoactiavte-description')
  div(:cta_expiry, :css => '.expiration-days')

  def rewards_popup_description
    sleep 2
    @browser.wait_until{cta_description_element.parent.when_present.parent.style =~ /block/i}
    return cta_description_element.text.gsub(/[^$,.A-Za-z0-9]/," ")
    end

  def rewards_popup_expiration
    @browser.wait_until{cta_description_element.parent.when_present.parent.style =~ /block/i}
    return cta_expiry_element.text.gsub(/[^$,.A-Za-z0-9]/," ")
  end

end