require 'page-object'
require 'page-object/page_factory'
require 'yaml'
require 'rspec'
require "gmail"
require_relative '../../../monkey_patch.rb'

class CheckoutPage
  include PageObject
  include Utilities
  include DataMagic

  # GENERAL PAGE OBJECTS
  text_field(:email_add, :id => 'dwfrm_login_username')
  text_field(:pass, :id => 'dwfrm_login_password')
  link(:sign_in_here, :text => 'Sign in here')
  element(:sign_me, :css => '#dwfrm_login button[value~="Sign"]')
  label(:clickncollect, :for => 'is-CLICK_AND_COLLECT')
  text_field(:first_name, :id => 'dwfrm_checkout_deliveryAndPayment_contactDetailFields_contactDetailsFirstName')
  text_field(:last_name, :id => 'dwfrm_checkout_deliveryAndPayment_contactDetailFields_contactDetailsLastName')
  text_field(:phone, :id => 'dwfrm_checkout_deliveryAndPayment_contactDetailFields_contactDetailsPhone')
  text_field(:hd_phone, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_phone')
  text_field(:find_store, :id => 'dwfrm_storelocator_textfield')
  button(:store_search_btn, :class => 'store-search-button', :index => 0)
  element(:order_sub_total, :class => 'order-subtotal')
  element(:order_total, :css => '.order-value', :index => 1)
  element(:order_summary_total, :class => 'order-value')
  div(:store_select, :xpath => '//*[@id="store-list"]/div[2]')
  # div(:store_list, :id => 'store-list')
  divs(:stores, :class => "store-details select-checkbox")
  divs(:cnc_storeid, :class => "store-details select-checkbox")
  label(:home_delivery, :for => 'is-HOME_DELIVERY')
  radio(:home_delivery_radio, :id => 'is-HOME_DELIVERY')
  radio(:cnc_radio, :id => 'is-CLICK_AND_COLLECT')
  text_field(:hd_first_name, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_firstName')
  text_field(:hd_last_name, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_lastName')
  select_list(:hd_country, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_country')
  text_field(:homdel_address1, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_address1')
  text_field(:homedel_city, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_city')
  select_list(:homedel_state_abb, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_states_state')
  text_field(:homedel_state, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_states_state')
  text_field(:homedel_postcode, :id => 'dwfrm_checkout_deliveryAndPayment_delivery_addressFields_postalCode')
  span(:err_msg_checkout, :css => '#sticky-global-error > div > div.column.shrink.error-message > span')
  div(:adyen_order_amount_display, :id => 'displayAmount')
  div(:order_amount, :id => 'displayAmount')
  td(:order_value, :css => '.order-value')
  link(:full_form_hd, :css => 'a.try-full-form')
  link(:product_row, :css => 'a[title~="Dress"]')
  element(:subscribe_btn, :css=> "label[for='dwfrm_checkout_subscriptionSignup']")
  element(:order_tot,:css => 'td.order-value')
  span(:phone_field_error_txt,:css => '#dwfrm_checkout_deliveryAndPayment_delivery_addressFields_phone-error')
  element(:tax_amt_ord_sum, :css => 'tr.order-sales-tax')
  element(:order_discount, :css => 'tr.order-discount.discount')
  div(:bag_slide_dialog, :class =>'slide-dialog-container-cart-page')
  divs(:order_summary_content, :class => 'order-summary-content')
  div(:order_summ_content, :class => 'order-summary-content', :index => 1)
  div(:perks_account_pop_up, :class => 'perk-account-create-popup')
  label(:join_perks, :for => 'dwfrm_checkout_subscriptionSignup')
  div(:dismiss_perks_pop_up, :css => '.icon-cross-standard-big-black')
  button(:create_cc_account, :class =>'create-perk-account')
  button(:close_cc_account, :xpath => '//*[@id="slide-dialog-container"]/div/div[4]/button')
  button(:close_cc_account, :xpath => '//*[@id="slide-dialog-container"]/div/div[4]/button')
  button(:continue_as_guest, :class => ['button', 'close-dialog-button'])
  div(:perks_overlay, :id => 'slide-dialog-container')
  div(:password_dialog, :class=>'set-new-password-dialog')
  text_field(:create_cc_password, :id => 'perk-account-create-password')
  text_field(:confirm_cc_password, :id => 'perk-account-create-password-confirm')
  button(:set_cc_password, :class => 'set-perk-account-password')
  divs(:mini_cart_products, :class => 'mini-cart-name')
  div(:login_header, :class => 'login-header')
  span(:txt_field_err_val_msg, :css=> "#dwfrm_checkout_deliveryAndPayment_contactDetailFields_contactDetailsFirstName-error")
  div(:perks_acc_popup, :css => ".perk-account-create-popup")
  span(:x_btn_perks_acc_popup, :css => ".icon-cross-standard-big-black")
  divs(:storeid, :class => 'store-details')
  divs(:product_line_items_in_co, :class => /^mini-cart-product row/)
  element(:shipping_del, :css => ".order-shipping")
  # button(:signup_to_perks, :class => ['button','sign-up','expanded'])
  # button(:subscribe_to_perks, :css => '.button.sign-up.expanded')
  paragraphs(:perks_header, :class => 'perk-header')
  div(:perks_description, :class => 'perk-description', :index => 0)
  paragraph(:perks_sub_description, :class => 'perk-sub-description')
  link(:already_perks_member, :class => 'already-member')
  div(:text_click, :css => 'div.asset-description')
  label(:brand_typo, :for => "3-cat-pref")
  # label(:brand_ruby, :for => "4-cat-pref")
  div(:perks_already_member_messaage, :class => 'description')
  link(:my_account, :class => 'description-my-account-link')
  div(:calculated_points, :class => 'small-12 column perks-container')
  link(:how_points_calculated, :class => 'calculated-points')
  div(:point_pop_up_box, :class => 'pop-up-box')
  div(:perks_subscribe_box_content, :class => 'perks-subscribe-box-content')
  select_list(:auth_to_leave_list, :id => 'dwfrm_shippingaddress_authorityToLeave')
  link(:back_button, :css => "a.checkout-back-button.header-arrow")
  labels(:del_address, :css => '.label-address')
  div(:del_to, :css => '#home-delivery-section')
  span(:multipack_save_text_co, :class => "multipack-container")
  elements(:delivery_methods, :class => "shipping-method callout  show-more-visible")
  element(:active_delivery_method, :class => "shipping-method callout show-more-visible active", :index => 0)
  div(:co_product_price, :class => "item-price-total", :index => 1 )
  link(:edit_button_co_pg, :class => "section-header-note", :index => 1)

  # General Accordion Changes locators:
  element(:payment_methods_section, :class =>'payment-method-options accordion')
  select_list(:dob_day, :id => 'dwfrm_checkout_profile_newsletter_day')
  select_list(:dob_month, :id => 'dwfrm_checkout_profile_newsletter_month')
  select_list(:dob_year, :id => 'dwfrm_checkout_profile_newsletter_year')
  div(:under_age_error_message, :class => "under-13-error-wrapper")

  # CC PAGE OBJECTS
  text_field(:cc_owner, :id => 'dwfrm_checkout_deliveryAndPayment_payment_paymentMethods_creditCard_owner')
  text_field(:cc_number, :id => 'dwfrm_checkout_deliveryAndPayment_payment_paymentMethods_creditCard_number')
  select_list(:cc_month, :id => 'dwfrm_checkout_deliveryAndPayment_payment_paymentMethods_creditCard_month')
  select_list(:cc_year, :id => 'dwfrm_checkout_deliveryAndPayment_payment_paymentMethods_creditCard_year')
  text_field(:cc_cvn, :id => 'dwfrm_checkout_deliveryAndPayment_payment_paymentMethods_creditCard_cvn')
  text_field(:adyen_cc_number, :id => 'card.cardNumber')
  text_field(:adyen_cc_owner, :id => 'card.cardHolderName')
  select_list(:adyen_cc_month, :id => 'card.expiryMonth')
  select_list(:adyen_cc_year, :id => 'card.expiryYear')
  text_field(:adyen_cc_cvn, :id => 'card.cvcCode')
  label(:uncheck_adyen_saved_card, :for => 'card.storeOcDetails')
  button(:payment_btn_adyen, :name => 'pay')
  label(:uncheck_save_dl_address, :for => 'dwfrm_checkout_deliveryAndPayment_delivery_addToAddressBook')
  select_list(:cc_state_abb, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_states_state')
  element(:check_same_add_cc_bill, :class => 'billing-address-container')
  div(:saved_cc_billing_add_container, :css => "div.saved-address-container.field-wrapper")
  # CC Accordion Changes locators:
  link(:credit_card, :css => "[data-paymentid='CREDIT_CARD'] a.payment-method-name", :index => 0)
  text_field(:fname_cc_payment, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_cc_payment, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:cc_payment_country, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:cc_payment_phone, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:cc_billing_address1, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:cc_billing_city, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:cc_billing_postcode, :id => 'credit_card_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  span(:check_cc_billing_add_chkbx, :css => "span[data-qa='credit_card_checkout_deliveryAndPayment_delivery_useAsBillingAddress']")
  label(:check_cc_billing_add, :for => "credit_card_checkout_deliveryAndPayment_delivery_useAsBillingAddress")
  element(:check_cc_billing_chkbx, :id => "credit_card_checkout_deliveryAndPayment_delivery_useAsBillingAddress")
  button(:cc_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 0)
  link(:full_form_cc, :css => "a.try-full-form", :index => 1)
  element(:cc_bill_add_block, :css=> ".accordion-content[style='display: block;'] .billing-address-container", :index => 0)
  label(:chkbx_cc_billing, :css => "label[for='credit_card_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)

  # SINGLE PAGE CHECKOUT CC PAGE OBJECTS
  text_field(:main_tf, :id => "shiftTabField")
  element(:frame_main, :css => ".adyen-checkout__field--cardNumber iframe.js-iframe.adyen-checkout__field--cardNumber iframe.js-iframe")
  div(:spc_card_no_wrapper, :css => "div.adyen-checkout__field--cardNumber", :index => 0)
  element(:adyen_SPC_cc_number, :css => ".adyen-checkout__input--large iframe.js-iframe[title='Iframe for secured card data input field']")
  # text_field(:adyen_SPC_cc_number, :id => 'encryptedCardNumber')
  select_list(:adyen_SPC_cc_date, :id => 'encryptedExpiryDate')
  text_field(:adyen_SPC_cc_cvn, :id => 'encryptedSecurityCode')
  spans(:saved_credit_card, :class => "cc-number")
  div(:expanded_saved_delivery_address_dropdown, :css => ".shipping-address-container div.show-more.callout.checkout-toggle-content")
  labels(:saved_delivery_addresses, :css =>".checkout-toggle-content div label.label-address")
  a(:new_card, :class => "new-creditcard", :index => 0)
  a(:new_add, :class => "add-address", :index => 0)
  button(:delete_credit_card, :css => "div.show-more.callout button.pointer.remove-saved-card", :index => 0)
  button(:confirm_delete_card, :css => "button.confirm-cc-delete", :index => 0)
  span(:save_card_chbx, :css =>"span.adyen-checkout__checkbox__label", :index => 0)
  element(:remember_me_chkbx, :css => "input.adyen-checkout__checkbox__input", :index => 0)
  elements(:iframes_saved_cards, :css => '.adyen-checkout__card__cvc__input [title="Iframe for secured card data input field"]')

  # AFTERPAY PAGE OBJECTS
  element(:afterpay_preloader, :css => ".splash-screen.loading[ng-show='! applicationVisible']")
  text_field(:afterpay_email_field, :name => 'email')
  button(:afterpay_email_continue, :css => "[automation_id='button-submit']")
  text_field(:afterpay_password_field, :name => 'password')
  button(:afterpay_sign_in, :css => "[automation_id='button-submit']")
  span(:afterpay_due_today_block_text, :css => "[automation_id='text-puf']")
  button(:afterpay_ok_payment_button, :css => "[automation_id='button-confirmPaymentUpFront']")
  span(:amt_afterpay_page, :css => "[ng-bind='model.orderDetail.amount.amount | currency: model.orderDetail.amount.symbol']")
  text_field(:afterpay_cvc_field, :css => "[automation_id='input-cardCVC']")
  checkbox(:over_eighteen_cbox, :css => "[automation_id='input-termsAgreed']")
  button(:afterpay_confirm_btn, :css => "[automation_id='button-submit']")
  span(:error_msg_afterpay, :css => ".ap-validation-error-msg")
  # Afterpay Accordion Changes locators:
  link(:afterpay_tab, :css => "[data-paymentid='AFTERPAY_PBI'] a.payment-method-name", :index => 0)
  button(:afterpay_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 1)
  element(:check_same_add_afterpay_bill, :class => "billing-address-container", :index => 1)
  text_field(:fname_afterpay_payment, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_afterpay_payment, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:afterpay_payment_country, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:afterpay_payment_phone, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:afterpay_billing_address1, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:afterpay_billing_city, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:afterpay_billing_postcode, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:afterpay_state_abb, :id => 'afterpay_pbi_checkout_deliveryAndPayment_payment_addressFields_states_state')
  label(:chkbx_afterpay_billing, :css => "label[for='afterpay_pbi_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)
  link(:full_form_afterpay, :css => "a.try-full-form", :index => 2)
  div(:saved_afterpay_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 1)
  label(:afterpay_use_same_billadd, :css => "[for='afterpay_pbi_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  span(:afterpay_use_same_billadd_chkbx, :css => "span[data-qa='afterpay_pbi_checkout_deliveryAndPayment_delivery_useAsBillingAddress']")

  # PAYPAL PAGE OBJECTS
  div(:paypal_preloader_spinner, :id => 'preloaderSpinner')
  div(:paypal_logo, :id => 'paypalLogo')
  span(:amt_paypal_page, :css => "[ng-bind-html='amount_formatted']")
  text_field(:paypal_email_field, :css => '#email')
  element(:paypal_login_section, :css => 'section#loginSection.login')
  # Paypal Accordion Changes locators:
  link(:paypal_tab, :css => "[data-paymentid='PayPal'] a.payment-method-name", :index => 0)
  button(:paypal_btn, :class => 'create-order paypal-button', :index => 0)

  # ZIP PAGE OBJECTS
  link(:zip_tab, :css => "[data-paymentid='Zip'] a.payment-method-name", :index => 0)
  button(:zip_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 2)
  label(:zip_use_same_billadd, :css => "[for='zip_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  link(:full_form_zip, :css => "a.try-full-form", :index => 3)
  text_field(:fname_zip_payment, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_zip_payment, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:zip_payment_country, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:zip_payment_phone, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:zip_billing_address1, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:zip_billing_city, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:zip_billing_postcode, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:zip_state_abb, :id => 'zip_checkout_deliveryAndPayment_payment_addressFields_states_state')
  div(:saved_zip_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 2)
  label(:chkbx_zip_billing, :css => "label[for='zip_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)
  element(:check_same_add_zip_bill, :class => "billing-address-container", :index => 2)
  div(:zip_global_error_message, :css => "div#sticky-global-error", :index => 0)

  # QUADPAY PAGE OBJECTS
  link(:quadpay_tab, :css => "[data-paymentid='QuadPay'] a.payment-method-name" , :index => 0)
  button(:quadpay_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 2)
  span(:quadpay_CO_instl_amt, :css => "span[data-bnpl-instalment='zipInstalment']", :index => 0)
  label(:quadpay_use_same_billadd, :css => "[for='quadpay_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  link(:full_form_quadpay, :css => "a.try-full-form", :index => 3)
  text_field(:fname_quadpay_payment, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_quadpay_payment, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:quadpay_payment_country, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:quadpay_payment_phone, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:quadpay_billing_address1, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:quadpay_billing_city, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:quadpay_billing_postcode, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:quadpay_state_abb, :id => 'quadpay_checkout_deliveryAndPayment_payment_addressFields_states_state')
  div(:saved_quadpay_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 2)
  label(:chkbx_quadpay_billing, :css => "label[for='quadpay_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)
  element(:check_same_add_quadpay_bill, :class => "billing-address-container", :index => 2)

  # LAYBUY PAGE OBJECTS
  link(:laybuy_tab, :css => "[data-paymentid='LAYBUY'] a.payment-method-name", :index => 0)
  span(:laybuy_inst_amt, :class => "laybuy-instalment", :index => 0)
  button(:laybuy_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 3)
  label(:laybuy_use_same_billadd, :css => "[for='laybuy_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  link(:full_form_laybuy, :css => "a.try-full-form", :index => 4)
  text_field(:fname_laybuy_payment, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_laybuy_payment, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:laybuy_payment_country, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:laybuy_payment_phone, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:laybuy_billing_address1, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:laybuy_billing_city, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:laybuy_billing_postcode, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:laybuy_state_abb, :id => 'laybuy_checkout_deliveryAndPayment_payment_addressFields_states_state')
  div(:saved_laybuy_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 5)
  label(:laybuy_chkbx_save_billing, :css => "label[for='laybuy_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)

  # LATPAY PAGE OBJECTS
  link(:latpay_tab, :css => "[data-paymentid='Latitude'] a.payment-method-name", :index => 0)
  span(:latpay_inst_amt, :class => "lat-instalment", :index => 0)
  button(:latpay_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 4)
  label(:latpay_use_same_billadd, :css => "[for='latitude_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  link(:full_form_latpay, :css => "a.try-full-form", :index => 5)
  text_field(:fname_latpay_payment, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_latpay_payment, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:latpay_payment_country, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:latpay_payment_phone, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:latpay_billing_address1, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:latpay_billing_city, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:latpay_billing_postcode, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:latpay_state_abb, :id => 'latitude_checkout_deliveryAndPayment_payment_addressFields_states_state')
  div(:saved_latpay_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 4)
  label(:latpay_chkbx_save_billing, :css => "label[for='latitude_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)

  # GENOAPAY PAGE OBJECTS
  link(:genoapay_tab, :css => "[data-paymentid='Genoapay'] a.payment-method-name", :index => 0)
  button(:genoapay_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 2)
  label(:genoapay_use_same_billadd, :css => "[for='genoapay_checkout_deliveryAndPayment_delivery_useAsBillingAddress']",  :index => 0)
  link(:full_form_genoapay, :css => "a.try-full-form", :index => 3)
  text_field(:fname_genoapay_payment, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_genoapay_payment, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:genoapay_payment_country, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:genoapay_payment_phone, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:genoapay_billing_address1, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:genoapay_billing_city, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:genoapay_billing_postcode, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:genoapay_state_abb, :id => 'genoapay_checkout_deliveryAndPayment_payment_addressFields_states_state')

  # HUMM PAGE OBJECTS
  link(:humm_tab, :css => "[data-paymentid='HUMM'] a.payment-method-name", :index => 0)
  button(:humm_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 5)
  button(:humm_nz_cont_to_payment_btn, :class => "button action expanded create-order", :index => 3)
  label(:humm_use_same_billadd, :css => "[for='humm_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  element(:humm_logo_sign_in_page, :css => "i.icon-humm-logo", :index => 0)
  text_field(:humm_email, :css => "#identity", :index => 0)
  text_field(:humm_password, :css => "#current-password", :index => 0)
  button(:humm_sign_in, :css => "button.btn-primary.btn", :index => 0)
  link(:humm_return_to_merchant_link, :css => ".back-link", :index => 0)
  button(:humm_confirm, :css => "button",  :index => 0)
  text_field(:fname_humm_payment, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_humm_payment, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:humm_payment_country, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:humm_payment_phone, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:humm_billing_address1, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:humm_billing_city, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:humm_billing_postcode, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:humm_state_abb, :id => 'humm_checkout_deliveryAndPayment_payment_addressFields_states_state')
  label(:humm_chkbx_save_billing, :css => "label[for='humm_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)
  link(:full_form_humm, :css => "a.try-full-form", :index => 6)

  # PAYFLEX PAGE OBJECTS
  link(:payflex_tab, :css => "[data-paymentid='Payflex'] a.payment-method-name", :index => 0)
  span(:playflex_CO_instl_amt, :css => "span[data-bnpl-instalment='zipInstalment']", :index => 0)
  button(:payflex_cont_to_payment_btn, :class => 'button action expanded create-order', :index => 2)
  label(:payflex_use_same_billadd, :css => "[for='payflex_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  text_field(:fname_payflex_payment, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_payflex_payment, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:payflex_payment_country, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:payflex_payment_phone, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:payflex_billing_address1, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:payflex_billing_city, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:payflex_billing_postcode, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:payflex_state_abb, :id => 'payflex_checkout_deliveryAndPayment_payment_addressFields_states_state')
  div(:saved_payflex_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 2)
  label(:chkbx_payflex_billing, :css => "label[for='payflex_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)
  element(:check_same_add_payflex_bill, :class => "billing-address-container", :index => 1)
  div(:payflex_global_error_message, :css => "div#sticky-global-error", :index => 0)

  # COD PAGE OBJECTS
  div(:cod_message, :css => ".cod-content")
  div(:cod_error_message, :css => ".cod-validation-error")
  # COD Accordion Changes locators:
  link(:cash_on_delivery_tab, :css => "[data-paymentid='CASH_ON_DELIVERY'] a.payment-method-name", :index => 0)
  button(:cod_cont_to_payment_btn, :class => "button action expanded create-order", :index => 2)

  # BANK TRANSFER PAGE OBJECTS
  # BT Accordion Changes locators:
  link(:ipay_tab, :css => "[data-paymentid='BANK_TRANSFER'] a.payment-method-name", :index => 0)

  # GIFT CARD SECTION SPECIFIC PAGE OBJECTS
  span(:gift_card_icon, :class =>'icon-gift',:index => 0)
  text_field(:gift_card_no, :class =>'vd-giftcardcode',:index => 0)
  text_field(:gift_card_pin, :class => 'vd-giftcardpin',:index => 0)
  button(:apply_gift_card, :class => 'apply-gift-certificate',:index => 0)
  span(:message_to, :css => ".messageto")
  span(:message_from, :css => ".messagefrom")
  div(:giftbag_items, :css=> ".giftbag-items")
  labels(:delivery_method, :class => 'shipping-method-label')
  #div(:applied_gift_cards, :class => 'gc-list')
  divs(:applied_gift_cards, :class =>'gift-cards-list')
  span(:order_balance_amount, :class =>'order-balance-amount',:index => 0)
  span(:gift_card_error_message, :class =>'giftcert-status-message',:index => 0)
  div(:gift_card_box, :class => 'gift-cert-box',:index => 0)
  link(:add_another_gift_card, :class => 'add-another-card',:index => 0)
  buttons(:gift_cards_to_be_removed, :class =>'remove-gift-cert')
  div(:giftbag_wrapper, :css => ".giftbag-wrapper", :index => 0)
  # GC Accordion Changes locators:
  span(:giftcard_cont_to_payment_btn, :class => 'icon icon-lock-white padlock', :index => 3)
  button(:place_order_gift_card_btn, :css => 'button.expanded.create-order', :index => 7)

  # VOUCHER SECTION PAGE OBJECTS
  div(:expand_perks_section_icon, :css => '.evoucher-box.callout', :index => 0)
  div(:app_vouchers_text, :css => '.applied-evouchers')
  span(:remove_link, :css => '.remove-evoucher-button-text')
  text_field(:voucher_text_field, :css => '#dwfrm_checkout_deliveryAndPayment_payment_voucherCode', :index => 0)
  button(:apply_voucher_btn, :css => '.apply-perks-voucher')
  div(:applied_voucher_list, :class => 'applied-evouchers')
  spans(:applied_voucher_remove_link, :class =>'underline remove-evoucher-button-text')
  div(:manual_voucher_error_message, :class =>'gift-certificate-wrapper')
  div(:minimum_spend_threshold_error, :class =>'perk-validation-error')
  divs(:applied_promo_voucher_list, :class => "row applied-vouchers-list")

  # UK SITE SPECIFIC PAGE OBJECTS
  div(:fpn_block_short_txt_checkout, :css => '#short-version')
  a(:privacy_policy_link, :css => '#show-more')
  div(:fpn_block_long_txt_checkout, :css => '#long-version')
  div(:fpn_block_checkout, :css => '.fpn-privacy-policy-container')
  buttons(:remove_voucher, :class => 'remove-loyalty-voucher')
  div(:perks_voucher_box, :class => 'evoucher-box')
  span(:perks_error_message_co, :class =>'status-message')

  # DELIVERY SECTION SPECIFIC PAGE OBJECTS
  span(:standard_delivery_date, :css => "[for='shipping-method-2000001000854_Australia'] span.estimate-date")
  span(:express_delivery_date, :css => "[for='shipping-method-2000001200858_AustraliaExpress'] span.estimate-date")
  span(:personalised_delivery_date, :css => "[for='shipping-method-2000005100857_AU_Personalisation'] span.estimate-date")
  label(:personalised_shipping_method, :css => "[for='shipping-method-2000005100857_AU_Personalisation']")
  span(:registered_delivery_method_dropdown, :css => ".shipping-methods-container .show-more-header .icon-arrow-gray-large")
  span(:saved_address_dropdown, :css => ".selected-method .toggle-icon")
  div(:expanded_saved_address_dropdown, :css => ".show-more")
  label(:email_delivery, :css => "[for='shipping-method-emailDelivery']", :index => 0)

  # SMS OPT IN FUNCTIONALITY SPECIFIC PAGE OBJECTS
  label(:sms_optin_checkbox_guest, :css => "[for='dwfrm_checkout_deliveryAndPayment_contactDetailFields_smsOptInGuest']", :index => 0)
  label(:sms_optin_checkbox_bluebox, :css => "[for='dwfrm_checkout_profile_newsletter_smsOptIn']", :index => 0)
  span(:mobile_number_error_message, :id => "dwfrm_checkout_deliveryAndPayment_contactDetailFields_contactDetailsPhone-error")
  text_field(:mobile_number_bluebox, :css => "[name='dwfrm_checkout_profile_newsletter_phone']",:index => 0)
  span(:mobile_field_bluebox_error_message, :css => "span#dwfrm_checkout_profile_newsletter_phone-error.error",:index => 0)
  span(:perks_user_number_bluebox, :class => "saved-phone-value", :index => 0)
  span(:change_link_bluebox, :class => "change-phone", :index => 0)

  # KLARNA SPECIFIC PAGE OBJECTS
  link(:klarna_tab, :css => "[data-paymentid='Klarna'] a.payment-method-name", :index => 0)
  span(:klarna_instll_amt, :css => "span[data-bnpl-instalment='klarnaInstalmentX4']")
  span(:klarna_instll_amt_GB, :css => "span[data-bnpl-instalment='klarnaInstalmentX3']")
  button(:klarna_cont_to_payment_btn_us, :class => "button action expanded create-order", :index => 3)
  button(:klarna_cont_to_payment_btn_au, :class => "button action expanded create-order", :index => 6)
  button(:klarna_cont_to_payment_btn_gb, :class => "button action expanded create-order", :index => 1)
  element(:check_same_add_klarna_bill, :class => "billing-address-container", :index => 3)
  label(:klarna_use_same_billadd, :css => "[for='klarna_checkout_deliveryAndPayment_delivery_useAsBillingAddress']", :index => 0)
  div(:saved_klarna_billing_add_container, :css => "div.saved-address-container.field-wrapper", :index => 2)
  text_field(:fname_klarna_payment, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_firstName')
  text_field(:lname_klarna_payment, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_lastName')
  select_list(:klarna_payment_country, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_country')
  text_field(:klarna_payment_phone, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_phone')
  text_field(:klarna_billing_address1, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_address1')
  text_field(:klarna_billing_city, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_city')
  text_field(:klarna_billing_postcode, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_postalCode')
  select_list(:klarna_state_abb, :id => 'klarna_checkout_deliveryAndPayment_payment_addressFields_states_state')
  label(:chkbx_klarna_billing, :css => "label[for='klarna_checkout_deliveryAndPayment_payment_addToAddressBook']", :index => 0)
  link(:full_form_klarna, :css => "a.try-full-form", :index => 4)

  List_Array = []
  def click_store storeid
    def list_of_stores
      stores_elements.each do |div|
        List_Array << div.attribute_value("data-id")
      end
    end
    sleep 2
    list_of_stores
    wait_for_ajax
    begin
      retries ||= 0
      list_of_stores.find{|el| el.attribute_value("data-id").to_i == storeid.to_i}.click
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue  Selenium::WebDriver::Error::ElementNotInteractableError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue NoMethodError
      sleep 10
      retry if (retries += 1) < $code_retry
    end
  end

  def select_cnc_store_co_pg storeid
    begin
      retries ||= 0
      @store = cnc_storeid_elements.find{|el| el.attribute_value("data-id").to_i == storeid.to_i}
      wait_and_click(@store)
    rescue Watir::Wait::TimeoutError
      retry if (retries += 1) < $code_retry
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue NoMethodError
      sleep 10
      retry if (retries += 1) < $code_retry
    end
    return @store.attribute_value("class")
  end

  def uncheck_saved_card
    wait_for_ajax
    begin
      retries ||= 0
      @browser.execute_script("document.getElementById('dwfrm_checkout_deliveryAndPayment_payment_paymentMethods_creditCard_saveCard').click();")
    rescue Selenium::WebDriver::Error::UnknownError
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      wait_for_ajax
      retry if (retries += 1) < $code_retry
    end
  end

  def is_full_form_cnc_open
    full_form_hd_element.present?
  end

  def click_full_form
    Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
    wait_for_ajax
    @browser.execute_script("document.querySelectorAll('a.try-full-form')[1].click();")
  end

  def click_full_form_cc
    wait_for_ajax
    if full_form_cc_element.present?
      wait_and_click full_form_cc_element
    end
  end

  def is_full_form_hd_open
    # wait_for_ajax
    sleep 2
    return wait_and_check_element_present? full_form_hd_element
  end

  def click_full_form_hd
    # wait_for_ajax
    sleep 2
    wait_and_click full_form_hd_element
  end

  def place_order_gift_card
    wait_for_ajax
    wait_and_click place_order_gift_card_btn_element
  end

  def cc_place_order
    sleep 2
    wait_and_click cc_cont_to_payment_btn_element
  end

  def afterpay_place_order
    sleep 2
    wait_and_click afterpay_cont_to_payment_btn_element
  end

  def cod_place_order
    sleep 2
    wait_and_click cod_cont_to_payment_btn_element
  end

  def gotopage arg
    @browser.goto "#{FigNewton.nz_url}" + "/" + arg + ".html"
  end

  def enter_email email_address
    begin
      retries ||= 0
      (email_add == "")? Watir::Wait.until {email_add_element}.set(email_address):return
    rescue Selenium::WebDriver::Error::UnknownError
      retry if (retries += 1) < $code_retry
    rescue Watir::Exception::UnknownObjectException
      retry if (retries += 1) < $code_retry
    end
  end

  def enter_pass password
    wait_for_ajax
    wait_and_set_text pass_element, password
  end

  def click_sign_in_here
    sleep 2
    wait_for_ajax
    sign_in_here_element.when_present.click
  end

  def sign_me_btn
    #need to remove the below sleep replace with wait for div -> .loader-bg
    #sleep 10
    Watir::Wait.until {sign_me_element}.wait_until_present.click
    sleep 10
    # wait_for_ajax(timeout=120)
  end

  def cnc
    wait_and_click clickncollect_element
    wait_for_ajax
  end

  def hd
    if home_delivery_element.present?
      wait_and_click home_delivery_element
    end
    sleep 2
    # wait_for_ajax
  end

  def enter_hd_first_name arg
    wait_and_check_element_present? order_summ_content_element
    wait_and_set_text hd_first_name_element,arg
  end

  def enter_hd_last_name arg
    wait_and_check_element_present? order_summ_content_element
    wait_and_set_text hd_last_name_element,arg
  end

  def enter_hd_country arg
    wait_and_check_element_present? order_summ_content_element
    wait_and_select_option hd_country_element,arg
  end

  def enter_hd_phone_number arg
    wait_and_check_element_present? order_summ_content_element
    wait_and_set_text hd_phone_element, arg
  end

  def enter_first_name arg
    wait_and_check_element_present? order_summ_content_element
    wait_and_set_text first_name_element, arg
  end

  def enter_last_name arg
    # wait_for_ajax
    wait_and_set_text last_name_element, arg
  end

  def clear_phone_number
    phone_element.focus
    phone_element.clear
  end

  def enter_phone_number_gb arg
    phone_element.focus
    phone_element.set(arg)
  end

  def enter_phone_number arg
    # wait_for_ajax
    phone_element.focus
    @phone = phone_element.value
    if @phone == '+61'
      phone_element.focus
      phone_element.send_keys(:backspace,:backspace,:backspace)
      phone_element.set(arg)
    else
      if @phone != arg.to_s
        phone_element.focus
        phone_element.send_keys(:backspace,:backspace,:backspace)
        phone_element.set(arg)
      end
    end
  end

  def uncheck_save_del_add
    wait_for_ajax
    wait_and_click uncheck_save_dl_address_element
  end

  def find_my_store arg
    wait_for_ajax
    wait_and_set_text find_store_element, arg
  end

  def store_search_button
    wait_for_ajax
    wait_and_click store_search_btn_element
  end

  def order_summary_total
    wait_for_ajax
    @order_ttl = wait_and_get_text order_tot_element
    @order_ttl = @order_ttl.gsub(/[^.0-9\-]/,"")
    return @order_ttl
  end

  def order_summary_total_spc
    @order_ttl = wait_and_get_text order_tot_element
    @order_ttl = @order_ttl.gsub(/[^.0-9\-]/,"")
    return @order_ttl
  end

  def click_cc
    if credit_card_element.attribute_value("aria-expanded") == 'false'
      sleep 2
      wait_and_click(credit_card_element)
      wait_for_ajax
    end
  end

  def check_cc_use_billing_address
    wait_for_ajax
    while(check_cc_billing_add_element.attribute_value('aria-checked') == "true")
      wait_and_click(check_cc_billing_add_chkbx_element)
    end
  end

  def select_cc_use_billing_address
    wait_for_ajax
    while(check_cc_billing_add_element.attribute_value('aria-checked') == "false")
      wait_and_click(check_cc_billing_add_chkbx_element)
    end
  end

  def continue_to_payment_btn
    wait_for_ajax
    wait_and_click cont_to_payment_btn_element
  end

  def enter_adyen_valid_cc_details cc_no,name,cc_month,cc_year,cc_cvn
    wait_and_set_text adyen_cc_number_element, cc_no
    wait_and_set_text adyen_cc_owner_element, name
    wait_and_select_option adyen_cc_month_element, cc_month
    wait_and_select_option adyen_cc_year_element, cc_year
    wait_and_set_text adyen_cc_cvn_element, cc_cvn
  end

  def uncheck_saved_card_adyen
    wait_and_click uncheck_adyen_saved_card_element
  end

  def get_order_total_on_adyen_page
    @order_tot_adyen_page = wait_and_get_text adyen_order_amount_display_element
    @order_tot_adyen_page = @order_tot_adyen_page.gsub(/[^.0-9\-]/,"")
    return @order_tot_adyen_page
  end

  def get_order_total_on_afterpay_page
    wait_for_ajax
    @order_tot = wait_and_get_text order_amount_element
    @order_tot = @order_tot.gsub(/[^.0-9\-]/,"")
    return @order_tot
  end

  def get_order_total
    $order_tot_checkout_page = wait_and_get_text order_value_element
    $order_tot_checkout_page = $order_tot_checkout_page.gsub(/[^.0-9\-]/,"")
    return $order_tot_checkout_page
  end

  def place_order_adyen
    wait_and_click payment_btn_adyen_element
  end

  def enter_cc_billing_info fname, lname, country, phone
    wait_for_ajax
    wait_and_set_text fname_cc_payment_element, fname
    wait_for_ajax
    wait_and_set_text lname_cc_payment_element, lname
    wait_for_ajax
    wait_and_select_option cc_payment_country_element, country
    wait_for_ajax
    wait_and_set_text cc_payment_phone_element, phone
  end

  def enter_cc_billing_info_guest fname, lname, country
    wait_for_ajax
    wait_and_set_text fname_cc_payment_element, fname
    wait_for_ajax
    wait_and_set_text lname_cc_payment_element, lname
    wait_for_ajax
    wait_and_select_option cc_payment_country_element, country
  end

  def enter_cc_billing_fname fname
    wait_for_ajax
    wait_and_set_text fname_cc_payment_element, fname
  end

  def enter_cc_billing_lname lname
    wait_for_ajax
    wait_and_set_text lname_cc_payment_element, lname
  end

  def set_cc_billing_country country
    wait_and_select_option cc_payment_country_element, country
    wait_for_ajax
  end

  def enter_cc_billing_address bill_add1, bill_city, bill_pc, cc_state
    wait_and_set_text cc_billing_address1_element, bill_add1
    wait_and_set_text cc_billing_city_element, bill_city
    wait_and_set_text cc_billing_postcode_element, bill_pc
    wait_and_select_option cc_state_abb_element, cc_state

  end

  def enter_cc_billing_address1 bill_add1
    wait_and_set_text cc_billing_address1_element, bill_add1
  end

  def enter_cc_billing_city bill_city
    wait_and_set_text cc_billing_city_element, bill_city
  end

  def enter_cc_billing_postcode bill_pc
    wait_and_set_text cc_billing_postcode_element, bill_pc
  end

  def select_cc_billing_state cc_state
    wait_and_select_option cc_state_abb_element, cc_state
  end

  def enter_cc_adyen_phone adyen_phone
    wait_and_set_text cc_payment_phone_element, adyen_phone
    @browser.send_keys :tab
  end

  def uncheck_add_to_addressbook
    wait_and_click(chkbx_cc_billing_element)
  end

  def enter_afterpay_billing_fname fname
    wait_for_ajax
    wait_and_set_text fname_afterpay_payment_element, fname
  end

  def enter_afterpay_billing_lname lname
    wait_for_ajax
    wait_and_set_text lname_afterpay_payment_element, lname
  end

  def set_afterpay_billing_country country
    wait_and_select_option afterpay_payment_country_element, country
  end

  def enter_afterpay_billing_address1 bill_add1
    wait_and_set_text afterpay_billing_address1_element, bill_add1
  end

  def enter_afterpay_billing_city bill_city
    wait_and_set_text afterpay_billing_city_element, bill_city
  end

  def enter_afterpay_billing_postcode bill_pc
    wait_and_set_text afterpay_billing_postcode_element, bill_pc
  end

  def select_afterpay_billing_state cc_state
    wait_and_select_option afterpay_state_abb_element, cc_state
  end

  def enter_afterpay_phone phone
    wait_and_set_text afterpay_payment_phone_element, phone
    @browser.send_keys :tab
  end

  def uncheck_add_to_addressbook_afterpay
    wait_and_click(chkbx_afterpay_billing_element)
  end

  def click_full_form_afterpay
    wait_for_ajax
    if full_form_afterpay_element.present?
      wait_and_click full_form_afterpay_element
    end
  end

  def saved_afterpay_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_afterpay_billing_add_container_element
  end

  def enter_hd_delivery_address hd_add1, hd_city, hd_state, hd_pc
    sleep 2
    wait_and_set_text homdel_address1_element, hd_add1
    wait_and_set_text homedel_city_element, hd_city
    wait_and_select_option homedel_state_abb_element, hd_state
    wait_and_set_text homedel_postcode_element, hd_pc
    @browser.send_keys :tab
    sleep 5
  end

  def enter_uk_hd_delivery_address hd_add1, hd_city, hd_state, hd_pc
    wait_for_ajax
    wait_and_set_text homdel_address1_element, hd_add1
    wait_and_set_text homedel_city_element, hd_city
    wait_and_set_text homedel_state_element, hd_state
    wait_and_set_text homedel_postcode_element, hd_pc
    sleep 5
  end

  def enter_billing_info_adyen fname, lname, country
    wait_for_ajax
    wait_and_set_text fname_payment_element, fname
    wait_and_set_text lname_payment_element, lname
    wait_and_select_option payment_country_element, country
  end

  def same_add_cc_billing_checked?
    wait_for_ajax
    # return true if payment_methods_section_element.attribute_value('style') =~ /none/
    if check_same_add_cc_bill_element.attribute_value('class') =~ /hide/
      return true
    else
      return false
    end
  end

  def same_add_cc_billing_uncheck
    @browser.execute_script("document.querySelectorAll('[for='credit_card_checkout_deliveryAndPayment_delivery_useAsBillingAddress']')[0].click();")
  end

  def same_add_afterpay_billing_checked?
    if check_same_add_afterpay_bill_element.attribute_value('class') =~ /hide/
      return true
    else
      return false
    end
  end

  def same_add_afterpay_billing_uncheck
    wait_for_ajax
    while(afterpay_use_same_billadd_element.attribute_value('aria-checked') == "true")
      wait_and_click(afterpay_use_same_billadd_chkbx_element)
    end
    # @browser.execute_script("document.querySelectorAll('[for='afterpay_pbi_checkout_deliveryAndPayment_delivery_useAsBillingAddress']')[0].click();")
  end

  def is_hd_checked
    return wait_is_checkbox_checked? home_delivery_radio_element
  end

  def is_cnc_checked
    return wait_is_checkbox_checked? cnc_radio_element
  end

  def error_msg_checkout
    return wait_and_get_text err_msg_checkout_element
  end

  def click_paypal_tab
    sleep 2
    wait_and_click paypal_tab_element
  end

  def click_afterpay_tab
    # refactor and remove the sleep, removing this sleep breaks jenkins job
    sleep 2
    wait_and_click afterpay_tab_element
  end

  def click_paypal_button
    sleep 2
    wait_and_click paypal_btn_element
  end


  def afterpay_preloader_spinner_wait
    Watir::Wait.until(timeout = 60){afterpay_preloader_element.not_present?}
  end

  def click_product_row
    Watir::Wait.until {product_row_element}.click
  end

  def check_subscribe_btn
    # refactor and remove the sleep, removing this sleep breaks jenkins job
    sleep 10
    Watir::Wait.until {subscribe_btn_element}.click
  end

  def phone_error_text
    return wait_and_get_text phone_field_error_txt_element
  end

  def get_tax_amt
    # wait_for_ajax
    sleep 2
    @tax_amount = wait_and_get_text(tax_amt_ord_sum_element)
    @tax_amount = @tax_amount.gsub(/[^.0-9\-]/,"")
    return @tax_amount
  end

  def order_disc
    @order_dis = wait_and_get_text order_discount_element
    @order_dis = @order_dis.gsub(/[^.0-9]/,"")
    return @order_dis
  end

  def expand_perks_section
    wait_and_check_element_focus expand_perks_section_icon_element
    if expand_perks_section_icon_element.attribute_value('class') !~ /opened/
      wait_and_click(expand_perks_section_icon_element)
    end
  end

  def order_total_value
    @order_total = wait_and_get_text order_total_element
    @order_total = @order_total.gsub(/[^.0-9\-]/,"")
    return @order_total
  end

  def enter_voucher voucher_num
    sleep 2
    voucher_text_field_element.when_present.set voucher_num
  end

  def click_apply_voucher_btn
    apply_voucher_btn_element.when_present.click
  end

  def fpn_validation_checkout_page
    @fpn_block = wait_and_get_text fpn_block_short_txt_checkout_element
    @fpn_block = @fpn_block.gsub(/[\n]/,"")
    return @fpn_block
  end

  def privacy_policy_checkout_page_link
    wait_for_ajax
    wait_and_click privacy_policy_link_element
  end

  def privacy_policy_text_long_version
    @fpn_block_long = wait_and_get_text fpn_block_long_txt_checkout_element
    @fpn_block_long = @fpn_block_long.gsub(/[\n]/,"")
    return @fpn_block_long
  end

  def fpn_block_present
    begin
      @value_fpn_block = fpn_block_checkout_element.exists?
    rescue
      @value_fpn_block = false
      return if @value_fpn_block == 'false'
    end
  end

  def applied_vouchers
    wait_for_ajax
    return applied_voucher_list_element.wait_until(&:present?).text.gsub(/[^.0-9\-]/,"")
  end

  def check_remove_link (index)
    return applied_voucher_remove_link_elements[index].present?
  end

  def check_voucher_error_message
    return Watir::Wait.until {manual_voucher_error_message_element.span_element}.text
  end

  def check_overlay_pop_up_message
    bag_slide_dialog_element.wait_until do |s|
      # s.present? && s.style('overflow') == 'visible'
      s.present? && s.style('display') == 'block'
    end
    #return minimum_spend_threshold_error_element.span_elements[1].text
    return minimum_spend_threshold_error_element.inner_text
  end

  def dismiss_error_overlay_presence
    if minimum_spend_threshold_error_element.present?
      return true
    else
      false
    end
  end

  def dismiss_overlay_pop_up_message
    minimum_spend_threshold_error_element.span_elements[0].when_present.click
    bag_slide_dialog_element.wait_while(&:present?)
  end

  def edit_bag_on_checkout
    wait_for_ajax
    Watir::Wait.until{order_summary_content_elements[1].link_element}.click
  end

  def click_ipay
    wait_and_click ipay_tab_element
  end

  def order_summary_content_visible?
    wait_and_check_element_present? order_summ_content_element
  end

  def find_failed_order_number url
    @uri = Addressable::URI.parse("#{url}")
    @merchant_ref = @uri.query_values['merchantReference']
    return @merchant_ref
  end


  def loyalty_account_pop_up_message
    wait_for_ajax
    perks_account_pop_up_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    return perks_account_pop_up_element.when_present(timeout = 30).text.gsub(/\n+/,"")
  end

  def is_perks_checkbox_visible
    wait_for_ajax
    return join_perks_element.present?
  end

  def perks_checkbox_status
    wait_for_ajax
    return join_perks_element.enabled?
  end

  def select_join_perks
    wait_for_ajax
    join_perks_element.click
  end

  def tab_out
    @browser.send_keys :tab
  end

  def verify_perks_popup_buttons
    flag = (create_cc_account_element.present? && close_cc_account_element.present?)
    close_cc_account_element.when_present(timeout = 30).click
    return flag
  end

  def create_online_account
    create_cc_account_element.when_present.click
  end

  def password_dialogue
    wait_for_ajax
    password_dialog_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    return password_dialog_element.when_present.text.gsub(/\n+/,"")
  end

  def confirm_online_password
    create_cc_password_element.when_present.set('radiation123')
    confirm_cc_password_element.when_present.set('radiation123')
    set_cc_password_element.when_present.click
  end

  def product_in_checkout_page (sku,count)
    wait_for_ajax
    return mini_cart_products_elements[count+1].link_element.when_present.href
  end

  def first_name_checkout
    return first_name
  end

  def last_name_checkout
    return last_name
  end

  def continue_as_guest
    perks_overlay_element.wait_until do |s|
      s.present? && s.style('overflow') == 'visible'
    end
    continue_as_guest_element.wait_until(&:present?).click
    sleep 5
  end

  def is_perks_pop_up_visible
    return perks_account_pop_up_element.present?
  end

  def is_password_visible
    wait_for_ajax
    return pass_element.visible?
  end

  def login_header
    wait_for_ajax
    return login_header_element.when_present.text.gsub(/\n+/," ")
  end

  def txt_field_err_validation
    return wait_and_get_text txt_field_err_val_msg_element
  end

  def enter_hd_add_1 hd_add1
    wait_and_set_text homdel_address1_element, hd_add1
  end

  def enter_hd_city hd_city
    wait_and_set_text homedel_city_element, hd_city
  end

  def enter_hd_state hd_state
    wait_and_select_option homedel_state_abb_element, hd_state
  end

  def enter_hd_pc hd_pc
    wait_and_set_text homedel_postcode_element, hd_pc
  end

  def perks_acc_popup_present?
    Watir::Wait.until{perks_acc_popup_element}.focus
    return Watir::Wait.until{perks_acc_popup_element}.present?
  end

  def x_btn_perks_acc_popup_click
    Watir::Wait.until{x_btn_perks_acc_popup_element}.click
  end

  def get_password_token
    begin
      retries ||= 0
      Gmail.new("cottononqa@gmail.com", "cottononqa123") do |gmail|
        email = gmail.inbox.emails(:from => 'orders@cottonon.com', :subject => 'Activate your online account').last
        return email.body.decoded[/https:\/\/ci.cottonon.com(.*)Password\?Token=(.*)/].gsub(/"/,"")
      end
    rescue
      retry if (retries += 1) < $code_retry
    end
  end

  def return_co_browser_url
    Watir::Wait.until(timeout: 300) {@browser.execute_script('return jQuery.active == 0')}
    return (@browser.url)
  end

  def check_copage_line_item line_item
    return Watir::Wait.until {product_line_items_in_co_elements.find {|a| a.attribute_value('innerHTML').include? line_item }}.attribute_value('innerHTML') != ""
  end

  def check_copage_line_item_sku(line_item, item_qty)
    @copage_line_item_text = Watir::Wait.until {product_line_items_in_co_elements.find{|e| e.attribute_value('innerHTML').include? line_item}}.attribute_value('innerText')
    @copage_line_item_text = @copage_line_item_text.gsub(/\n+/,"")
    return @copage_line_item_text.include? "Qty:#{item_qty}"
  end

  def remove_voucher voucher_id
    remove_voucher_elements.find{|el| el.data_gift_id.to_i == voucher_id.to_i}.click
    wait_for_ajax
  end

  def get_shipping_del_co
    @shipping_del = (wait_and_get_text(shipping_del_element)).gsub(/[AUS$Delivery\n+]/,"")
    return @shipping_del
  end

  def perks_header_text member
    sleep 5
    # wait_for_ajax
    return perks_header_elements[1].inner_text if member == 'nonperks_member_section'
    return perks_header_elements[0].inner_text if member == 'perks_member_section'
  end

  def perks_description_text
    return perks_description_element.inner_text
  end

  def perks_sub_description_text
    return perks_sub_description_element.inner_text
  end

  def select_brands
    text_click_element.click
    brand_typo_element.click
    # if brand_ruby_element.present?
    #   text_click_element.click
    #   brand_ruby_element.click
    # end
  end

  # def signup_to_perks_present
  #   return signup_to_perks_element.present?
  # end

  def join_perks_chkbx_present
    return join_perks_element.present?
  end

  def subscribe_to_perks
    subscribe_to_perks_element.click
  end

  def already_perks_member_present
    return already_perks_member_element.present?
  end

  def how_points_calculated_text
    return how_points_calculated_element.inner_text
  end

  def is_point_pop_up_box_visible
    wait_for_ajax
    return point_pop_up_box_element.visible?
  end

  def select_auth_to_leave atl_select
    if auth_to_leave_list_element.present?
      wait_and_select_option auth_to_leave_list_element, atl_select
      wait_for_ajax
      sleep 2
    else
      return
    end
  end

  def expand_giftcard_textbox
    return if gift_card_box_element.attribute_value('class') =~ /show-more/
    wait_for_ajax
    gift_card_icon_element.click
  end

  def applied_gift_card index
    # gc_index = (index.to_i-1)*2+1
    # return applied_gift_cards_element.children[gc_index].children[0].text
    #applied_gift_cards_elements[0].div_element(index: 0).text
    applied_gift_cards_elements[index.to_i].div_element(:index => 0).text

  end

  def amount_taken_gift_card index
    # gc_index = (index.to_i-1)*2+1
    # return applied_gift_cards_element.children[gc_index].children[1].text
    #applied_gift_cards_elements[0].div_element(index: 1).text
    applied_gift_cards_elements[index.to_i].div_element(:index => 1).text

  end

  def is_cc_visible
    sleep 5
    return credit_card_element.visible?
  end

  def is_paypal_visible
    return paypal_tab_element.visible?
  end

  def is_afterpay_visible
    return afterpay_tab_element.visible?
  end

  def verify_gift_card_focus
    return gift_card_no_element.focused?
  end

  def add_another_gift_card_visible
    return add_another_gift_card_element.visible?
  end

  def remove_gift_card gift_card_id
    gift_cards_to_be_removed_elements.find{|el| el.data_gcid.to_i == gift_card_id.to_i}.click
  end

  def remove_already_applied_gift_cards
    no_of_applied_gift_cards = gift_cards_to_be_removed_elements.size
    if no_of_applied_gift_cards != 0
      while no_of_applied_gift_cards != 0 do
        gift_cards_to_be_removed_elements[no_of_applied_gift_cards-1].click
        wait_for_ajax
        no_of_applied_gift_cards = no_of_applied_gift_cards - 1
      end
    end
  end

  def gift_card_box_expanded
    return true if gift_card_box_element.attribute_value('class') =~ /show-more/
    wait_for_ajax
    wait_and_select_option auth_to_leave_list_element, atl_select
  end

  def auth_to_leave_present?
    wait_for_ajax
    wait_and_check_element_present? auth_to_leave_list_element
  end

  def get_giftbag_to_txt
    wait_for_ajax
    return wait_and_get_text message_to_element
  end

  def get_giftbag_from_txt
    wait_for_ajax
    return wait_and_get_text message_from_element
  end

  def get_giftbag_items_txt
    return (wait_and_get_text(giftbag_items_element)).gsub(/[\n+]/,"")
  end

  def select_delivery_method delivery
    delivery_method_elements.find {|el| el.text =~ /#{delivery}/}.click
  end

  def cc_bill_add_block_present?
    wait_for_ajax
    return wait_and_check_element_present? cc_bill_add_block_element
  end

  def is_giftcard_present gift_card_number
    return applied_gift_cards_elements.map {|el| el.data_gcid.to_i}.include? gift_card_number
  end

  def is_perks_section_visible?
    return perks_voucher_box_element.present?
  end

  def populate_check_out_page_with_data
    populate_page_with data_for(:order_details)
  end

  def err_msg_afterpay_tab
    return wait_and_get_text error_msg_afterpay_element
  end

  def click_address_deliver_to int
    if !(expanded_saved_address_dropdown_element.present?)
      wait_and_click saved_address_dropdown_element
    end
    wait_and_click del_address_elements[(int.to_i) -1]
    wait_for_ajax
  end

  def get_giftwrap_section_text
    return (wait_and_get_text(giftbag_wrapper_element)).gsub(/[\n+]/,"")
  end

  def click_cash_on_delivery_tab
    sleep 2
    wait_and_click cash_on_delivery_tab_element
  end

  def cod_tab_message
    return wait_and_get_text cod_message_element
  end

  def cod_error_message
    return wait_and_get_text cod_error_message_element
  end

  def standard_estimated_delivery_date
    wait_for_ajax
    standard_delivery_date_element.wait_until(&:present?).click
    wait_and_get_text standard_delivery_date_element
  end

  def personalised_estimated_delivery_date
    wait_for_ajax
    personalised_delivery_date_element.wait_until(&:present?).click
    wait_and_get_text personalised_delivery_date_element
  end

  def express_estimated_delivery_date
    wait_for_ajax
    express_delivery_date_element.wait_until(&:present?).click
    wait_and_get_text express_delivery_date_element
  end

  def registered_delivery_method_dropdown
    registered_delivery_method_dropdown_element.wait_until(&:present?)
    wait_for_ajax
    registered_delivery_method_dropdown_element.click
    wait_for_ajax
  end

  def cnc_store_estimated_delivery_date store_id
    @elements = storeid_elements.find{|el| el.label.attribute_value('for')== store_id}.divs
    @elements.find{|el| el.attribute_value('class') == "estimated-delivery-date"}.text
    # storeid_elements.find{|el| el.label.attribute_value('for')== store_id.divs.attribute_value('class') == "estimated-delivery-date"}.text
  end

  def saved_address_dropdown_present?
    return wait_and_check_element_present? saved_address_dropdown_element
  end

  def saved_cc_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_cc_billing_add_container_element
  end

  def sms_opt_in_checkbox_presence
    return (wait_and_check_element_present? sms_optin_checkbox_guest_element).to_s
  end

  def mobile_number_country_code_presence
    phone_element.click
    return phone_element.value
  end

  def enter_mobile_number_with_country_code arg
    phone_element.focus
    phone_element.set arg
  end

  def enter_mobile_number_without_country_code arg
    phone_element.send_keys(:backspace)
    phone_element.send_keys arg
  end

  def mobile_number_error_message_text
    return mobile_number_error_message_element.text
  end

  def check_sms_opt_in_checkbox user_type
    case user_type
    when 'Non perks guest'
      sms_optin_checkbox_guest_element.click
    when 'Non perks registered', 'Perks'
      sms_optin_checkbox_bluebox_element.click
    end
  end

  def sms_opt_in_checkbox_bluebox_presence
    return (wait_and_check_element_present? sms_optin_checkbox_bluebox_element).to_s
  end

  def mobile_number_bluebox_country_code_presence
    sleep 2
    mobile_number_bluebox_element.click
    return mobile_number_bluebox_element.value
  end

  def enter_mobile_number_bluebox arg
    mobile_number_bluebox_element.focus
    mobile_number_bluebox_element.send_keys(:backspace,:backspace,:backspace)
    mobile_number_bluebox_element.set(arg)
  end

  def mobile_number_bluebox_text
    mobile_number_bluebox_element.value
  end

  def bluebox_error_message_text
    mobile_field_bluebox_error_message_element.text
  end

  def perks_user_number_value
    wait_for_ajax
    wait_and_get_text perks_user_number_bluebox_element
  end

  def change_link_bluebox_presence
     wait_and_check_element_present? change_link_bluebox_element
  end

  def click_change_link_bluebox
    change_link_bluebox_element.click
  end

  def click_back_button_bag_page
    wait_and_click(back_button_element)
    sleep 2
  end

  def click_zip_tab
    wait_and_click zip_tab_element
  end

  def zip_place_order
    sleep 2
    wait_and_click zip_cont_to_payment_btn_element
  end

  def get_order_total_on_zip_page
    wait_for_ajax
    @order_tot = wait_and_get_text order_amount_element
    @order_tot = @order_tot.gsub(/[^.0-9\-]/,"")
    return @order_tot
  end

  def enter_zip_billing_fname fname
    wait_and_set_text fname_zip_payment_element, fname
  end

  def enter_zip_billing_lname lname
    wait_and_set_text lname_zip_payment_element, lname
  end

  def set_zip_billing_country country
    wait_and_select_option zip_payment_country_element, country
  end

  def enter_zip_billing_address1 bill_add1
    wait_and_set_text zip_billing_address1_element, bill_add1
  end

  def enter_zip_billing_city bill_city
    wait_and_set_text zip_billing_city_element, bill_city
  end

  def enter_zip_billing_postcode bill_pc
    wait_and_set_text zip_billing_postcode_element, bill_pc
  end

  def select_zip_billing_state cc_state
    wait_and_select_option zip_state_abb_element, cc_state
  end

  def enter_zip_phone phone
    wait_and_set_text zip_payment_phone_element, phone
  end

  def uncheck_add_to_addressbook_zip
    wait_and_click(chkbx_zip_billing_element)
  end

  def click_full_form_zip
    wait_for_ajax
    if full_form_zip_element.present?
      wait_and_click full_form_zip_element
    end
  end

  def saved_zip_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_zip_billing_add_container_element
  end

  def same_add_zip_billing_checked?
    wait_for_ajax
    if check_same_add_zip_bill_element.attribute_value('class') =~ /hide/
      return true
    else
      return false
    end
  end

  def same_add_zip_billing_uncheck
    if zip_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      wait_and_click(zip_use_same_billadd_element)
    end
    # @browser.execute_script("document.querySelectorAll('[for='zip_checkout_deliveryAndPayment_delivery_useAsBillingAddress']')[0].click();")
  end

  # def zip_preloader_spinner_wait
  #   Watir::Wait.until(timeout = 60){zip_preloader_element.not_present?}
  # end

  def err_msg_zip_tab
    return wait_and_get_text error_msg_zip_element
  end

  def zip_global_error_message_text
    wait_and_get_text(zip_global_error_message_element)
  end

  def click_laybuy_tab
    wait_and_click laybuy_tab_element
  end

  def same_add_laybuy_billing_checked?
    wait_for_ajax
    if laybuy_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      return true
    else
      return false
    end
  end

  def same_add_laybuy_billing_uncheck
    if laybuy_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      wait_and_click(laybuy_use_same_billadd_element)
    end
  end

  def saved_laybuy_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_laybuy_billing_add_container_element
  end

  def enter_laybuy_billing_fname fname
    wait_and_set_text fname_laybuy_payment_element, fname
  end

  def enter_laybuy_billing_lname lname
    wait_and_set_text lname_laybuy_payment_element, lname
  end

  def set_laybuy_billing_country country
    wait_and_select_option laybuy_payment_country_element, country
  end

  def enter_laybuy_billing_address1 bill_add1
    wait_and_set_text laybuy_billing_address1_element, bill_add1
  end

  def enter_laybuy_billing_city bill_city
    wait_and_set_text laybuy_billing_city_element, bill_city
  end

  def enter_laybuy_billing_postcode bill_pc
    wait_and_set_text laybuy_billing_postcode_element, bill_pc
  end

  def select_laybuy_billing_state cc_state
    wait_and_select_option laybuy_state_abb_element, cc_state
  end

  def enter_laybuy_phone phone
    wait_and_set_text laybuy_payment_phone_element, phone
  end

  def uncheck_add_to_addressbook_laybuy
    wait_and_click(laybuy_chkbx_save_billing_element)
  end

  def click_full_form_laybuy
    wait_for_ajax
    if full_form_laybuy_element.present?
      wait_and_click full_form_laybuy_element
    end
  end

  def laybuy_place_order
    wait_and_click laybuy_cont_to_payment_btn_element
  end

  def get_laybuy_inst_amt
    @laybuy_inst_amt = wait_and_get_text(laybuy_inst_amt_element)
    $laybuy_instal_amt = @laybuy_inst_amt.gsub(/[^.0-9\-]/,"")
  end

  def laybuy_tab_presence
    wait_and_check_element_present?(laybuy_tab_element)
  end

  def global_err_msg_text
    wait_and_get_text(err_msg_checkout_element)
  end

  def zip_tab_presence
    wait_and_check_element_present?(zip_tab_element)
  end

  def click_latpay_tab
    wait_and_click latpay_tab_element
  end

  def same_add_latpay_billing_checked?
    wait_for_ajax
      if latpay_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
        return true
      else
        return false
      end
  end

  def same_add_latpay_billing_uncheck
    if latpay_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      wait_and_click(latpay_use_same_billadd_element)
    end
  end

  def saved_latpay_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_latpay_billing_add_container_element
  end

  def enter_latpay_billing_fname fname
    wait_and_set_text fname_latpay_payment_element, fname
  end

  def enter_latpay_billing_lname lname
    wait_and_set_text lname_latpay_payment_element, lname
  end

  def set_latpay_billing_country country
    wait_and_select_option latpay_payment_country_element, country
  end

  def enter_latpay_billing_address1 bill_add1
    wait_and_set_text latpay_billing_address1_element, bill_add1
  end

  def enter_latpay_billing_city bill_city
    wait_and_set_text latpay_billing_city_element, bill_city
  end

  def enter_latpay_billing_postcode bill_pc
    wait_and_set_text latpay_billing_postcode_element, bill_pc
  end

  def select_latpay_billing_state cc_state
    wait_and_select_option latpay_state_abb_element, cc_state
  end

  def enter_latpay_phone phone
    wait_and_set_text latpay_payment_phone_element, phone
  end

  def uncheck_add_to_addressbook_latpay
    wait_and_click(latpay_chkbx_save_billing_element)
  end

  def click_full_form_latpay
    wait_for_ajax
    if full_form_latpay_element.present?
      wait_and_click full_form_latpay_element
    end
  end

  def latpay_place_order
    sleep 2
    wait_and_click latpay_cont_to_payment_btn_element
  end

  def get_latpay_inst_amt
    @latpay_inst_amt = wait_and_get_text(latpay_inst_amt_element)
    $latpay_instal_amt = @latpay_inst_amt.gsub(/[^.0-9\-]/,"")
  end

  def latpay_tab_presence
    wait_and_check_element_present?(latpay_tab_element)
  end


  def click_humm_tab
    wait_and_click(humm_tab_element)
    sleep 2
  end

  def humm_place_order
    wait_and_click humm_cont_to_payment_btn_element
  end

  def humm_nz_place_order
    wait_and_click humm_nz_cont_to_payment_btn_element
  end

  def humm_login username, password
    Watir::Wait.while(timeout:30) {humm_logo_sign_in_page_element.present?}
    Watir::Wait.until {humm_email_element}.wait_until_present.click
    Watir::Wait.until {humm_email_element}.set username
    Watir::Wait.until {humm_password_element}.wait_until_present.click
    Watir::Wait.until {humm_password_element}.set password
    Watir::Wait.until {humm_sign_in_element}.wait_until_present.click
  end

  def humm_click_back_to_CO
    # wait_and_click humm_return_to_merchant_link_element
    # browser.alert.ok
    # sleep 2
    @browser.execute_script('window.history.back();')
    @url = browser.url
    if(@url =~ /bagpage=true/)
      return true
    else
      @browser.execute_script('window.history.back();')
    end
  end

  def same_add_humm_billing_checked?
    wait_for_ajax
    if humm_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      return true
    else
      return false
    end
  end

  def same_add_humm_billing_uncheck
    if humm_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      wait_and_click(humm_use_same_billadd_element)
    end
  end

  def enter_humm_billing_fname fname
    wait_and_set_text fname_humm_payment_element, fname
  end

  def enter_humm_billing_lname lname
    wait_and_set_text lname_humm_payment_element, lname
  end

  def set_humm_billing_country country
    wait_and_select_option humm_payment_country_element, country
  end

  def enter_humm_billing_address1 bill_add1
    wait_and_set_text humm_billing_address1_element, bill_add1
  end

  def enter_humm_billing_city bill_city
    wait_and_set_text humm_billing_city_element, bill_city
  end

  def enter_humm_billing_postcode bill_pc
    wait_and_set_text humm_billing_postcode_element, bill_pc
  end

  def select_humm_billing_state cc_state
    wait_and_select_option humm_state_abb_element, cc_state
  end

  def enter_humm_phone phone
    wait_and_set_text humm_payment_phone_element, phone
  end

  def uncheck_add_to_addressbook_humm
    wait_and_click(humm_chkbx_save_billing_element)
  end

  def click_full_form_humm
    wait_for_ajax
    if full_form_humm_element.present?
      wait_and_click full_form_humm_element
    end
  end

  def humm_tab_presence
    wait_and_check_element_present?(humm_tab_element)
  end

  def click_genoapay_tab
    sleep 2
    wait_and_click genoapay_tab_element
  end

  def genoapay_place_order
    sleep 2
    wait_and_click(genoapay_cont_to_payment_btn_element)
  end

  def click_quadpay_tab
    wait_and_click quadpay_tab_element
  end

  def get_quadpay_inst_amt
    @quadpay_instl_amt = wait_and_get_text(quadpay_CO_instl_amt_element)
    $quadpay_instl_amt = @quadpay_instl_amt.gsub(/[^.0-9\-]/,"")
  end

  def quadpay_place_order
    sleep 2
    wait_and_click quadpay_cont_to_payment_btn_element
  end

  def enter_quadpay_billing_fname fname
    wait_and_set_text fname_quadpay_payment_element, fname
  end

  def enter_quadpay_billing_lname lname
    wait_and_set_text lname_quadpay_payment_element, lname
  end

  def set_quadpay_billing_country country
    wait_and_select_option quadpay_payment_country_element, country
  end

  def enter_quadpay_billing_address1 bill_add1
    wait_and_set_text quadpay_billing_address1_element, bill_add1
  end

  def enter_quadpay_billing_city bill_city
    wait_and_set_text quadpay_billing_city_element, bill_city
  end

  def enter_quadpay_billing_postcode bill_pc
    wait_and_set_text quadpay_billing_postcode_element, bill_pc
  end

  def select_quadpay_billing_state cc_state
    wait_and_select_option quadpay_state_abb_element, cc_state
  end

  def enter_quadpay_phone phone
    wait_and_set_text quadpay_payment_phone_element, phone
  end

  def uncheck_add_to_addressbook_quadpay
    wait_and_click(chkbx_quadpay_billing_element)
  end

  def click_full_form_quadpay
    wait_for_ajax
    if full_form_quadpay_element.present?
      wait_and_click full_form_quadpay_element
    end
  end

  def saved_quadpay_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_quadpay_billing_add_container_element
  end

  def same_add_quadpay_billing_checked?
    wait_for_ajax
    if check_same_add_quadpay_bill_element.attribute_value('class') =~ /hide/
      return true
    else
      return false
    end
  end

  def same_add_quadpay_billing_uncheck
    # if quadpay_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
    wait_and_click(quadpay_use_same_billadd_element)
    # end
  end

  def click_payflex_tab
    wait_and_click payflex_tab_element
  end

  def get_payflex_inst_amt
    @payflex_instl_amt = wait_and_get_text(playflex_CO_instl_amt_element)
    $payflex_instl_amt = @payflex_instl_amt.gsub(/[^.0-9\-]/,"")
  end

  def payflex_place_order
    sleep 2
    wait_and_click payflex_cont_to_payment_btn_element
  end

  def same_add_payflex_billing_checked?
    wait_for_ajax
    if check_same_add_payflex_bill_element.attribute_value('class') =~ /hide/
      return true
    else
      return false
    end
  end

  def same_add_payflex_billing_uncheck
    if payflex_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      wait_and_click(payflex_use_same_billadd_element)
    end
    # @browser.execute_script("document.querySelectorAll('[for='zip_checkout_deliveryAndPayment_delivery_useAsBillingAddress']')[0].click();")
  end

  def saved_payflex_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_payflex_billing_add_container_element
  end

  def enter_payflex_billing_fname fname
    wait_and_set_text fname_payflex_payment_element, fname
  end

  def enter_payflex_billing_lname lname
    wait_and_set_text lname_payflex_payment_element, lname
  end

  def set_payflex_billing_country country
    wait_and_select_option payflex_payment_country_element, country
  end

  def enter_payflex_billing_address1 bill_add1
    wait_and_set_text payflex_billing_address1_element, bill_add1
  end

  def enter_payflex_billing_city bill_city
    wait_and_set_text payflex_billing_city_element, bill_city
  end

  def select_payflex_billing_state cc_state
    wait_and_select_option payflex_state_abb_element, cc_state
  end

  def enter_payflex_billing_postcode bill_pc
    wait_and_set_text payflex_billing_postcode_element, bill_pc
  end

  def uncheck_add_to_addressbook_payflex
    wait_and_click(chkbx_payflex_billing_element)
  end

  def enter_payflex_phone phone
    wait_and_set_text payflex_payment_phone_element, phone
  end

  def enter_DOB_under_age
    dob_day_element[2].click
    dob_month_element[8].click
    dob_year_element[12].click
  end

  def DOB_error_message
    wait_and_get_text(under_age_error_message_element)
  end

  def save_rrp_text_CO
    @multipack_save_text = wait_and_get_text(multipack_save_text_co_element)
    return @multipack_save_text.gsub(/[\n]/,"")
  end

  def discount_line_item_CO
    wait_and_get_text(order_discount_element).gsub(/[^.0-9\-]/,"").gsub(/[-]/,"")
  end

  def product_price_CO
    wait_and_get_text(co_product_price_element).gsub(/[^.0-9\-]/," ")
  end

  def remove_promo_code promo_id
    remove_voucher_elements.find{|el| el.data_gift_id.to_s == promo_id.to_s}.click
    wait_for_ajax
  end

  def applied_promos index
    # wait_for_ajax
    Watir::Wait.until {applied_promo_voucher_list_elements[index].div(:class => "small-6")}.when_present
    return applied_promo_voucher_list_elements[index].div(:class => "small-6").span.text
  end

  def delivery_type
    wait_for_ajax
    return active_delivery_method_element.text.gsub(/[\n]/,"")
  end

  def click_bonus_gift_msg
    perks_error_message_co_element.click
  end

  def click_klarna_tab
    wait_and_click(klarna_tab_element)
  end

  def klarna_installment_amount
    wait_and_get_text(klarna_instll_amt_element)
  end

  def klarna_installment_amount_GB
    wait_and_get_text(klarna_instll_amt_GB_element)
  end

  def klarna_place_order arg
    case arg
    when "US"
      sleep 2
      wait_and_click klarna_cont_to_payment_btn_us_element
    when "AU"
      sleep 2
      wait_and_click klarna_cont_to_payment_btn_au_element
    when "GB"
      sleep 2
      wait_and_click klarna_cont_to_payment_btn_gb_element
    end
  end

  def same_add_klarna_billing_checked?
    wait_for_ajax
    if check_same_add_klarna_bill_element.attribute_value('class') =~ /hide/
      return true
    else
      return false
    end
  end

  def same_add_klarna_billing_uncheck
    if klarna_use_same_billadd_element.attribute_value('aria-checked') =~ /true/
      wait_and_click(klarna_use_same_billadd_element)
    end
    # @browser.execute_script("document.querySelectorAll('[for='zip_checkout_deliveryAndPayment_delivery_useAsBillingAddress']')[0].click();")
  end

  def saved_klarna_billing_address_container_present?
    wait_for_ajax
    return wait_and_check_element_present? saved_klarna_billing_add_container_element
  end

  def enter_klarna_billing_fname fname
    wait_and_set_text fname_klarna_payment_element, fname
  end

  def enter_klarna_billing_lname lname
    wait_and_set_text lname_klarna_payment_element, lname
  end

  def set_klarna_billing_country country
    wait_and_select_option klarna_payment_country_element, country
  end

  def enter_klarna_billing_address1 bill_add1
    wait_and_set_text klarna_billing_address1_element, bill_add1
  end

  def enter_klarna_billing_city bill_city
    wait_and_set_text klarna_billing_city_element, bill_city
  end

  def select_klarna_billing_state cc_state
    wait_and_select_option klarna_state_abb_element, cc_state
  end

  def enter_klarna_billing_postcode bill_pc
    wait_and_set_text klarna_billing_postcode_element, bill_pc
  end

  def uncheck_add_to_addressbook_klarna
    wait_and_click(chkbx_klarna_billing_element)
  end

  def enter_klarna_phone phone
    wait_and_set_text klarna_payment_phone_element, phone
  end

  def click_full_form_klarna
    wait_for_ajax
    if full_form_klarna_element.present?
      wait_and_click full_form_klarna_element
    end
  end

  def klarna_tab_not_present
    return klarna_tab_element.present?
  end

  def email_delivery_text
    return wait_and_get_text(email_delivery_element)
  end

  def click_edit_CO_pg
    wait_and_click(edit_button_co_pg_element)
  end

  def enter_spc_adyen_valid_cc_details cc_no, cc_date, cc_cvn, cc_name
    sleep 5
    in_iframe(:css => '.adyen-checkout__card__cardNumber__input [title="Iframe for secured card data input field"]') do |f|
      text_field_element(:id => 'encryptedCardNumber', :frame => f).set(cc_no)
    end
    in_iframe(:css => '.adyen-checkout__card__exp-date__input [title="Iframe for secured card data input field"]') do |f|
      text_field_element(:id => 'encryptedExpiryDate', :frame => f).set(cc_date)
    end
    in_iframe(:css => '.adyen-checkout__card__cvc__input [title="Iframe for secured card data input field"]') do |f|
      text_field_element(:id => 'encryptedSecurityCode', :frame => f).set(cc_cvn)
    end
    if (text_field_element(:id => 'adyen-checkout__card__holderName').present?).to_s == "true"
      text_field_element(:id => 'adyen-checkout__card__holderName').set(cc_name)
      sleep 5
    end
  end

  def enter_3DS_password arg
    in_iframe(:name => 'threeDSIframe') do |f|
      text_field_element(:name => 'answer', :index => 0, :frame => f).set(arg)
    end
  end

  def click_submit_3DS_page
    in_iframe(:name => 'threeDSIframe') do |f|
      button_element(:class => 'button--primary',:index => 0, :frame => f).click
    end
  end

  def hit_browser_back_btn
    @browser.back
  end

  def select_saved_credit_card arg
    @index_new = saved_credit_card_elements.find_index{|el| el.text.to_s =~ /#{arg}/}
    wait_and_click(saved_credit_card_elements.find {|el| el.text.to_s =~ /#{arg}/})
  end

  def enter_saved_card_cvc cvc
    wait_for_ajax
    in_iframe(:css => 'iframe.js-iframe', :index => (@index_new.to_i)) do |f|
      text_field_element(:id => 'encryptedSecurityCode', :frame => f).set(cvc)
    end
  end

  def select_delivery_address int
    if !(expanded_saved_delivery_address_dropdown_element.present?)
      wait_and_click saved_address_dropdown_element
    end
    wait_and_click saved_delivery_addresses_elements[(int.to_i) -1]
    wait_for_ajax
  end

  def add_new_address
    if !(expanded_saved_delivery_address_dropdown_element.present?)
      wait_and_click saved_address_dropdown_element
    end
    wait_and_click new_add_element
  end

  def add_new_card
    wait_and_click new_card_element
  end

  def enter_spc_adyen_valid_new_cc_details cc_no, cc_date, cc_cvn, cc_name
    sleep 5
    in_iframe(:css => '.adyen-checkout__card__cardNumber__input [title="Iframe for secured card data input field"]') do |f|
      text_field_element(:id => 'encryptedCardNumber', :frame => f).set(cc_no)
    end
    in_iframe(:css => '.adyen-checkout__card__exp-date__input [title="Iframe for secured card data input field"]') do |f|
      text_field_element(:id => 'encryptedExpiryDate', :frame => f).set(cc_date)
    end
    indexes = ((iframes_saved_cards_elements.length)-1)
    in_iframe(:css => '.adyen-checkout__card__cvc__input [title="Iframe for secured card data input field"]', :index => (indexes.to_i)) do |f|
      text_field_element(:id => 'encryptedSecurityCode', :frame => f).set(cc_cvn)
    end
    if (text_field_element(:id => 'adyen-checkout__card__holderName').present?).to_s == "true"
      text_field_element(:id => 'adyen-checkout__card__holderName').set(cc_name)
      sleep 5
    end
  end

  def click_delete_card
    wait_and_click delete_credit_card_element
    wait_for_ajax
    wait_and_click confirm_delete_card_element
  end

  def select_save_card_chkbx
    begin
      retries ||= 0
      save_card_chbx_element.click
    rescue Watir::Exception::UnknownObjectException
      retry if remember_me_chkbx_element.attribute_value("value") != "true"
    end
  end

end



