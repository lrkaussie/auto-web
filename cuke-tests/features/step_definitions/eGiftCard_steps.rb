And(/^I select (.*), (.*) on eGiftCard page$/) do |des, amt|
  on(EGiftCardPage) do |page|
    @amt = amt
    if amt != 'empty'
      if amt <= '500'
        page.select_gc_amount amt
      else
        page.enter_gc_amount amt
      end
    end
  end
end

And(/^I enter (.*), (.*), (.*), (.*) on eGiftCard page$/) do |rec_name, rec_email, conf_rec_email, sender_name|
  on(EGiftCardPage) do |page|
    @rec_name = rec_name
    @rec_email = rec_email
    @conf_rec_email = conf_rec_email
    @sender_name = sender_name
    if rec_name != 'empty'
      page.enter_recipient_name rec_name
    end
    if rec_email != 'empty'
      page.enter_recipient_email rec_email
    end
    if conf_rec_email != 'empty'
      page.enter_conf_recipient_email conf_rec_email
    end
    if sender_name != 'empty'
      page.enter_senders_name sender_name
    end
  end
end

And(/^the user clicks on Add to Bag for eGiftCard$/) do
  on(EGiftCardPage) do |page|
    if page.add_to_bag_gc_enabled?
      page.click_add_to_bag_gc
    end
  end
  on(PdpPage) do |page|
    page.close_ovelapped_success_message
  end
end

Then(/^the error message on eGiftCard page is (.*)$/) do |arg|
  on(EGiftCardPage) do |page|
    if @amt == 'empty'
      expect(page.error_msg_gc_pdp_amt).to include arg
    elsif @rec_name == 'empty'
      expect(page.error_msg_gc_rec_name).to include arg
    elsif @rec_email == 'empty'
      expect(page.error_msg_gc_rec_email).to include arg
    elsif @conf_rec_email == 'empty'
      expect(page.error_msg_gc_conf_rec_email).to include arg
    elsif @sender_name == 'empty'
      expect(page.error_msg_gc_senders_name).to include arg
    elsif @rec_email != @conf_rec_email
      expect(page.error_msg_gc_conf_rec_email).to include arg
    elsif (@amt.to_i) > 500
      expect(page.error_msg_gc_amt).to include arg
    end
  end
end

And(/^I select the following on eGiftCard page:$/) do |table|
  table.hashes.each do |data|
    on(EGiftCardPage) do |page|
      page.select_design data['design']
      page.select_gc_amount data['amount']
      if data['recipient_name'] != 'empty'
        page.enter_recipient_name data['recipient_name']
      end
      if data['recipient_email'] != 'empty'
        page.enter_recipient_email data['recipient_email']
      end
      if data['recipient_email_conf'] != 'empty'
        page.enter_conf_recipient_email data['recipient_email_conf']
      end
      if data['senders_name'] != 'empty'
        page.enter_senders_name data['senders_name']
      end
      if data['senders_msg'] != 'empty'
        page.enter_senders_msg data['senders_msg']
      end
    end
  end
end


And(/^the user adds the eGiftcard to cart and clicks checkout on success overlay$/) do
  on(EGiftCardPage) do |page|
    if page.add_to_bag_gc_enabled?
      page.click_add_to_bag_gc
    end
  end
  on(PdpPage) do |page|
    page.check_out_from_pdp_success_message
  end
end

And(/^the user adds the eGiftcard to cart$/) do
  on(EGiftCardPage) do |page|
    if page.add_to_bag_gc_enabled?
      page.click_add_to_bag_gc
    end
  end
end
