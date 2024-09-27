require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'
require "gmail"

class EGiftCardPage
  include PageObject
  include Utilities

  spans(:sel_amt, :css => ".amount")
  text_field(:rec_name, :css => "#dwfrm_giftcert_purchase_recipient")
  text_field(:rec_email, :css => "#dwfrm_giftcert_purchase_recipientEmail")
  button(:add_to_bag_gc, :css => '#add-gc-to-cart')
  text_field(:conf_rec_email, :css => "#dwfrm_giftcert_purchase_confirmRecipientEmail")
  text_field(:sender_name, :css => "#dwfrm_giftcert_purchase_from")
  span(:error_txt_gc_pdp_amt, :css => ".section-header.error")
  span(:err_msg_gc_rec_name, :css =>"#dwfrm_giftcert_purchase_recipient-error")
  span(:err_msg_gc_rec_email, :css => "#dwfrm_giftcert_purchase_recipientEmail-error")
  span(:err_msg_gc_conf_rec_email, :css => "#dwfrm_giftcert_purchase_confirmRecipientEmail-error")
  span(:err_msg_gc_senders_name, :css => "#dwfrm_giftcert_purchase_from-error")
  text_field(:gc_amt, :css => "#dwfrm_giftcert_purchase_customAmount")
  span(:err_msg_gc_amt, :css => "#dwfrm_giftcert_purchase_customAmount-error")
  link(:des_1, :css => "[title='Select eGift Card: EGIFT DESIGN 01']")
  link(:des_2, :css => "[title='Select eGift Card: EGIFT DESIGN 02']")
  text_area(:senders_msg, :css => "#dwfrm_giftcert_purchase_message")

  def click_add_to_bag_gc
    wait_for_ajax
    wait_and_click add_to_bag_gc_element
  end

  def add_to_bag_gc_enabled?
    Watir::Wait.until(timeout: 30){add_to_bag_gc_element.enabled?}
  end

  def select_gc_amount amt
    sel_amt_elements.find {|el| el.data_amount.to_i.eql?amt.to_i}.click
  end

  def enter_recipient_name rec_name
    wait_and_set_text rec_name_element,rec_name
  end

  def enter_recipient_email rec_email
    wait_and_set_text rec_email_element,rec_email
  end

  def enter_conf_recipient_email conf_rec_email
    wait_and_set_text conf_rec_email_element,conf_rec_email
  end

  def enter_senders_name sender_name
    wait_and_set_text sender_name_element,sender_name
  end

  def error_msg_gc_pdp_amt
    wait_for_ajax
    return wait_and_get_text error_txt_gc_pdp_amt_element
  end

  def error_msg_gc_rec_name
    wait_for_ajax
    return wait_and_get_text err_msg_gc_rec_name_element
  end

  def error_msg_gc_rec_email
    wait_for_ajax
    return wait_and_get_text err_msg_gc_rec_email_element
  end

  def error_msg_gc_conf_rec_email
    wait_for_ajax
    return wait_and_get_text err_msg_gc_conf_rec_email_element
  end

  def error_msg_gc_senders_name
    wait_for_ajax
    return wait_and_get_text err_msg_gc_senders_name_element
  end

  def enter_gc_amount amt
    wait_and_set_text gc_amt_element,amt
  end

  def error_msg_gc_amt
    wait_for_ajax
    return wait_and_get_text err_msg_gc_amt_element
  end

  def select_design design
    case design
      when 'EGIFT DESIGN 01'
        wait_and_click des_1_element
        wait_for_ajax
      when 'EGIFT DESIGN 02'
        wait_and_click des_2_element
        wait_for_ajax
    end
  end

  def enter_senders_msg msg
    wait_and_set_text senders_msg_element,msg
  end


end