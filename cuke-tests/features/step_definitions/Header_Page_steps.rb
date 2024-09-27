When(/^I click on the "([^"]*)" brand link on the header$/) do |arg|
  on(HeaderPage) do |page|
  		page.click_brand_link arg
  end	
end

Then(/^I am directed to the "([^"]*)"$/) do |arg|
  on(HeaderPage) do |page|
  		page.assert_brand_page arg
  end
end