Given(/^the textbox to enter email is "([^"]*)"$/) do |is_visible|
  on(CottonOnHomepage) do |page|
    page.check_email_field(is_visible)
  end
end

Given(/^Join button is visible$/) do
  on(CottonOnHomepage) do |page|
    page.is_join_button_visible
  end
end


Given(/^sliding popup is click$/) do
  on(CottonOnHomepage) do |page|
    page.subscribe_popup
  end
end