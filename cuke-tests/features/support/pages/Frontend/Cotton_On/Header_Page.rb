require 'page-object'
require 'page-object/page_factory'

class HeaderPage 
  include PageObject
		element(:cottonon_brand_logo, :class => 'header-cottonon-logo')
		element(:body_brand_logo, :class => 'header-body-logo')
		element(:kids_brand_logo, :class => 'header-kids-logo')
		element(:typo_brand_logo, :class => 'header-typo-logo')
		element(:rubi_brand_logo, :class => 'header-rubi-logo')
    list_item(:store_link, :class => 'stores nav-item')

	def click_brand_link arg
		case arg
			when "cottonon"
				cottonon_brand_logo_element.click
			when "body"
				body_brand_logo_element.click
			when "kids"
				kids_brand_logo_element.click
			when "typo"
				typo_brand_logo_element.click
			when "rubi"
				rubi_brand_logo_element.click		
			else
				p "Cannot click the brand links"	
		end	
	end	

	def assert_brand_page arg
		check_arg = arg.gsub(" ","").downcase
		raise 'Brand "#{arg}" URL is not correct' if not (@browser.url.include? check_arg)
		case arg
			when "Cotton On"
				raise 'Brand "#{arg}" is not highlighted' if not (cottonon_brand_logo_element.class_name.include? 'active')
			when "Body"
				raise 'Brand "#{arg}" is not highlighted' if not (body_brand_logo_element.class_name.include? 'active')
			when "Kids"
				raise 'Brand "#{arg}" is not highlighted' if not (kids_brand_logo_element.class_name.include? 'active')
			when "Typo"
				raise 'Brand "#{arg}" is not highlighted' if not (typo_brand_logo_element.class_name.include? 'active')
			when "Rubi"
				raise 'Brand "#{arg}" is not highlighted' if not (rubi_brand_logo_element.class_name.include? 'active')
			else
				p "Cannot validate the brand pages"
		end
		
	end

	def click_store_locator
    Watir::Wait.until {store_link_element}.when_present.click
	end

end