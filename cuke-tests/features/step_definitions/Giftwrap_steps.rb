And(/^I select "([^"]*)" page$/) do |arg|
  on(Gift_Wrap) do |page|
    page.giftwrap_dd_click
    page.start_wrapping_btn_click
    expect((page.assert_gift_page).to_s).to include arg.to_s
    expect(page.assert_gift_wrap_title_items).to include arg
    @assert_items_section = page.assert_add_your_items_section
    expect(@cart_items_text).to match /["#{@assert_items_section}"]+/
  end
end

And(/^I select "([^"]*)" from Choose your Gift Bag section$/) do |arg|
  on(Gift_Wrap) do |page|
    page.select_giftbag arg
  end
end

And(/^I add the following products with quantity to it from Add your items section$/) do |table|
  @count = 0
  table.hashes.each do |row|
    @qty = (row['qty']).to_i
    for i in 1..(@qty) do
      on(Gift_Wrap) do |page|
        #need to get rid of the sleep at a later stage as wait_for_ajax is not working well here
        sleep 5
        page.click_basket_line_items @count
        sleep 5
        @qty+= 1
      end
    end
    @count+= 1
  end
end

And(/^I see the products selected starts adding to Your Gift Bag is looking good! section$/) do
  on(Gift_Wrap) do |page|
    page.gift_wrap_items_txt
  end
end

And(/^I see the following products added in Your Gift Bag is looking good! section$/) do |table|
  table.hashes.each do |row|
    @title = row['title']
    @qty = row['qty']
    on(Gift_Wrap) do |page|
      expect(page.gift_wrap_items_txt).to include "#{@title}", "#{@qty}"
    end
  end
end

And(/^I enter the following text in Make it a Gift page$/) do |table|
  table.hashes.each do |row|
    @to = row['To']
    @from = row['From']
    @opt_msg = row['Message']
    on(Gift_Wrap) do |page|
      page.enter_to_msg @to
      page.enter_from_msg @from
      page.enter_opt_msg_txt @opt_msg
    end
  end
end

When(/^I hit I'm done Create my Gift! button$/) do
  on(Gift_Wrap) do |page|
    page.click_create_my_gift_btn
  end
  on(MybagPage) do |page|
    expect(page.assert_my_bag_page_url).to include 'bag'
  end
end

And(/^I started creating (.*)$/) do |giftbag_status|
  on(Gift_Wrap) do |page|
    case giftbag_status
      when 'No gift bag selected'
        page.click_basket_line_items 0
      when 'No items selected to add to the gift bag'
        page.select_giftbag "REINDEER"
    end
  end
end

Then(/^I see the following error message (.*)$/) do |err_msg|
  on(Gift_Wrap) do |page|
    expect(page.err_msg_gift_bag_page).to include "#{err_msg}"
  end
end

And(/^I hit 'X' button on the Gift Wrap page$/) do
  on(Gift_Wrap) do |page|
    page.click_gw_close_btn
  end
end

Then(/^I see the message "([^"]*)"$/) do |arg|
  on(Gift_Wrap) do |page|
    expect(page.giftwrap_dismiss_confirm_block).to include "#{arg}"
    expect(page.assert_cont_gift_bag).to be(true)
    expect(page.assert_back_to_bag).to be(true)
    expect(page.assert_back_to_bag_link).to include 'bag'
  end
end

When(/^I hit on "([^"]*)"$/) do |arg|
  on(Gift_Wrap) do |page|
    page.gift_bag_dismiss_opt_click arg
  end
end

Then(/^I land on Make it a Gift page$/) do
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include 'bag'
  end
end

Then(/^I land on My Bag page$/) do
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include 'bag'
  end
end

Then(/^I land on Checkout page$/) do
  on(Utility_Functions) do |page|
    expect(page.return_browser_url).to include 'checkout'
  end
end

Given(/^I add the following Giftbag and products:$/) do |table|
  on(PdpPage) do |page|
    page.click_view_cart
    page.wait_for_ajax
    @cart_items_text = page.get_cart_items_txt
  end
  table.hashes.each do |row|
    @title = row['title']
    @giftbag = row['GiftBag']
    @qty = row['qty']
    @to = row['To']
    @from = row['From']
    @opt_msg = row['Message']

    on(Gift_Wrap) do |page|
      page.giftwrap_dd_click
      page.wait_for_ajax
      page.start_wrapping_btn_click
      page.wait_for_ajax
      @assert_items_section = page.assert_add_your_items_section
      page.wait_for_ajax
      expect(@cart_items_text).to match /["#{@assert_items_section}"]+/
      expect((page.assert_gift_page).to_s).to include 'Gift Wrap'
      page.select_giftbag "#{@giftbag}"
      @loop = 0
      for i in 1..(@qty.to_i)
        page.bag_line_item_text @title
        @loop += 1
          page.enter_to_msg @to
          page.enter_from_msg @from
          page.enter_opt_msg_txt @opt_msg
          page.wait_for_ajax
      end
      expect(page.gift_wrap_items_txt).to include "#{@title}", "#{@qty}"
      page.click_create_my_gift_btn
      page.wait_for_ajax
      page.get_uuid_gift_bag
    end
  end
end

Given(/^I remove the following Giftbag:$/) do |table|
  @count = table.rows.size.to_i
  i = 1
  table.hashes.each do |row|
    on(Gift_Wrap) do |page|
      while i < @count+1
        page.remove_giftcard_mybag i
        page.wait_for_ajax
        i +=1
      end
    end
  end
end

Then(/^I see the following Giftbags in MyBag:$/) do |table|
  table.hashes.each do |row|
    on(MybagPage) do |page|
      expect(page.mybag_line_items_txt).to include row['To'],row['From'],row['Message']
    end
  end
end

Then(/^I see no giftwraps on MyBag page$/) do
  on(Gift_Wrap) do |page|
    expect(page.present_gift_products_details?).to be_falsey
  end
end

And(/^I see the following products on MyBag page:$/) do |table|
  table.hashes.each do |row|
    on(MybagPage) do |page|
      expect(page.mybag_line_items_txt).to include row['product_name']
    end
  end
end

And(/^I edit the following Giftbag:$/) do |table|
  table.hashes.each do
    on(MybagPage) do |page|
        page.edit_giftwrap
        page.wait_for_ajax
    end
  end
end

When(/^I update the Giftwrap item quantity from "([^"]*)" to "([^"]*)"$/) do |arg1, arg2|
  on(Gift_Wrap) do |page|
    @count = (arg1).to_i
    i = (arg2.to_i)+1
    loop do
      page.reduce_qty_giftwrap_section i
      page.wait_for_ajax
      i+=1
      break if i < @count+1
    end
    page.wait_for_ajax
  end
end

Then(/^I see no items in Your Gift Bag is looking good section$/) do
  on(Gift_Wrap) do |page|
    expect(page.empty_msg_present?).to be_truthy
  end
end

And(/^I select gift card as "([^"]*)" from Choose your card section$/) do |arg|
  on(Gift_Wrap) do |page|
    page.carousel_right_arrow_click
    page.select_card arg
  end
end

And(/^I enter the message as "([^"]*)" in the message section$/) do |arg|
  on(Gift_Wrap) do |page|
    page.enter_single_gift_message arg
  end
end