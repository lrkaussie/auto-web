And(/^user navigates to Store Finder page$/) do
  on(StoreLocator) do |page|
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "store-finder" + "/")
  end
end

When(/^I click on the Search button on the Store Finder page$/) do
  on(StoreLocator) do |page|
    page.click_search_btn_store_finder_page
  end
end

# Given(/^I am on the "([^"]*)" site store locator$/) do |site_country|
#   on(CottonOnHomepage) do |page|
#       page.visit_site site_country
#   end
#   on(GeoPage) do |page|
#     page.click_stay_current_site
#   end
#   on(HeaderPage) do |page|
#     page.click_store_locator
#   end
#   on(StoreLocator) do |page|
#     page.assert_store_locator_title
#     page.assert_store_locator_brands_drop_down
#     page.assert_store_locator_country_drop_down
#     page.assert_store_locator_text_field
#     page.assert_store_locator_use_my_loc
#     page.assert_store_locator_search_button
#   end
# end


And(/^I leave the default brand selected as "([^"]*)"$/) do |arg|
  on(StoreLocator) do |page|
    page.assert_selected_brand arg
  end
end


And(/^I leave the default selected country as "([^"]*)"$/) do |arg|
  on(StoreLocator) do |page|
    page.assert_selected_country arg
  end
end

Then(/^the first store locator displayed has the following details:$/) do |table|
  data = table.hashes.first
  on(StoreLocator) do |page|
    expect((page.store_city) == data['store_city']).to be_truthy
    expect((page.store_name) == data['store_name']).to be_truthy
    expect((page.store_brand_name) == data['store_brand_name']).to be_truthy
  end
end

Then(/^the store locator results are:$/) do |table|
    data = table.hashes.first
    on(StoreLocator) do |page|
      page.store_city
      page.assert_store_city data['store_city']
      page.assert_store_name data['store_name']
      page.assert_store_brand_name data['store_brand_name']
    end
end

And(/^no default selected brand is displayed$/) do
  on(StoreLocator) do |page|
    expect((page.no_store_brands_selected) == 7).to be_truthy
  end
end

And(/^for "([^"]*)" selected header brand, "([^"]*)" brands are selected by default on store locator page$/) do |subsite, brands|
  on(StoreLocator) do |page|
    case subsite
    when "Cotton On"
      expect((page.store_brands_selected).to_s == brands).to be_truthy
    when "Typo", "Factorie", "Kids"
      expect((page.store_brands_selected).to_s == brands).to be_truthy
    end
  end
end

And(/^I select "([^"]*)" brand$/) do |arg|
  on(StoreLocator) do |page|
    page.select_brand arg
  end
end
