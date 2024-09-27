When(/^I am in "([^"]*)"$/) do |arg|
  on(GeoPage) do |page|
		page.check_user_location arg
  end			 
end


Then (/^the geolocation popup is present$/) do
	on(GeoPage) do |page|
		page.check_geo_popup_box_present?
	end
end


Then(/^the Big flag is for "([^"]*)"$/) do |arg|
  on(GeoPage) do |page|
		page.check_big_flag_present? arg
	end
end

And(/^I check the warning message "([^"]*)"$/) do |arg|
  on(GeoPage) do |page|
		page.check_geo_popup_box_message arg
  end			 
end


And (/^I see the "([^"]*)" site button$/) do |arg|
	on(GeoPage) do |page|
		page.go_to_oz_btn arg
	end
end

And (/^I can see the "([^"]*)" link$/) do |arg|
	on(GeoPage) do |page|
		page.stay_on_nz_link arg
	end
end


Then (/^I can see all the countries listed in the geolocation popup$/) do
	on(GeoPage) do |page|
		page.small_flag_checks
	end
end


Then(/^countries listed are: "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5, arg6|
  on(GeoPage) do |page|
		page.small_flag_checks arg1, arg2, arg3, arg4, arg5, arg6
	end
end