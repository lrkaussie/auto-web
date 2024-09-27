And(/^I select "([^"]*)" on PLP$/) do |arg|
  on(PLPPage) do |page|
    page.select_product arg
  end
end

When(/^user adds product "([^"]*)" from plp quick add$/) do |string|
  on(PLPPage) do |page|
    page.select_quick_add_product string
  end
end

Then(/^plp quick add modal window will show:$/) do |table|
  on(PLPPage) do |page|
    table.hashes.each do |row|
      expect(page.present_plp_qa_modal?).to be_truthy
      if row['x_button'] != nil
        on(PLPPage) do |page|
          expect(page.present_x_btn_modal_window?).to be_truthy
        end
      end
      if row['add_to_bag'] != nil
        on(PLPPage) do |page|
          expect(page.present_add_to_bag_modal_window?).to be_truthy
        end
      end
      if row['view_more_details'] != nil
        on(PLPPage) do |page|
          expect(page.present_view_more_details_modal_window?).to be_truthy
        end
      end
      if row['bnpl_text_with_price'] != nil
        on(PdpPage) do |page|
          if row['bnpl_text_with_price'] != "Not Present"
            expect(page.bnpl_msg_pdp_quick_view).to include row['bnpl_text_with_price']
          end
          if row['bnpl_text_with_price'] == "Not Present"
            expect(page.bnpl_msg_pdp_quick_view_presence).to be_falsey
          end
        end
      end
      if row['logos'] != nil
        on(PdpPage) do |page|
          if row['logos'] != "Not Present"
            page.click_see_more_link
            expect(page.afterpay_logo_pdp_quick_view).to be_truthy
            expect(page.zip_logo_pdp_quick_view).to be_truthy
            expect(page.humm_logo_pdp_quick_view).to be_truthy
            expect(page.laybuy_logo_pdp_quick_view).to be_truthy
            expect(page.latpay_logo_pdp_quick_view).to be_truthy
          end
          if row['logos'] == "Not Present"
            expect(page.afterpay_logo_pdp_quick_view).to be_falsey
            expect(page.zip_logo_pdp_quick_view).to be_falsey
          end
        end
      end
    end
  end
end

Then(/^user checks the plp quick add for "([^"]*)":$/) do |string, table|
  table.hashes.each do |row|
    if row['status'] != nil
      on(PLPPage) do |page|
        expect((page.check_quick_add_product_icon? string).to_s == row['status']).to be(true)
      end
    end
  end
end

Then(/^user checks plp quick add for "(.*)":$/) do |arg, table|
  table.hashes.each do |row|
    if row['status'] != nil
      on(PLPPage) do |page|
        expect((page.check_quick_add_product_icon? arg).to_s == row['status']).to be(true)
      end
    end
  end
end

When(/^the user clicks on "([^"]*)" on the plp quick add modal window$/) do |string|
  on(PLPPage) do |page|
    case string
      when "X"
        page.wait_for_ajax
        page.x_btn_modal_window
      when "Add to Bag"
        page.wait_for_ajax
        page.add_to_bag_modal_window
      when "View more details"
        page.wait_for_ajax
        page.view_more_details_modal_window
      when "See all colours"
        page.wait_for_ajax
        page.see_all_colours_modal_window
    end
  end
end

Then(/^the user stays on (.*) "(.*)"$/) do |arg,string|
  expect(on(Utility_Functions).return_browser_url).to include string
end

Then(/^the product is added from the quick add modal window$/) do
  on(PLPPage) do |page|
    expect(page.check_add_to_bag_btn_success_msg).to include "Added!"
  end
end

Then(/^the user lands on PDP of product "(.*)"$/) do |string|
  expect(on(Utility_Functions).return_browser_url).to include string
end

And(/^I click on Wishlist icon of the product "([^"]*)" in PLP$/) do |string|
  on(PLPPage) do |page|
    page.click_wishlist_icon_plp string
  end
end

And(/^I remove the product "([^"]*)" from Wishlist in PLP$/) do |string|
  on (PLPPage) do |page|
    page.remove_wishlist_icon_plp string
  end
end

And(/^user lands on "([^"]*)" page$/) do |arg|
  expect(@browser.url.include? arg).to be_truthy
end

Then(/^the Wishlist icon is not visible for the products in PLP$/) do |table|
  table.hashes.each do |row|
    @product = row['product']
    on(PLPPage) do |page|
      expect(page.check_wishlist_icon_plp? @product).to be_falsey
    end
  end
end

Then(/^"([^"]*)" text is displayed for Multipack on the PLP$/) do |arg|
  on(PLPPage) do |page|
    case arg
    when 'Save RRP'
      expect((page.save_text_multipack_plp) == "SAVE $9.85 off RRP").to be_truthy
    when 'Save Percent'
      expect((page.save_text_multipack_plp) == "SAVE 13% off RRP").to be_truthy
    end
  end
end

And(/^user selects the qty as "([^"]*)" on plp quick add$/) do |qty|
  on(PLPPage) do |page|
    page.select_qty_quick_view qty
  end
end

And(/^I click on Wishlist icon of the product from quick view$/) do
  on(PdpPage) do |page|
    page.add_to_wishlist_quick_view
  end
end

Then(/^shipping promo text as "([^"]*)" is displayed on "([^"]*)"$/) do |shipping_text,arg|
  on(PLPPage) do |page|
    expect((page.shipping_text_quick_view) == shipping_text).to be_truthy
  end
end

Then(/^the "([^"]*)" price of the product as "([^"]*)" displayed on plp is "([^"]*)"$/) do |arg1, arg2, arg3|
  on(PLPPage) do |page|
    case arg1
    when "list"
      expect((page.plp_list_price arg2) == arg3).to be_truthy
    when "sale"
      expect((page.plp_sale_price arg2) == arg3).to be_truthy
    when "list/sale"
      expect((page.plp_sale_price arg2) == arg3).to be_truthy
    end
  end
end

And(/^navigate to page "([^"]*)" of the plp$/) do |arg|
  on(PLPPage) do |page|
    page.plp_navigate_page arg
  end
end

And(/^user clicks Load More button "([^"]*)" times$/) do |times|
  on(PLPPage) do |page|
    page.click_load_more times
    sleep 2
  end
end