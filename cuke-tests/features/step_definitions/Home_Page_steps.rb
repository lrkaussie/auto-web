	Given(/^I am on the Cotton On Home Page$/) do
		visit(CottonOnHomepage)
	end

	And (/^I click on the geolocation popup link to stay on the current site$/) do
		on(GeoPage) do |page|
			page.click_stay_current_site
		end
  end

	Given(/^I am on the "([^"]*)" site "([^"]*)" category "([^"]*)" subcategory page$/) do |site_country, cat, subcat|
		on(CottonOnHomepage) do |page|
			page.visit_site site_country
				on(GeoPage) do |page|
					page.click_stay_current_site
    		end
      page.navigate_to("#{FigNewton.nz_url}"+ cat+ "/" + subcat )
		end
  end

  Given(/^I navigate to website to place test orders$/) do
		@site_country = Orderinfo.get_orderinfo['site']
  end

	And(/^I search for "([^"]*)"$/) do |search_key|
		on(SearchPage) do |page|
      page.enter_search_key search_key
      page.click_search_icon_with_active_search_box
    end
  end

  When(/^I navigate to PDP of the product (.*)$/) do |arg|
    @wait_for_page_to_load = Utility_Functions.new(@browser)
    on(GeoPage) do |page|
      @url_comp = "#{@country.downcase}" + "_url"
      page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{arg}" + ".html")
      @popup_box_present = (page.check_geo_popup_box_present?)
      if (@country != 'AU' && @popup_box_present)
        while @counter < 2
          @counter = @counter + 2
          page.click_stay_current_site
        end
      end
    end
    @wait_for_page_to_load.page_wait
  end

  Then(/^I land on homepage$/) do
    on(CottonOnHomepage) do |page|
      expect(page.landing_on_homepage).to be_truthy
    end
  end

  And(/^I logout from the site$/) do
    on(CottonOnHomepage) do |page|
      page.user_initials
      page.wait_for_ajax
      page.sign_out
    end
  end

  And(/^the highlighted brand tile is of subsite "([^"]*)" and brand "([^"]*)"$/) do |subsite, brand|
    on(CottonOnHomepage) do |page|
      expect(page.get_subsite_name).to be_truthy
      expect(page.get_brand_name).to be_truthy
    end
  end

  And(/^the highlighted brand tile is of subsite "([^"]*)"$/) do |arg|
    on(CottonOnHomepage) do |page|
      expect((page.get_subsite_name) == arg).to be_truthy
    end
  end

  And(/^Navigate to the brand "([^"]*)"$/) do |brand|
    on(CottonOnHomepage) do |page|
      page.select_brand_tile brand
    end
  end