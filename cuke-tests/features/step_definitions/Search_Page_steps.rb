When(/^I search for "(.*)" in the search text box$/) do |arg|
  on(SearchPage) do |page|
    page.enter_search_key arg
    sleep 5
  end
end

Then(/^search suggestions box populates$/) do
  on(SearchPage) do |page|
    page.wait_for_ajax
    expect(page.present_search_suggestion_box?).to be_truthy
  end
end


And(/^I click on the search magnifying glass$/) do
  on(SearchPage) do |page|
    page.click_search_icon_with_active_search_box
  end
end


Then(/^search results page for "([^"]*)" is displayed$/) do |arg|
  on(SearchPage) do |page|
    page.wait_for_ajax
    expect(page.search_result_text).to include arg
  end
end

And("I click on search text box") do
  on(SearchPage) do |page|
    page.wait_for_ajax
    page.click_search_field
  end
end

And(/^"(.*)" is displayed in recent search list$/) do |arg|
  on(SearchPage) do |page|
    expect(page.recent_search_term).to include arg
  end
end

When("I click on {string} link in recent search list") do |string|
  on(SearchPage) do |page|
    case string
      when "Clear Recent"
        page.clear_recent_link
    end
  end
end

Then("Your Recent Searches list and Clear Recent link is not displayed") do
  on(SearchPage) do |page|
    page.wait_for_ajax
    expect(page.recent_search_link).to be_falsey
  end
end

Then("I get the following search keyword-search list combination in the search text box") do |table|
  on(SearchPage) do |page|
    table.hashes.each do |row|
      page.enter_search_key row['recent_search_input_string']
      page.wait_for_ajax
      page.click_search_icon_with_active_search_box
      page.wait_for_ajax
      page.click_search_field
      page.wait_for_ajax
      expect(page.recent_search_term).to include row['recent_search_output_in_search_list'].gsub(/[\[\],\"]/,"")
    end
  end
end

Then("the clear recent link is not displayed on the search bar") do
  on(SearchPage) do |page|
    expect(page.present_clear_recent_link?).to be_falsey
  end
end

Then("the cross icon is not displayed on the search bar") do
  on(SearchPage) do |page|
    expect(page.present_cross_icon_btn?).to be_falsey
  end
end

Then("the clear recent link is displayed on the search bar") do
  on(SearchPage) do |page|
    expect(page.present_clear_recent_link?).to be_truthy
  end
end

Then("the cross icon is displayed on the search bar") do
  on(SearchPage) do |page|
    expect(page.present_cross_icon_btn?).to be_truthy
  end
end

Then("the search magnifying glass is displayed on the search bar") do
  on(SearchPage) do |page|
    expect(page.present_search_magnifying_glass?).to be_truthy
  end
end


And(/^no search result page is displayed with the message as "([^"]*)"$/) do |arg|
  on(SearchPage) do |page|
    expect((page.no_search_result_page_text).include?(arg)).to be_truthy
  end
end
