module Utilities

  def wait_and_click element
    begin
      retries ||= 0
      Watir::Wait.until {element}.focus
      Watir::Wait.until {element}.click
    rescue Selenium::WebDriver::Error,Selenium::WebDriver::Error::UnknownError,Selenium::WebDriver::Error::ElementNotVisibleError,Selenium::WebDriver::Error::ElementNotInteractableError,Selenium::WebDriver::Error::ElementClickInterceptedError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Element is not clickable even after #{retries} retries - #{e}"
      end
    end
  end

  def wait_and_click_payment element
    begin
      retries ||= 0
      element.focus
      element.wait_while(&:obscured?).click
    rescue Selenium::WebDriver::Error,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Payment element is not clickable even after #{retries} retries - #{e}"
      end
    end
  end

  def wait_and_get_text element
    begin
      retries ||= 0
      return Watir::Wait.until {element}.attribute_value("innerText")
    rescue Selenium::WebDriver::Error::UnhandledAlertError,Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot read text from the element even after #{retries} retries  - #{e}"
      end
    end
  end

  def wait_and_get_htmltext element
    begin
      retries ||= 0
      return Watir::Wait.until {element}.attribute_value("innerHTML")
    rescue Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot read html text from the element even after #{retries} retries  - #{e}"
      end
    end
  end

  def wait_and_set_text element, value
    begin
      retries ||= 0
      Watir::Wait.until {element}.set value
    rescue Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException,Selenium::WebDriver::Error::ElementNotVisibleError => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot set text to the element even after #{retries} retries  - #{e}"
      end
    end
  end

  def wait_and_select_option element, option
    begin
      retries ||= 0
      Watir::Wait.until {element}.select option
    rescue Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot select option #{option} even after #{retries} retries  - #{e}"
      end
    end
  end

  def wait_and_check_element_present? element
    begin
      retries ||= 0
      Watir::Wait.until {element}.present?
    rescue Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot check presence of the element even after #{retries} retries  - #{e}"
      end
    end
  end


  def wait_is_checkbox_checked? element
    begin
      retries ||= 0
      return element.checked?
    rescue Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot verify the checkbox is checked even after #{retries} retries - #{e}"
      end
    end
  end

  def wait_and_check_element_focus element
    begin
      retries ||= 0
      Watir::Wait.until {element}.focus
    rescue Selenium::WebDriver::Error::UnknownError,Watir::Exception::UnknownObjectException => e
      if (retries += 1) < $code_retry
        retry
      else
        raise "Cannot focus the element even after #{retries} retries + #{e}"
      end
    end
  end

#####################Backup###################
  # def wait_and_click element
  #   begin
  #     retries ||= 0
  #     Watir::Wait.until {element}.focus
  #     Watir::Wait.until {element}.click
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  # def wait_and_get_text element
  #   begin
  #     retries ||= 0
  #     return Watir::Wait.until {element}.attribute_value("innerText")
  #   rescue Selenium::WebDriver::Error::UnhandledAlertError
  #     retry if (retries += 1) < $code_retry
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  # def wait_and_get_htmltext element
  #   begin
  #     retries ||= 0
  #     return Watir::Wait.until {element}.attribute_value("innerHTML")
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  # def wait_and_set_text element, value
  #   puts "Element is #{element.to_s}"
  #   begin
  #     retries ||= 0
  #     Watir::Wait.until {element}.set value
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  # def wait_and_select_option element, option
  #   begin
  #     retries ||= 0
  #     Watir::Wait.until {element}.select option
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  # def wait_and_check_element_present? element
  #   begin
  #     retries ||= 0
  #     Watir::Wait.until {element}.present?
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  #
  # def wait_is_checkbox_checked? element
  #   begin
  #     retries ||= 0
  #     return element.checked?
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end
  #
  # def wait_and_check_element_focus element
  #   begin
  #     retries ||= 0
  #     Watir::Wait.until {element}.focus
  #   rescue Selenium::WebDriver::Error::UnknownError
  #     retry if (retries += 1) < $code_retry
  #   rescue Watir::Exception::UnknownObjectException
  #     retry if (retries += 1) < $code_retry
  #   end
  # end

end