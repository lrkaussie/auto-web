Then(/^I have options on PLP to sort by "([^"]*)", "([^"]*)" and "([^"]*)"$/) do |sort1, sort2, sort3|
  on(SearchResultsOptionsPage) do |page|
    expect(page.assert_sort_by_list).to include sort1
    expect(page.assert_sort_by_list).to include sort2
    expect(page.assert_sort_by_list).to include sort3
  end
end

And(/^I have options on PLP to show "([^"]*)", "([^"]*)" and "([^"]*)"$/) do |show1, show2, show3|
  on(SearchResultsOptionsPage) do |page|
    expect(page.assert_show_by_list).to include show1
    expect(page.assert_show_by_list).to include show2
    expect(page.assert_show_by_list).to include show3
  end
end

And(/^default Show option on PLP is "([^"]*)"$/) do |def_show|
  on(SearchResultsOptionsPage) do |page|
    expect(page.default_filter_selected).to include def_show
  end
end

And(/^pagination page selected is "([^"]*)"$/) do |sel_page|
  on(SearchResultsOptionsPage) do |page|
    expect(page.current_page_selected).to include sel_page
  end
end

When(/^I select a sort value of price high to low$/) do
  on(SearchResultsOptionsPage) do |page|
    page.sort_by_dd
    page.click_high_low
  end
end

Then (/^the price decreases down the list$/) do
  on(SearchResultsOptionsPage) do |page|
    expect((page.price_sales_price 1) >= (page.price_sales_price 2)).to be(true)

  end
end

And(/^I see that the default filter is set to "([^"]*)"$/) do |selected_sort_option|
  on(SearchResultsOptionsPage) do |page|
    page.sort_by_dd
    expect(page.default_filter_selected).to include selected_sort_option
  end
end

When(/^I select a sort value of price low to high$/) do
  on(SearchResultsOptionsPage) do |page|
    page.sort_by_dd
    page.click_low_high
  end
end

Then (/^the price increases down the list$/) do
  on(SearchResultsOptionsPage) do |page|
    expect((page.price_sales_price 1) <= (page.price_sales_price 2)).to be(true)
  end
end

When(/^I select a show value of "([^"]*)"$/) do |show_option|
  on(SearchResultsOptionsPage) do |page|
    page.click_show_dd_text
    case show_option
      when "24"
        page.click_first_show_option
      when "48"
        page.click_second_show_option
      when "96"
        page.click_third_show_option
    end
    expect(page.check_url).to include show_option
  end
end

Then(/^the search results page has "([^"]*)" products$/) do |show_option|
  on(SearchResultsOptionsPage) do |page|
    expect((page.product_count_on_page).to_s == (show_option)).to be(true)
  end
end


