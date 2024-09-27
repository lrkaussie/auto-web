Then(/^I validate Wishlist page:$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    @status = row['presence']
    on(WishlistPage) do |page|
      if (@sku != nil) && (@status != nil)
        expect((page.sku_present? @sku).to_s == @status).to be(true)
      end
     end
  end
end

And(/^I click on "([^"]*)" link on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
  case string
  when 'Start Shopping'
   page.click_start_shopping_link
  when 'Remove all'
   page.remove_all_link
  end
end
end

And(/^I see "([^"]*)" items on the Wishlist page$/) do |string|
  on(WishlistPage) do |page|
    expect(page.number_of_items_wishlist_page.to_s).to eq string
  end
end

When(/^I click on thumbnail of product "([^"]*)" on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
    page.click_product_thumbnail string
  end
end


When(/^I click on the name of product "([^"]*)" on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
    page.click_product_name string
  end
end


And(/^I remove the products from Wishlist page$/) do |table|
  on(WishlistPage) do |page|
    table.hashes.each {|data|
      page.remove_wishlist_item data['product']
    }
  end
end

Then(/^the message "([^"]*)" is displayed on Wishlist page$/) do |arg|
  expect((on(WishlistPage).check_message_wishlist_page)== arg).to be(true)
end

And(/^the products displayed on Wishlist page are$/) do |table|
  # table is a table.hashes.keys # => [:product]
  products_on_wishlist = table.hashes.map{|data| data['product']}
  expect(on(WishlistPage).validate_products_on_wishlist products_on_wishlist).to be_truthy
end

When(/^the Add to Bag button is clicked for the product "([^"]*)" on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
  page.clicking_add_to_bag_button string
  end
end

And(/^the Wishlist page is empty$/) do
  on(WishlistPage).clear_wishlist
end

Then(/^"([^"]*)" message is displayed on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
    expect(page.added_to_bag_message).to include string
    expect(page.present_green_tick_add_to_bag?).to be_truthy
    page.wait_for_ajax
  end
end

And(/^"([^"]*)" size is selected from the size selector on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
  page.size_selection_wishlist string
  end
end

Then(/^an overlay with the message "([^"]*)" is displayed on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
    (page.check_wishlist_remove_all_overlay_message).include? string
  end
end

When(/^I click on "([^"]*)" button in the overlay on Wishlist page$/) do |string|
  on(WishlistPage) do |page|
    case string
    when "Remove all items"
      page.remove_all_items_wishlist_overlay
      page.wait_for_ajax
    when "No Thanks"
      page.no_thanks_button_wishlist_overlay
    when "X"
      page.cross_icon_wishlist_overlay
    end
  end
end

Then(/^I do not see the overlay message on Wishlist page$/) do
  on(WishlistPage) do |page|
  expect(page.remove_all_wishlist_overlay_disappear).to be_truthy
  end
end


And(/^Add to Bag button is disabled for product "([^"]*)" on Wishlist page$/) do |arg|
  on(WishlistPage) do |page|
    expect(page.verify_disabled_add_to_bag_btn_wishlist arg).to be_truthy
  end
end

And(/^the OUT OF STOCK badge is displayed on the thumbnail of product "([^"]*)" on Wishlist page$/) do |arg|
  on(WishlistPage) do |page|
    expect(page.verify_out_of_stock_badge_wishlist arg).to be_truthy
    expect(page.out_of_stock_badge_wishlist_text arg).to include "OUT OF STOCK"
  end
end

Then(/^there are no products on the Wishlist page$/) do
  on(WishlistPage) do |page|
    expect(page.number_of_products_wishlist == 0).to be(true)
  end
end


Then(/^wishlist details are$/) do |table|
  table.hashes.each do |row|
    @wishlist_present_text = row['wishlist_present_text']
    on(WishlistPage) do |page|
      if @wishlist_present_text != nil
        expect(page.get_wishlist_present_text).to include @wishlist_present_text
      end
    end
  end
end


And(/^"([^"]*)" link is not present on Wishlist page$/) do |arg|
  on(WishlistPage) do |page|
    case arg
    when 'Start Shopping'
      expect(page.start_shopping_link_presence).to be_falsey
    end
  end
end