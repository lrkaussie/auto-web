Then(/^placed order total is verified$/) do
  on(ThankyouPage) do |page|
        expect((page.assert_order_total_on_conf_page).to_s == ($order_tot_checkout_page)).to be(true)
  end
end


Then(/^payment type is "([^"]*)"$/) do |arg|
  on(ThankyouPage) do |page|
    expect((page.assert_payment_type).to_s == (arg)).to be(true)
  end
end

And(/^the Thank You page shows the gift card number and redeemed amount as$/) do |table|
  index = 0
  on(ThankyouPage) do |page|
    table.hashes.each do |data|
      expect(page.verify_payment_type_on_thankyou_page index).to eq data['payment_type']
      expect(page.verify_order_amount_on_thankyou_page index).to eq data['payment_amount']
      index = index+1
    end
  end
end

Then(/^I validate the order summary section in thankyou page:$/) do |table|
  table.hashes.each do |row|
    @title = row['title']
    on(ThankyouPage) do |page|
      expect(page.line_items_thankyoupage @title).to be_truthy
    end
  end
end


Then(/^cash on delivery Thankyou page is displayed with details for the user$/) do
  on(ThankyouPage) do |page|
      @order_number = page.find_dw_order_number
      expect(page.order_confirm_page_loaded?).to be(true)
      expect(page.order_confirmation_text).to include (page.assert_transaction_id)
      expect(page.billing_address_conf_page).to include (@person['house']['address1']),@person['country'],(@person['house']['postcode']).to_s
  end
  on(Utility_Functions) do |page|
      expect(page.return_browser_url).to include 'complete'
  end
end


Then(/^the payment section on the Thankyou page shows the details$/) do |table|
  @row = table.hashes.first
    @payment_type = @row['payment_type']
    @payment_amount = @row['payment_amount']
  on(ThankyouPage) do |page|
    if @row['payment_type'] != nil
      expect(page.payment_method_section_text).to include @payment_type
    end
    if @row['payment_amount'] != nil
      expect(page.payment_method_section_text).to include @payment_amount
    end
  end
end
