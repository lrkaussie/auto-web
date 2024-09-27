And(/^I click on View Cart button$/) do
  on(PdpPage) do |page|
    sleep 1
    #to_do remove above sleep to fix the auto tests which fail in jenkins
    page.click_view_cart
    @cart_items_text = page.get_cart_items_txt
  end
end

And(/^the user navigates to PDP of the product "([^"]*)"$/) do |arg|
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
  on(PdpPage) do |page|
    page.primary_image_presence
  end
end

And(/^the (.+) Stock tab is selected by default$/) do |arg|
  on(PdpPage) do |page|
    expect(page.verify_active_tab(arg)).to include "active"
  end
end


And(/^the user navigates to (.+) tab$/) do |arg|
  on(PdpPage) do |page|
    page.select_stock_tab(arg)
  end
end

When(/^the user searches for stock in stores by postcode(\s*\d*)$/) do |arg|
  arg = arg.gsub("^ .","")
  on(PdpPage) do |page|
    page.search_for_store_stock(arg.to_i)
  end
end

When(/^the user searches for stock in stores by suburb "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
    page.search_for_store_stock(arg)
  end
end

Then(/^the stores are listed with In Store Stock Status$/) do |table|
  on(PdpPage) do |page|
    table.hashes.each do |data|
      expect(page.validate_stock_status(data['store_no'])).to include data['stock_status']
    end
  end
end


And(/^the postcode (\d+) is prefilled$/) do |arg|
  on(PdpPage) do |page|
    expect(page.verify_prefilled_postcode(arg.to_s)).to include arg.to_s
  end
end

And(/^the suburb "([^"]*)" is prefilled$/) do |arg|
  on(PdpPage) do |page|
    expect(page.verify_prefilled_suburb(arg.to_s)).to include arg.to_s
  end
end

Then(/^"([^"]*)" message should be displayed in PDP success message$/) do |arg|
  on(PdpPage) do |page|
    expect(page.check_pdp_success_msg_txt).to include arg
  end
end

Then(/^"([^"]*)" message should be displayed in My Bag$/) do |arg|
  on(MinicartPage) do |page|
    page.click_mini_cart_icon
  end

  on(MybagPage) do |page|
    expect(page.check_mybag_shipping_msg).to include arg
  end

end

And(/^the user selects the color "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
  page.select_variation_group(arg.upcase)
    end
end

And(/^the user selects the online size "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
    page.select_online_size(arg)
  end
end

And(/^the In-Store size "([^"]*)" is selected by default$/) do |arg|
  on(PdpPage) do |page|
    expect(page.verify_instore_selected_size(arg)).to include "selected"
  end
end

And(/^the user selects the In\-Store size "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
    page.select_instore_size(arg)
  end
end

Then(/^the online size "([^"]*)" is still selected$/) do |arg|
  on(PdpPage) do |page|
    expect(page.verify_online_selected_size(arg)).to include "selected"
  end
end

And(/^the stores are of type "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
    (1..10).each {|index| expect(page.verify_store_type(index.to_i-1)).to eql arg}
  end
end

Then(/^the number of stores displayed is (\d+)$/) do |arg|
  on(PdpPage) do |page|
    expect(page.verify_no_of_stores_displayed).to eq arg
  end
end

And(/^I select my preferred store as "([^"]*)" and store code is "([^"]*)"$/) do |store_city, store_code|
  on(PdpPage) do |page|
    page.click_online_tab
    page.click_cnc_accordian
    page.enter_cnc_store_city store_city
    # page.store_search_button_pdp
  end
  on(CheckoutPage) do |page|
    page.click_store store_code
  end
  on(PdpPage) do |page|
    page.set_preferred_cnc_store
  end
end

Then(/^I land on the pdp page for "([^"]*)"$/) do |arg|
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include arg
  end
end

And(/^I click on Wishlist on PDP page$/) do
  on(PdpPage) do |page|
    page.click_wishlist_pdp
  end
end

And(/^I land on SignIn page$/) do
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include "sign-in"
  end
end

And(/^(?:I|the user) navigates? to Wishlist page$/) do
  on(MybagPage) do |page|
    sleep 2
    page.wait_for_ajax
    page.wishlist_header_link
    page.wait_for_ajax
  end
end

And(/^I add test products products to bag$/) do
  @site_country = Orderinfo.get_orderinfo['site']
  @sku_id = Orderinfo.get_orderinfo['products']
  @qty = Orderinfo.get_orderinfo['qty']
  @coupons_bag = Orderinfo.get_orderinfo['coupons_bag']
  @vouchers_bag = Orderinfo.get_orderinfo['vouchers_bag']
  @vouchers_checkout = Orderinfo.get_orderinfo['vouchers_checkout']
  @gift_card_nos = Orderinfo.get_orderinfo['gift_card_no']
  @gift_card_pins = Orderinfo.get_orderinfo['gift_card_pin']

  index = 0
  counter = 1
  @sku_id.length.times do
    visit(CottonOnHomepage, using_params: {site_country: @site_country, sku_id: @sku_id[index]})
    on(GeoPage) do |page|
      @popup_box_present = (page.check_geo_popup_box_present?)
      if (@site_country != 'au' && @popup_box_present)
        while counter < 2
          counter = counter + 2
          page.click_stay_current_site
        end
      end
    end
    @qty[index].times do
      on(PdpPage).click_add_to_bag
    end
    index = index+1
  end
  on(MinicartPage) do |page|
    page.click_mini_cart_icon
  end
  if @coupons_bag.length != 0
    on(MybagPage) do |page|
      @coupons_bag.each {|coupon|
        page.apply_promo_code coupon
      }
    end
  end
  if @vouchers_bag.length != 0
    on(MybagPage) do |page|
      @vouchers_bag.each {|voucher|
        page.apply_promo_code voucher
      }
    end
  end
  on(MybagPage).bag_checkout
end

And(/^the user clicks on Add to Bag from the PDP$/) do
  on(PdpPage) do |page|
    page.click_add_to_bag
  end
end

Then(/^I validate pdp page:$/) do |table|
  table.hashes.each do |row|
    @size_sel = row['size_selection']
      on(PdpPage) do |page|
        if @size_sel != nil
          expect(page.size_not_selected_err_msg).to eq @size_sel
        end
      end
  end
end

Then(/^on pdp page user sees the (.*)$/) do |arg|
  on(PdpPage) do |page|
    expect(page.get_stock_msg).to eq arg
  end
end

And(/^the user clicks "([^"]*)" tab on pdp page$/) do |arg|
  on(PdpPage) do |page|
    page.click_tab_pdp arg
  end
end

And(/^the user doesn't see the instock message on pdp page$/) do
  on(PdpPage) do |page|
    expect(page.present_stock_msg?).to be_falsey
  end
end


And(/^(?:user|I) navigates? to bag page by clicking the minicart icon$/) do
  on(MinicartPage) do |page|
    page.click_mini_cart_icon
  end
end

Then(/^I validate the selected colour "([^"]*)" on the PDP page$/) do |string|
  on(PdpPage) do |page|
  page.wait_for_ajax
  expect(page.selected_colour string).to be_truthy
 end
end

And(/^I add the products to Wishlist from PDP page$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    on(GeoPage) do |page|
      @url_comp = "#{@country.downcase}" + "_url"
      page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
    end
    on(PdpPage) do |page|
      page.wait_for_ajax
      page.click_wishlist_pdp
    end
  end
end

When(/^I remove the products on Wishlist from PDP page$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    on(GeoPage) do |page|
      @url_comp = "#{@country.downcase}" + "_url"
      page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
    end
    on(PdpPage) do |page|
      page.wait_for_ajax
      page.click_wishlist_pdp
    end
  end
end


Then(/^the Wishlist icon is not visible on PDP of the product "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
    expect(page.present_wishlist_link?).to be_falsey
  end
end

And(/^refresh the PDP page of the product with sku as "([^"]*)"$/) do |sku|
  on(GeoPage) do |page|
    @url_comp = "#{@country.downcase}" + "_url"
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{sku}" + ".html")
  end
  on(PdpPage) do |page|
    page.refresh_pdp_page
  end
end

Then(/^"([^"]*)" button is displayed on the pdp sucess message overlay$/) do |arg|
    on(PdpPage) do |page|
      expect(page.verify_viewbagButton).to include(arg)
    end
end

When(/^I click on the View Bag button on PDP success message overlay$/) do
  on(PdpPage) do |page|
    page.click_viewbagButton
  end
end

Then(/^"([^"]*)" button is displayed on the pdp success message overlay with "([^"]*)"$/) do |arg1, arg2|
  on(PdpPage) do |page|
    expect(page.continue_shopping_button_presence).to be_truthy
  end
end

And(/^the user navigates to PDP of the product "([^"]*)" with parameters as "([^"]*)"$/) do |arg1, arg2|
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  on(GeoPage) do |page|
    @url_comp = "#{@country.downcase}" + "_url"
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{arg1}" + ".html?" + "#{arg2}" )
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

Then(/^the bnpl logos should be displayed on the pdp$/) do
  on(PdpPage) do |page|
    page.click_see_more_link
    expect(page.afterpay_logo_pdp_quick_view).to be_truthy
    expect(page.zip_logo_pdp_quick_view).to be_truthy
    expect(page.humm_logo_pdp_quick_view).to be_truthy
    expect(page.laybuy_logo_pdp_quick_view).to be_truthy
    expect(page.latpay_logo_pdp_quick_view).to be_truthy
  end
end

Then(/^the bnpl tagline is displayed as "([^"]*)" on the pdp$/) do |arg|
  on(PdpPage) do |page|
    expect(page.bnpl_msg_pdp_quick_view).to include arg
  end
end

Then(/^the bnpl tagline is not displayed for physical gift card on the pdp$/) do
  on(PdpPage) do |page|
    expect(page.bnpl_msg_pdp_quick_view_presence).to be_falsey
  end
end

Then(/^the "([^"]*)" modal window is displayed on clicking the logo$/) do |arg|
  on(PdpPage) do |page|
    page.click_see_more_link
    case arg
      when 'afterpay'
        expect(page.afterpay_modal_window_presence).to be_truthy
      when 'zip'
        expect(page.zip_modal_window_presence).to be_truthy
      when 'humm'
        expect(page.humm_modal_window_presence).to be_truthy
      when 'laybuy'
        expect(page.laybuy_modal_window_presence).to be_truthy
      when 'latpay'
        expect(page.latpay_modal_window_presence).to be_truthy
    end
  end
end

Then(/^"([^"]*)" text is displayed for Multipack on the PDP$/) do |arg|
  on(PdpPage) do |page|
    case arg
    when 'Save RRP'
      expect((page.save_text_multipack_pdp) == "Save $9.85 off RRP").to be_truthy
    when 'Save Percent'
      expect((page.save_text_multipack_pdp) == "Save 13% off RRP").to be_truthy
    end
  end
end

And(/^the user navigates to PDP of the product with master as "([^"]*)" and VG as "([^"]*)"$/) do |arg1, arg2|
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  on(GeoPage) do |page|
    @url_comp = "#{@country.downcase}" + "_url"
    page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "show-variation/?pid=#{arg1}" + "&dwvr" + "_#{arg1}_color=#{arg2}" + "&originalPid=#{arg2}")
    @popup_box_present = (page.check_geo_popup_box_present?)
    if (@country != 'AU' && @popup_box_present)
      while @counter < 2
        @counter = @counter + 2
        page.click_stay_current_site
      end
    end
  end
end

Then(/^"([^"]*)" sizes should be displayed on the PDP$/) do |arg|
  on(PdpPage) do |page|
    expect(page.number_of_sizes_displayed == arg).to be_truthy
  end
end

Then(/^"([^"]*)" unavailable sizes should be displayed on the PDP$/) do |arg|
  on(PdpPage) do |page|
    expect(page.unavailable_sizes == arg).to be_truthy
  end
end

And(/^the user navigates to PDP of the product "([^"]*)" which does not exist$/) do |arg|
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
end

Then(/^selected store in the browser session is with the store name as "([^"]*)"$/) do |arg|
  on(PdpPage) do |page|
    expect(page.selected_cnc_store_presence == false).to be_truthy
    expect(page.selected_cnc_store_name == arg).to be_truthy
  end
end

And(/^I change my preferred store as "([^"]*)" and store code is "([^"]*)"$/) do |arg1, arg2|
  on(PdpPage) do |page|
    page.click_online_tab
    page.change_cnc_store arg1
    # page.enter_cnc_store_city arg1
  end
  on(CheckoutPage) do |page|
    page.click_store arg2
  end
  on(PdpPage) do |page|
    page.set_preferred_cnc_store
  end
end

Then(/^"([^"]*)" size is displayed on the pdp$/) do |arg|
  on(PdpPage) do |page|
    if arg == "No"
      expect((page.size_class_text).include?("hide")).to be_truthy
    end
    if arg == "ONE SIZE"
      expect((page.size_class_text).include?("hide")).to be_falsey
      expect((page.sizes_online_text(0)) == arg).to be_truthy
    end
    if arg == "ONE SIZE/OSFA"
      expect((page.sizes_online_class_text(0).include?("hide")) == false).to be_truthy
      expect((page.sizes_online_class_text(1).include?("hide")) == false).to be_truthy
      expect((page.sizes_online_text(0)) == "ONE SIZE").to be_truthy
      expect((page.sizes_online_text(1)) == "OSFA").to be_truthy
    end
  end
end

Then(/^the "([^"]*)" price of the product displayed on pdp should be "([^"]*)"$/) do |arg1, arg2|
  on(PdpPage) do |page|
    case arg1
    when "list/sale"
      expect(page.pdp_sale_price == arg2).to be_truthy
    when "list"
      expect(page.pdp_list_price == arg2).to be_truthy
    when "sale"
      expect(page.pdp_sale_price == arg2).to be_truthy
    end
  end
end