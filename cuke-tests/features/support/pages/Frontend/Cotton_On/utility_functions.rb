require 'date'

class Utility_Functions
 
include PageObject

	div(:bg_spinner, :css => ".loader[style='display: fixed;']")

	def unique_email_id
			@time_stamp = Time.now.to_i;
			@time_stamp =@time_stamp.to_s
			@email = @time_stamp + "@test.com.au"
			return @email
	end


	def page_wait
		Watir::Wait.until(timeout: 30) {@browser.execute_script("return jQuery.active") == 0}
	end


	def wait_for_jquery(timeout = 30, message = nil)
		end_time = ::Time.now + timeout
		until ::Time.now > end_time
			begin
				return if @browser.execute_script('return jQuery ? 1 : 0;') == 1
				puts 'jQuery not yet loaded, waiting half a second...'
			rescue Selenium::WebDriver::Error::UnknownError => jquery_error
				puts "jQuery not yet loaded, or failed when checking if it loaded: #{jquery_error}\nWaiting half a second..."
			end
				sleep 0.5
		end
		message = 'Timed out waiting for jquery to load' unless message
		raise message
	end

	def return_browser_url
		# wait_for_ajax
		sleep 2
		return (@browser.url)
	end

	def wait_for_spinner(timeout = 30, message = nil)
		end_time = ::Time.now + timeout
		until ::Time.now > end_time
			begin
				return Watir::Wait.until{bg_spinner_element}.wait_while_present
			rescue Selenium::WebDriver::Error::UnknownError => preloader_error
				puts "Spinner not yet detected, or failed when checking if it has disappeared:#{preloader_error}\n Waiting a second..."
			end
				sleep 1
		end
		message = 'Timed out waiting for spinner to load or disappear' unless message
		raise message
  end

  def future_date(years=0, months =0, days =0)
    return DateTime.now.next_year(years).next_month(months).next_day(days).to_time.strftime("%d/%m/%Y")
  end

  def past_date(years=0, months =0, days =0)
    return DateTime.now.prev_year(years).prev_month(months).prev_day(days).to_time.strftime("%d/%m/%Y")
  end
end