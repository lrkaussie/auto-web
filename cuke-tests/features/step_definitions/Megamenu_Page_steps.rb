	When(/^I click on the Women category in the menu$/) do
		on(MegamenuPage) do |page|
			page.click_women_cat
		end
	end

	And (/^I click on the Tops Women subcategory$/) do
		on(MegamenuPage) do |page|
			page.click_tops_subcat
		end
	end

	Then(/^The Tops Women subcategory page is loaded$/) do
		on(MegamenuPage) do |page|
			page.assert_tops_women_sub
		end
	end

	When(/^I go to the "([^"]*)" Category$/) do |cat|
		@category = MegamenuPage.new(@browser)
		@category.cat_women
  end

  And(/^I go to the "([^"]*)" subcategory page$/) do |subcat|
		@sub_category = MegamenuPage.new(@browser)
		@sub_category.sub_cat_tops_custom
	end


