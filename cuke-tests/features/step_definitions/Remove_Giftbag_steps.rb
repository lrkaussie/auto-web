# And(/^I have a bag with products/) do |table|
#     table.hashes.each do |row|
#         @title = row['title']
#         @qty = row['qty']
#         on(MybagPage) do |page|
#             expect(page.mybag_line_items_txt).to include "#{@title}","#{@qty}"
#         end
#     end
# end
#
# And(/^I click on "([^"]*)" banner in My Bag page/) do
#     on(Gift_Wrap) do |page|
#         page.giftwrap_dd_click
#     end
# end
#
# And(/^I see "([^"]*)" page/) do
#     on(Gift_Wrap) do |page|
#         page.start_wrapping_btn_click
#     end
# end
#
# And(/^I select Gift Bag from "([^"]*)" section/) do
#     on(Gift_Wrap) do |page|
#         page.assert_gift_page
#     end
# end
#
# And(/^I add the following product with quantity to it from "([^"]*)" section/) do |args, table|
#     @count = 0
#     table.hashes.each do |row|
#         @gw_sign_symb_count = row.count
#         on(Gift_Wrap) do |page|
#             page.click_basket_line_items @count
#             @count+= 1
#         end
#     end
# end
#
# And(/^I see the products selected starts adding to "([^"]*)" section/) do |args|
#     on(Gift_Wrap) do |page|
#         page.gift_wrap_items_txt
#     end
# end
#
# And(/^I see the products added to gift bag section/) do
#     on(Gift_Wrap) do |page|
#         page.gift_wrap_items_txt
#     end
# end
# And(/^I enter the following text in "([^"]*)" page/) do
#     table.hashes.each do |row|
#         @to = row['To']
#         @from = row['From']
#         @opt_msg = row['Message']
#         on(Gift_Wrap) do |page|
#             page.enter_to_msg @to
#             page.enter_from_msg @from
#             page.enter_opt_msg_txt @opt_msg
#         end
#     end
# end
# And(/^I hit "([^"]*)" button/) do
#     on(Gift_Wrap) do |page|
#         page.click_create_my_gift_btn
#     end
# end
# And(/^I land on My Bag page/) do
#     on(MybagPage) do |page|
#         expect(page.assert_my_bag_page_url).to include 'bag'
#     end
# end
# And(/^I see the customise text and products in My Bag as line item/) do
#     on(MybagPage) do |page|
#         page.mybag_line_items_txt
#     end
# end
# And(/^I see the Gift Bag with following Products in Bag/) do |table|
#     table.hashes.each do |row|
#         on(MybagPage) do |page|
#             @sku = row['sku']
#             page.check_bag_line_item @sku
#         end
#     end
# end
# And(/^I see the following customise text as line items in My Bag page/) do |table|
#     table.hashes.each do |row|
#         on(MybagPage) do |page|
#             page.check_giftwrap_lineitem_text row
#         end
#     end
# end
# And(/^I see No "([^"]*)" banner above the products list in My Bag/) do
#     on(Gift_Wrap) do |page|
#         page.check_banner_exists
#     end
# end
# And(/^I "([^"]*)" the GiftBag([0-9]*) from My bag page/) do |args, pos|
#     on(Gift_Wrap) do |page|
#         page.check_giftwrap_line_item_on_position pos
#     end
# end
# And(/^GiftBag([0-9]*) line item is removed from the "Mark" basket/) do |args|
#     on(Gift_Wrap) do |page|
#         page.remove_giftwrap_line_item args
#     end
# end
# And(/^I can see (\d+) gift bags "([^"]*)" as line items in the basket/) do |qty, names|
#     on(Gift_Wrap) do |page|
#         page.assert_giftwrap_line_items_qty qty
#     end
# end
#
# And(/^the Cart total for Service charge of Giftbag is "([^"]*)", products charge is "([^"]*)" , delivery charge is "([^"]*)" is updated to "([^"]*)" in the Cart page./) do |giftbag_price, product_price, delivery_price, new_order_total|
#     on(MybagPage) do |page|
#         expect((page.giftbag_price).to_s == giftbag_price).to be(true)
#         expect((page.sale_price_before_disc).to_s == product_price).to be(true)
#         expect((page.return_delivery_method_text).to_s == delivery_price).to be(true)
#         expect((page.order_total).to_s == new_order_total).to be(true)
#     end
# end
# And(/^the 'Wrap My Gifts' banner appears with the button "Wrap Another One"/) do
#     on(Gift_Wrap) do |page|
#         page.assert_gift_page
#     end
# end