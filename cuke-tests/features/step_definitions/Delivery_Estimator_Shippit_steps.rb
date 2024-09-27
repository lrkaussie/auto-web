And(/^the user navigate to the checkout URL with Order Date and Time as "([^"]*)"$/) do |arg|
  on(GeoPage) do |page|
    @url_comp = "#{@country.downcase}" + "_url"
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "checkout/" + "?src=deliveryestimator_" + arg)
  end
end

Then(/^estimated delivery date is displayed as "([^"]*)" for Standard delivery$/) do |arg|
  on(CheckoutPage) do |page|
    @browser.send_keys :tab
    expect(page.standard_estimated_delivery_date).to start_with arg
  end
end

And(/^estimated delivery date is displayed as "([^"]*)" for Express delivery$/) do |arg|
  on(CheckoutPage) do |page|
    @browser.send_keys :tab
    expect(page.express_estimated_delivery_date).to start_with arg
  end
end

Then(/^estimated delivery date is displayed as "([^"]*)" for Personalised delivery$/) do |arg|
  on(CheckoutPage) do |page|
    @browser.send_keys :tab
    expect(page.personalised_estimated_delivery_date).to start_with arg
  end
end

Then(/^no estimated delivery date is displayed for "([^"]*)" Email delivery$/) do |arg|
  on(CheckoutPage) do |page|
    @browser.send_keys :tab
    expect(page.email_delivery_text).to include arg
  end
end

And(/^user clicks the Home Delivery method tab$/) do
  on(CheckoutPage) do |page|
    page.hd
    # page.registered_delivery_method_dropdown
  end
end

Then(/^estimated delivery date for the CnC store with store id as "([^"]*)" is displayed as "([^"]*)"$/) do |store_id, delivery_estimated_date|
  on(CheckoutPage) do |page|
    expect(page.cnc_store_estimated_delivery_date store_id).to include delivery_estimated_date
  end
end

And(/^the user navigate to the PDP URL of the product as "([^"]*)" with Date and Time as "([^"]*)"$/) do |sku, date|
  on(GeoPage) do |page|
    @url_comp = "#{@country.downcase}" + "_url"
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{sku}" + ".html" + "?src=deliveryestimator_" + date)
  end
end

When(/^I search for the postcode as "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
      page.delivery_enter_postcode arg
  end
end

Then(/^estimated delivery date on PDP is displayed as "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|
  on(PdpPage) do |page|
    expect(page.verify_delivery_method arg2).to start_with("#{arg1}")
  end
end

And(/^price for "([^"]*)" is displayed as "([^"]*)"$/) do |arg1, arg2|
  on(PdpPage) do |page|
    expect(page.verify_delivery_price arg1).to include(arg2)
  end
end

Then(/^"([^"]*)" text should be displayed on the pdp under "([^"]*)"$/) do |arg1, arg2|
  on(PdpPage) do |page|
    expect(page.verify_changetextbutton arg2).to include arg1
  end
end

