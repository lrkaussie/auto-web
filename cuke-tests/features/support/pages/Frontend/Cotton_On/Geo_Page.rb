require 'page-object'
require 'page-object/page_factory'
class GeoPage
  include PageObject
		
		link(:geo_popup_stay_link, :css => '#geodetection-stay-link')
		div(:geo_detect_dialog_box, :css => '#geodetection-dialog')
		div(:geo_det_dlg_box_text_msg, :class => 'geodetection-youreon-message')
		span(:big_au_flag_geo_det_box, :class => 'icon icon-flag-big-au')
		element(:go_to_oz_site_btn_text, :class => 'geodetection-redirect')
		element(:countries_list, :class => 'countries-list')
		div(:big_flag, :class => 'geodetection-flag')
		#index for countries start at 0
		@@number_of_countries = 5

  def check_user_location arg
    @@user_origin_country = @browser.driver.manage.cookie_named("userOriginCountry")
    raise 'User Origin Country cookie is not correctly configured or set' if not (@@user_origin_country[:value] == arg)
  end

  def check_geo_popup_box_present?
    @@dialog_box_present_check = geo_detect_dialog_box_element.present?
  end

	def return_geo_popup_box_element
    return geo_detect_dialog_box_element
	end

  def check_geo_popup_box_message arg
    @@geo_popup_msg_txt = geo_det_dlg_box_text_msg
    raise 'Cannot find the Geo popup message text' if not (@@geo_popup_msg_txt.include? arg)
  end


  def check_big_au_flag_present?
    raise 'Big AU flag is missing' if not (big_au_flag_geo_det_box_element.present?)
  end

  def check_big_flag_present? arg
    raise 'Cannot find the big flag on the geo detect box' if not (big_flag_element.inner_html.include? arg.downcase)
  end

  def go_to_oz_btn arg
    raise 'Cannot find the AU redirection button message text' if not (go_to_oz_site_btn_text.include? arg)
  end

  def stay_on_nz_link arg
    raise 'Cannot find the Stay on NZ site link' if not (geo_popup_stay_link_element.text.include? arg)
  end

  def small_flag_checks arg1, arg2, arg3, arg4, arg5, arg6

    full_list_of_countries = countries_list_element.text
    full_list_of_countries = full_list_of_countries.gsub(/\n/," ")
    for i in 0..@@number_of_countries
      country_list_text = countries_list_element.li(index: i).text
      raise 'Country text missing' if not (full_list_of_countries.include? country_list_text)
      country_url = countries_list_element.li(index: i).a.attribute_value("href")
      raise 'Country URL missing' if not (country_url.include? arg1) || (country_url.include? arg2) || (country_url.include? arg3) || (country_url.include? arg4) || (country_url.include? arg5) || (country_url.include? arg6)
    end
  end

  def click_stay_current_site
    Watir::Wait.until{geo_popup_stay_link_element}.when_present.click
  end

end

