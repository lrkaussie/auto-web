require 'page-object'
require 'page-object/page_factory'
require_relative '../../../monkey_patch.rb'

class MyAccountPage
  include Utilities
  include PageObject
  include CogElements
  text_field(:profile_customer_firstname, :id => 'dwfrm_profile_customer_firstname')
  text_field(:profile_customer_lastname, :id => 'dwfrm_profile_customer_lastname')
  text_field(:profile_customer_email, :id => 'dwfrm_profile_customer_email')
  text_field(:profile_login_password, :id => /dwfrm_profile_login_password/)
  text_field(:profile_login_passwordconfirm, :id => /dwfrm_profile_login_passwordconfirm/)
  select_list(:profile_dob_day, :id => 'dwfrm_profile_newsletter_day')
  select_list(:profile_dob_month, :id => 'dwfrm_profile_newsletter_month')
  select_list(:profile_dob_year, :id => 'dwfrm_profile_newsletter_year')
  label(:profile_customer_gender, :for => 'dwfrm_profile_customer_genderMale')
  text_field(:login_username, :id => /dwfrm_login_username/)
  button(:sign_me_in, :class => 'sign-me-in')
  text_field(:login_password, :id => /dwfrm_login_password/)
  label(:login_rememberme, :for => 'dwfrm_login_rememberme')
  link(:forgot_password, :id => 'password-reset')
  div(:perks_account_pop_up, :class => 'perk-account-create-popup')
  button(:create_online_account, :class => 'create-perk-account')
  button(:close_online_account_popup, :xpath => '//*[@id="slide-dialog-container"]/div/div[4]/button')
  button(:dismiss_online_account_popup, :xpath => '//*[@id="slide-dialog-container"]/div/div[1]/div/span')
  unordered_list(:account_options, :class => 'account-options')
  p(:account_hi_message, :class => 'account-hi-message')
  div(:password_dialog, :class => 'set-new-password-dialog')
  div(:incorrect_password_error, :class => 'error-form')
  label_button(:join_loyalty, :for => 'dwfrm_profile_customer_addtoemaillist')
  button(:create_your_account, :value => 'Create Your Account')
  button(:join_perks, :name => 'dwfrm_newsletter_loyaltysubscribe')
  p(:perks_pop_up, :css => "[style='text-align:center;']")
  label_button(:brand_typo, :for => '3-cat-pref')
  label_button(:brand_ruby, :for => '4-cat-pref')
  span(:no_of_points, :class => 'points-amount')
  span(:no_of_rewards, :class => 'rewards-amount')
  p(:points_to_reward_mapping, :class => 'points-in-reward')
  divs(:voucher_details, :class => 'voucher-header')
  divs(:voucher_codes, :class => 'voucher-barcode')
  spans(:voucher_expiry_date, :class => 'expiry-date')
  spans(:voucher_expiry_days, :class => 'expiry-days')
  div(:non_perk_member_message, :class => 'not-perk-member-message')
  div(:points_to_reward_mapping_non_perks, :class => 'points-in-reward')
  link(:sign_up_for_perks, :class => ['button', 'sign-up', 'expanded'])
  div_button(:reward_history, :class => 'reward-history-header')
  divs(:voucher_type, :class => 'data-type')
  divs(:voucher_locked_message, :class=>'voucher-locked-message')
  divs(:voucher_value, :class => 'data-value')
  divs(:voucher_status, :class => 'data-redeemed')
  divs(:expired_date, :class => 'data-expired')
  div(:spend_threshold_message, :class => 'next-reward')
  span(:how_rewards_work, :class => 'icon icon-arrow-black-small', :index => 0)
  div(:rewards_info_section_content, :class => 'points-dropdown-content')
  link(:already_a_perks_member, :class => 'already-member-link')
  div(:already_a_perks_member_content, :class =>'description')
  link(:update_account_details, :class=> 'update-link')
  divs(:voucher_container, :class => 'voucher-container')
  div(:reward_history_section_open, :class => "reward-history-body open", :index =>0)
  text_field(:sms_opt_in_no_phone_number, :name => "dwfrm_profile_newsletter_phone", :index =>0)
  text_field(:sms_opt_in_with_phone_number, :class=>"input-text custom-input vd-optinphone phone has-value")
  span(:ph_number_error_message, :id => "dwfrm_profile_newsletter_phone-error")
  div(:underage_overlay, :id => "slide-dialog-container")
  div(:underage_overlay_text, :class => "block-under13-dialog", :index => 0)
  label(:dob_checkbox, :css => "label[for='save_my_dob']", :index => 0)
  spans(:dob_checkbox_texts, :css => "label[for='save_my_dob'] span")
  div(:dob_copy_subscription, :class => "sms-description", :index => 1)
  div(:dob_copy_checkout, :class => "sms-description", :index => 0)
  text_field(:password_subscribe_pg, :css => "input.password-wrapper[type='password']", :index => 0)
  # checkbox(:brand_pref, :css => "input.subscription-list.input-checkbox[data-default='true']")
  checkboxes(:brand_pref, :css => "input.subscription-list.input-checkbox[data-default='false']")
  checkboxes(:co_brand_prefs, :css => "input.subscription-list.input-checkbox[data-default='true']")
  label(:join_perks_register_pg, :for => 'dwfrm_profile_customer_addtoemaillist')

  def profile_customer_firstname
    return profile_customer_firstname_element.when_present.value
  end

  def profile_customer_lastname
    return profile_customer_lastname_element.when_present.value
  end

  def profile_customer_email
    return profile_customer_email_element.when_present.value
  end

  def profile_login_password
    return profile_login_password_element.when_present.value
  end

  def profile_login_passwordconfirm
    return profile_login_passwordconfirm_element.when_present.value
  end

  def login_username
    return login_username_element.when_present.text
  end

  def select_customer_gender
    profile_customer_gender_element.click
  end

  def is_sign_me_in_button_present
    return sign_me_in_element.present?
  end

  def is_login_password_present
    return login_password_element.present?
  end

  def is_login_rememberme__present
    return login_rememberme_element.present?
  end

  def is_forgot_password_present
    return forgot_password_element.present?
  end

  def sign_in arg
    login_username_element.when_present.set arg
    sign_me_in_element.when_present.click
  end

  def loyalty_account_pop_up_message
    wait_for_ajax
    perks_account_pop_up_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    return perks_account_pop_up_element.when_present(timeout = 30).text.gsub(/\n+/, "")

  end

  def verify_perks_account_popup_buttons
    flag = (create_online_account_element.present? && close_online_account_popup_element.present?)
    close_online_account_popup_element.when_present.click
    return flag
  end

  def create_online_account
    create_online_account_element.when_present.click
  end

  def no_thanks
    close_online_account_popup_element.when_present.click
    sleep 5
  end

  def password_dialogue
    wait_for_ajax
    password_dialog_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    return password_dialog_element.when_present.text.gsub(/\n+/, "")
  end

  def personal_details_text
    wait_for_ajax
    return account_options_element.list_item_elements[2].link.text
  end

  def your_order_history_text
    return account_options_element.list_item_elements[1].link.text
  end

  def your_addresses_text
    return account_options_element.list_item_elements[3].link.text
  end

  def wishlist_text
    return account_options_element.list_item_elements[4].link.text
  end

  def points_balance_text
    return account_options_element.list_item_elements[0].link.text
  end

  def points_balance
    account_options_element.list_item_elements[0].link.click
  end

  def account_hi_message
    return account_hi_message_element.when_present.text
  end

  def sign_in_with_password (email, password)

    login_username_element.when_present.set email
    sign_me_in_element.when_present.click
    login_password_element.when_present.set password
    sign_me_in_element.when_present.click
  end

  def incorrect_password_message
    wait_for_ajax
    return incorrect_password_error_element.when_present.text
  end

  # def join_loyalty
  #   join_loyalty_element.click
  # end

  def create_cc_account
    create_your_account
  end

  def verify_perks_pop_up_message
    perks_pop_up_element.wait_until do |s|
      s.present? == true
      # && s.style('overflow') == 'visible'
    end
    return perks_pop_up_element.text

  end

  # def select_brands
  #   brand_typo_element.click
  #   brand_ruby_element.click
  # end

  def voucher_header_points_balance_page index
    return voucher_details_elements[index.to_i].text
  end

  def voucher_codes_points_balance_page index
    return voucher_codes_elements[index.to_i].text
  end

  def voucher_expiry_date_points_balance_page index
    return voucher_expiry_date_elements[index.to_i].text
  end

  def voucher_expiry_days_points_balance_page index
    return voucher_expiry_days_elements[index.to_i].text
  end

  def non_perk_member_message
    return non_perk_member_message_element.span_element.text
  end

  def non_perk_point_mapping
    return points_to_reward_mapping_non_perks_element.p_element.text
  end

  def click_reward_history
    reward_history_element.click
  end

  def reward_history_section_open_presence
    reward_history_section_open_element.wait_until(&:present?)
      return true
  end

  def check_reward_type_reward_history index
    return voucher_type_elements[index].text
  end

  def check_voucher_locked_message_reward_history index
    return voucher_locked_message_elements[index].text
  end

  def check_reward_value_reward_history index
    return voucher_value_elements[index].text
  end

  def is_reward_redeemed_reward_history? index
    if voucher_status_elements[index].span_element.present?
      return true
    else
      return false
    end
  end

  def reward_redeemed_date_reward_history index
    return expired_date_elements[index].text.to_s
  end

  def spend_threshold_message
    return spend_threshold_message_element.inner_text.gsub(/"/, "")
  end

  def rewards_info_section_status action
    sleep 5
    if (action == 'expands')
      wait_and_click how_rewards_work_element
      return true if rewards_info_section_content_element.attribute_value('class') =~ /open/
    elsif (action == 'collapses')
      wait_and_click how_rewards_work_element
      return true if rewards_info_section_content_element.attribute_value('class') != ~/open/
    end
  end

  def rewards_info_section_content
    return rewards_info_section_content_element.inner_text
  end

  def is_spend_threshold_message_empty?
    if spend_threshold_message_element.present?
      return true
    else
      return false
    end
  end

  def is_reward_history_present?
    return reward_history_element.present?
  end

  def already_a_perks_member_content
    return already_a_perks_member_content_element.inner_text
  end

  def apply_voucher_to_cart voucher_id
    voucher_container_elements.find{|el| el.data_loyaltycode == voucher_id}.following_sibling.button_element.click
    wait_for_ajax
  end

  def verify_voucher_available voucher_id
    isAvailable =  voucher_container_elements.find{|el| el.data_loyaltycode == voucher_id}.following_sibling.button_element.text == "Apply Code To Bag"
    isEnabled = voucher_container_elements.find{|el| el.data_loyaltycode == voucher_id}.following_sibling.button_element.enabled?
    return isAvailable && isEnabled
  end

  def verify_voucher_applied voucher_id
    isApplied = voucher_container_elements.find{|el| el.data_loyaltycode == voucher_id}.following_sibling.button_element.text == "Applied!"
    isDisabled = voucher_container_elements.find{|el| el.data_loyaltycode == voucher_id}.following_sibling.button_element.disabled?
    return isApplied && isDisabled
  end

  def phone_number_field_presence
    return sms_opt_in_no_phone_number_element.present?
  end

  def enter_phone_number_field arg
      sms_opt_in_no_phone_number_element.focus
      sms_opt_in_with_phone_number_element.set arg
  end

  def enter_phone_number_without_country_code arg
     sms_opt_in_no_phone_number_element.send_keys(:backspace)
     sms_opt_in_no_phone_number_element.send_keys arg
  end

  def phone_number_country_code_presence
    sms_opt_in_no_phone_number_element.click
    return sms_opt_in_with_phone_number_element.value
  end

  def ph_number_error_message_text
    return ph_number_error_message_element.text
  end

  def ph_number_error_message_presence
    return ph_number_error_message_element.present?
  end

  def enter_DOB_under_allowed_age
    profile_dob_day_element[2].click
    profile_dob_month_element[8].click
    profile_dob_year_element[12].click
  end

  def underage_overlay_present
    sleep 2
    wait_and_check_element_present?(underage_overlay_element)
  end

  def underage_text
    wait_and_get_text(underage_overlay_text_element)
  end

  def DOB_checkbox_present
    dob_checkbox_element.present?
  end

  def DOB_checkbox_text arg
    wait_and_get_text(dob_checkbox_texts_elements[arg])
  end

  def select_DOB_checkbox
    wait_and_click(dob_checkbox_element)
  end

  def DOB_copy_subscription
    wait_and_get_text(dob_copy_subscription_element)
  end

  def DOB_copy_checkout
    wait_and_get_text(dob_copy_checkout_element)
  end

  def enter_password_subscribe_pg
    wait_and_set_text(password_subscribe_pg_element, "Suvisuvi14")
  end

  def brand_selected_pref_section
    # wait_and_get_text(brand_pref_element.parent)
    return (brand_pref_elements.length)
  end

  def co_brand_selected_pref_section
    return co_brand_prefs_elements.first.parent.text
  end

  def co_brand_selected_prefs_number
    co_brand_prefs_elements.length
  end

  def select_join_perks_register_pg
    join_perks_register_pg_element.click
  end
end