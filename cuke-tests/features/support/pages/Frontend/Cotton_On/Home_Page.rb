require 'page-object'
require 'Watir'
require 'page-object/page_factory'
require 'fig_newton'
require_relative '../../../monkey_patch.rb'

class CottonOnHomepage
  include PageObject
  text_field(:footer_email, :id => 'dwfrm_subscribetab_footeremail')
  button(:join_button, :id => 'newsletter-entry-btn')
  button(:join_button_text, :id => 'newsletter-entry-btn > span')
  div(:subscribe_popup, :id => 'subscribe-tab')
  element(:homepage, :css => ".homepage")
  label_button(:user_initials, :class => 'user-account-initials')
  # link(:sign_out, :title => /Sign Out/)
  link(:sign_out, :css => "[title='Go to: Sign Out']", :index => 0)
  link(:points_balance, :title => /Go to: My Perks/)
  element(:subsite_id, :css => "body", :index => 0)
  elements(:brand_tile, :class => /swiper-slide header/)
  # links(:brand_tile, :css => ".swiper-slide.header-brand-logo a")

  # page_url "https://development.cottonon.com/<%=params[:site_country]%>/<%=params[:sku_id]%>.html"
  page_url "#{FigNewton.base_url}/<%=params[:site_country]%>/<%=params[:sku_id]%>.html"
  def visit_site site_country

        case site_country
          when "NZ"
            @browser.goto "#{FigNewton.nz_url}"
          else
            p "Cannot go to the country page"
        end

  end

  def check_email_field is_visible
    return footer_email_element.present? && is_visible != 'hidden'
  end

  def is_join_button_visible
      return join_button_element.present?
  end

  def subscribe_popup
    wait_for_spinner
    Watir::Wait.until(timeout: 30) {@browser.execute_script('return jQuery.active == 0')}
    Watir::Wait.until {subscribe_popup_element}.when_present.click
  end

  def join_perks_from_home_page
    join_button
  end

  def landing_on_homepage
    wait_for_ajax
    homepage_element.present?
  end

  def sign_out
    sign_out_element.click
  end

  def get_subsite_name
    subsite_id_element.classes[0]
  end

  def get_brand_name
    subsite_id_element.classes[1]
  end

  def select_brand_tile brand
    brand_tile_elements.select{|el| el.attribute_value("class") =~ /#{brand}/}.last.click
  end

end

