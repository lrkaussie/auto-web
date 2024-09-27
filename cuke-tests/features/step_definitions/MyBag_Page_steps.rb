And(/^I add "([^"]*)" more to the qty from the My Bag page$/) do |arg|
  on(MybagPage) do |page|
    page.update_qty arg
  end
end

And(/^the price of the product will now be "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    page.order_total
    @wait_for_page_to_load.page_wait
    expect((page.product_sale_price_after_disc).to_s == (arg)).to be(true)
  end
end

 When(/^the bag is modified(.*)$/) do |arg, table|
   table.hashes.each do |data|
     line_item = data ['sku']
     line_item_qty = data ['qty']
     on(MybagPage).modify_bag(line_item,line_item_qty)
   end
 end

Then(/^I see the Gift Bag with following Products in Bag$/) do |table|
  table.hashes.each do |row|
    @title = row['title']
    @qty = row['qty']
    on(MybagPage) do |page|
      expect(page.mybag_line_items_txt).to include "#{@title}","#{@qty}"
    end
  end
end

And(/^I see the following text as line items in My Bag page$/) do |table|
  table.hashes.each do |row|
    @to = row['To']
    @from = row['From']
    @opt_msg = row['Message']
    @num_items_bag = row['Number_of_items_in_gift_bag']
    @gift_bag = row['Gift_Bag']
    on(MybagPage) do |page|
        expect(page.mybag_line_items_html).to include "#{@gift_bag}"
        expect(page.mybag_line_items_txt).to include "#{@to}", "#{@from}", "#{@opt_msg}","#{@num_items_bag}"
        expect(page.mybag_line_items_txt).to include "Gift Wrap", "gift wrapped", "Edit Gift Wrap"
    end
  end
end

And(/^the order total in the Order Summary section on My Bag page is "([^"]*)"$/) do |arg|
  expect(on(MybagPage).order_total).to eq arg
end

When(/^customer enters the (.*) in the Perks Voucher section on My Bag page$/) do |arg,table|
  on(MybagPage) do |page|
    @voucher_list = table.hashes
    @voucher_list.each {|data|
      page.apply_promo_code data['voucher_id']
    }
  end
end

And(/^the customer can see the (.*) applied in the Applied codes section$/) do |arg|
  @voucher_list.each {|data|
    expect(on(MybagPage).applied_coupons).to include data['voucher_id']
  }
end

And(/^the customer can see Remove link against the (.*)$/) do |arg|
  index = 0
  @voucher_list.each {|data|
    expect(on(MybagPage).check_remove_link(index)).to be(true)
    index = index+1
  }
end

Then(/^the customer sees the message (.*) below the voucher input box$/) do |arg|
  expect(on(MybagPage).voucher_success_message).to include arg
end

Then(/^the customer cannot see the (.*) applied in the Applied codes section$/) do |arg|
  @voucher_list.each {|data|
    expect(on(MybagPage).is_any_coupon_present).to eq ""
  }
end

Then(/^the customer sees the error message "([^"]*)" below the voucher input box$/) do |arg|
  expect(on(MybagPage).voucher_error_message).to include arg
end

Then(/^the the user lands on My Bag page with global error message "(.*)"$/) do |arg|
  expect(on(MybagPage).coupon_global_error).to include arg
end

And(/^the customer removes the coupons\/vouchers from Bag Page$/) do |table|
  on(MybagPage) do |page|
    @remove_voucher_list = table.hashes
    @remove_voucher_list.each {|data|
      page.remove_voucher_from_bag data['voucher_id']
    }
  end
end

Then(/^I see the following nonpersonalised products in MyBag page$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    on(MybagPage) do |page|
      page.check_bag_line_item @sku
      page.check_bag_line_item_sku @sku,@qty
    end
  end
end

Then(/^I see the following personalised products in MyBag page$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    on(MybagPage) do |page|
      page.check_bag_personalised_line_item @sku
    end
  end
end

Then(/^I validate mybag page:$/) do |table|
  table.hashes.each do |row|
    @order_tot = row['order_total']
    @delivery = row['delivery']
    @text_on_mybag_page = row['text_on_page']
    @cont_shopping_btn = row['continue_shopping_button']
    @avail_del_methods = row['available_del_methods']
    @gift_card_text = row['gift_card_text']
    on(MybagPage) do |page|
      if @order_tot != nil
        expect(page.order_total).to eq @order_tot
      end
      if @delivery != nil
        expect((page.return_delivery_method_text).to_s == @delivery).to be(true)
      end
      if @text_on_mybag_page != nil
        expect((page.return_mybag_page_text).to_s == @text_on_mybag_page).to be(true)
      end
      if @cont_shopping_btn != nil
        expect((page.return_cont_shop_btn_mybag).to_s == @cont_shopping_btn).to be(true)
      end
      if @avail_del_methods != nil
        @avail_del_methods = @avail_del_methods.split(",")
        page.click_delivery_methods_dd
        @avail_del_methods.each {|a| a.include?(page.return_avail_del_methods_text)}
      end
      if @gift_card_text != nil
        expect((page.gift_card_text).to_s == @gift_card_text).to be(true)
      end
    end
  end
end

Then(/^mybag page cart details are:$/) do |table|
  table.hashes.each do |row|
    @order_tot = row['order_total']
    @delivery = row['delivery']
    @text_on_mybag_page = row['text_on_page']
    @cont_shopping_btn = row['continue_shopping_button']
    @avail_del_methods = row['available_del_methods']
    @cart_present_text = row['cart_present_text']
    on(MybagPage) do |page|
      if @order_tot != nil
        expect((page.order_total).to_s == @order_tot).to be(true)
      end
      if @delivery != nil
        expect((page.return_delivery_method_text).to_s == @delivery).to be(true)
      end
      if @text_on_mybag_page != nil
        expect((page.return_mybag_page_text).to_s == @text_on_mybag_page).to be(true)
      end
      if @cont_shopping_btn != nil
        expect((page.return_cont_shop_btn_mybag).to_s == @cont_shopping_btn).to be(true)
      end
      if @avail_del_methods != nil
        @avail_del_methods = @avail_del_methods.split(",")
        page.click_delivery_methods_dd
        @avail_del_methods.each {|a| a.include?(page.return_avail_del_methods_text)}
      end
      if @cart_present_text != nil
        expect(page.get_cart_present_text).to include @cart_present_text
      end
    end
  end
end

When(/^I change delivery method to "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    page.click_delivery_methods_dd
    page.click_delivery_method arg
  end
end

Then(/^I validate the order summary section in checkout page:$/) do |table|
  table.hashes.each do |row|
    @order_tot = row['order_total']
    @delivery = row['delivery']
    on(CheckoutPage) do |page|
      expect((page.order_summary_total).to_s == @order_tot).to be(true)
      expect((page.get_shipping_del_co).to_s == @delivery).to be(true)
    end
  end
end

And(/^I click on Continue Shopping link$/) do
  on(MybagPage) do |page|
    page.click_cont_shopp_btn_link
  end
end

And(/^I click on Checkout button on My Bag page$/) do
  on(MybagPage) do |page|
    page.wait_for_ajax
    page.bag_checkout
  end
end

Then(/^mybag page has the following egift card products:$/) do |table|
  table.hashes.each do |row|
    @recipient_name = row['recipient_name']
    @senders_name = row['senders_name']
    @senders_msg = row['senders_msg']
    @design = row['design']
    on(MybagPage) do |page|
      if @recipient_name != nil
        expect((page.get_recipient_name).to_s.include? @recipient_name)
      end
      if @senders_name != nil
        expect((page.get_senders_name).to_s.include? @senders_name)
      end
      if @senders_msg != nil
        expect((page.get_senders_msg).to_s.include? @senders_msg)
      end
      if @design != nil
        expect(page.get_design @design).to be(true)
      end
    end
  end
end

When(/^the user removes the eGiftCard "([^"]*)" from My Bag page$/) do |arg|
  on(MybagPage) do |page|
    page.remove_egiftcard_from_mybag arg
  end
end

When(/^I add the product to Wishlist from bag page$/) do |table|
  on(MybagPage) do |page|
    table.hashes.each{|data|
      #to_do : change text to product from products
    page.add_products_to_wishlist data['products']
    }
  end
end

And(/^the message "([^"]*)" is displayed on My Bag page$/) do |arg|
  on(MybagPage) do |page|
  expect((page.move_to_wishlist_message)== arg).to be_truthy
  end
end

Then(/^the Move to wishlist button is not visible for the products on My Bag page$/) do |table|
  table.hashes.each do |row|
  @product = row['product']
    on(MybagPage) do |page|
      expect(page.check_move_to_wishlist_link_presence @product).to be_truthy
    end
  end
end

Then(/^the Move to wishlist button is not visible for the eGiftCards on My Bag page$/) do |table|
  table.hashes.each do |row|
    @design = row['design'].downcase
    @product = row['product']
    on(MybagPage) do |page|
      expect(page.check_move_to_wishlist_link_presence_eGiftCard @product,@design).to be_truthy
    end
  end
end

And(/^I navigate to Points balance page$/) do
  on(CottonOnHomepage) do |page|
    page.user_initials
    page.wait_for_ajax
    page.points_balance
    sleep 2
    page.wait_for_ajax
  end
end

And(/^the vouchers are displayed on bag page$/) do |table|
  on(MybagPage) do |page|
    table.hashes.each {|data|
      expect(page.check_vouchers_on_bag data['voucher_id']).to be_truthy
    }
    expect(on(MybagPage).total_vouchers_on_bag).to eq table.hashes.size
  end
end

And(/^I remove the vouchers from bag page$/) do |table|
  # table is a table.hashes.keys # => [:voucher_id]
  on(MybagPage) do |page|
    table.hashes.each {|data|
      page.remove_voucher_from_bag data['voucher_id']
    }
  end
end


And(/^the bag page is empty$/) do
  on(MybagPage) do |page|
  expect(page.check_number_of_product_line_items_on_bag == 0).to be_truthy
  end
end

And(/^the message as "([^"]*)" is displayed$/) do |arg|
  on(MybagPage) do |page|
  expect((page.return_mybag_page_text).to_s == arg).to be(true)
  end
end

And(/^I see no "([^"]*)" banner above the products list in My Bag page$/) do |arg|
  on(MybagPage) do |page|
    expect(page.present_giftwrap_mybag_dd?).to be_falsey
  end

end

And(/^I see "([^"]*)" button in "([^"]*)" banner in My Bag page$/) do |arg1, arg2|
  on(MybagPage) do |page|
    expect(page.present_create_more_giftwrap_btn?).to be_truthy
  end
end

Then(/^user is taken back to My Bag page with "([^"]*)" details$/) do |arg|
  on(Utility_Functions) do |page|
    @wait_for_page_to_load.page_wait
    expect(page.return_browser_url).to include 'CANCELLED'
  end
end

Then(/^the title of the Free Returns section on My Bag page displays "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    expect((page.title_returns_section) == arg).to be(true)
  end
end

And(/^the description of the Free Returns section on My Bag page displays "([^"]*)"$/) do |arg|
  on(MybagPage) do |page|
    expect((page.description_returns_section) == arg).to be_truthy
  end
end


And(/^the user removes the "([^"]*)" product from the cart$/) do |sku_id|
  on(MybagPage) do |page|
    page.click_remove_button sku_id
  end
end

And(/^user selects the "([^"]*)" shipping method on bag page$/) do |arg|
  on(MybagPage) do |page|
    case arg
    when "standard"
      page.click_delivery_methods_dd
      page.select_delivery_method "Standard"
    when "Next Day"
      page.click_delivery_methods_dd
      page.select_delivery_method "Next Day"
    end
  end
end

Then(/^bnpl logos are displayed on My Bag page$/) do
  on(MybagPage) do |page|
    expect(page.bnpl_logos_top_bag_pg).to include "Zip logo"
    expect(page.zip_logo_top_bag_pg).to be_truthy
    expect(page.bnpl_logos_top_bag_pg).to include "Afterpay logo"
    expect(page.afterpay_logo_top_bag_pg).to be_truthy
    expect(page.bnpl_logos_bottom_bag_pg).to include "Zip logo"
    expect(page.zip_logo_bottom_bag_pg).to be_truthy
    expect(page.bnpl_logos_bottom_bag_pg).to include "Afterpay logo"
    expect(page.afterpay_logo_bottom_bag_pg).to be_truthy
  end
end

And(/^bnpl tagline with text as "([^"]*)" is displayed on My bag page$/) do |arg|
  on(MybagPage) do |page|
    expect(page.bnpl_top_tagline_text_bag_pg).to include arg
    expect(page.bnpl_bottom_tagline_text_bag_pg).to include arg
  end
end

And(/^I validate "([^"]*)" text for qty "([^"]*)" on My bag page$/) do |arg1, arg2|
  on(MybagPage) do |page|
    case arg1
    when "Save RRP"
      if arg2 == "1"
        expect(page.save_rrp_text == "SAVE $9.85 off RRP").to be_truthy
      end
      if arg2 == "2"
        expect(page.save_rrp_text == "SAVE $19.70 off RRP").to be_truthy
      end
    when "Save Percent"
      if arg2 == "1"
        expect(page.save_rrp_text == "SAVE 13% off RRP").to be_truthy
      end
      if arg2 == "2"
        expect(page.save_rrp_text == "SAVE 13% off RRP").to be_truthy
      end
    end
  end
end


And(/^I validate that the save text is no longer visible for multipack$/) do
  on(MybagPage) do |page|
    expect((page.save_rrp_text_present).to_s == "false").to be_truthy
  end
end

Then(/^user should navigate to the bag page with "([^"]*)" carousel displayed$/) do |arg|
  on(MybagPage) do |page|
    @url = @browser.url
    expect(@url == "#{@site_information["#{@url_comp}"]}"+ "/" + "bag/")
    expect(page.bonus_gift_heading == arg)
  end
end

And(/^user adds the product from the free gift carousel$/) do
  on(MybagPage) do |page|
    page.click_quick_add_gift_carousel
  end
end