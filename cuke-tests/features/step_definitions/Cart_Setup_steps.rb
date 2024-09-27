Given(/^I log on to the site with the following:$/) do |table|
  @counter = 1
  table.hashes.each do |row|
    @site = row['site']
    @country = row['country']
    @user = row['user']
    @user_state = row['user_state']
    @person = Personas.get_persona @user
    @type_of_user = row['type_of_user']
    @landing_page = row['landing_page']
    @url_comp = "#{@country.downcase}" + "_url"
    @site_information = Siteinfo.get_siteinfo "#{@site+@country}"
    @cartpage = row['cart_page']
    begin
      on(GeoPage) do |page|
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "#{@landing_page}"+ "/")
        @popup_box_present = (page.check_geo_popup_box_present?)
        if (@country != 'AU' && @popup_box_present)
          while @counter < 2
            @counter = @counter + 2
            page.click_stay_current_site
          end
        end
      end
    end
  end
  if @user_state == 'logged_in'
    on(SignInPage) do |page|
      sleep 5
      page.enter_email @person['email_info']['email_address']
      page.click_sign_me_in
      page.enter_pass @person['email_info']['password']
      page.click_sign_me_in
    end
  end
  if @cartpage == 'empty'
    on(PdpPage) do |page|
      page.click_view_cart
      on(MybagPage) do |page|
        if(page.empty_cart_page_presence) == "false"
          page.click_checkout
          on(CheckoutPage) do |page|
            if(page.dismiss_error_overlay_presence) == "true"
              page.dismiss_overlay_pop_up_message
            end
            page.remove_already_applied_gift_cards
            page.click_back_button_bag_page
          end
          on(MybagPage) do |page|
            page.delete_line_items
          end
        end
      end
    end
  end
  if @landing_page == 'sign-in' && @user_state == 'logged_in'
    on(MybagPage) do |page|
      page.go_to_my_account_page
    end
  end
 end


#to_do : Two step definitions and code is there for this functionality
# The other one is as 'And a bag with products:' present under Checkout_page_steps.rb file
When(/^I add the following products to cart$/) do |table|
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty'].to_i
    begin
      on(GeoPage) do |page|
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          if page.add_to_bag_enabled?
            page.click_add_to_bag
          end
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.close_ovelapped_success_message
        end
      end
    end
  end
end

When(/^I add the following personalised products:$/) do |table|
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    @qty = @qty.to_i
    @personalised_msg = row['personalised_message']
    begin
      on(GeoPage) do |page|
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
      end
      @loop = 0
      for i in 1..(@qty)
        on(PdpPage) do |page|
          if @personalised_msg != ""
            page.fill_personalised_text "#{@personalised_msg}"
          end
          if page.add_to_bag_enabled?
            page.click_add_to_bag
          end
          expect(page.overlapped_success_message).to include 'to bag'
          @loop = 1+@loop
          page.close_ovelapped_success_message
        end
      end
    end
  end
end

And(/^I add the following products to cart using quantity dropdown$/) do |table|
  @wait_for_page_to_load = Utility_Functions.new(@browser)
  table.hashes.each do |row|
    @sku = row['sku']
    @qty = row['qty']
    begin
      on(GeoPage) do |page|
        page.navigate_to("#{@site_information["#{@url_comp}"]}"+ "/" + "#{@sku}" + ".html")
      end
      on(PdpPage) do |page|
        if page.add_to_bag_enabled?
           page.select_qty @qty
           page.click_add_to_bag
        end
        expect(page.overlapped_success_message).to include 'to bag'
        page.close_ovelapped_success_message
      end
    end
  end
end