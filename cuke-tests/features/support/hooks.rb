  require 'rubygems'
  require 'page-object'
  require 'watir'
  require 'page-object/page_factory'
  require 'log4r'
  require 'cucumber'
  require 'selenium-webdriver'
  require 'fig_newton'
  require 'watir-screenshot-stitch'
  require 'mini_magick'

  args = ['--allow-running-insecure-content', '--ignore-certificate-errors']
  browser = Watir::Browser.new :chrome, options: {args: args}
  # No of times executed = 8, Time taken 4 minutes(30,30,30,30,30,30,30,30)
  $code_retry = 8



  Before do |scenario|
          @browser ||= browser
          ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil
          DataMagic.load_for_scenario(scenario)
          @browser.goto("https://development-web-cottonongroup.demandware.net/s/cog-au/")
          @browser.window.maximize
          @browser.driver.manage.timeouts.implicit_wait = 0
          @browser.cookies.clear
          @browser.driver.manage.window.maximize
          PageObject.default_element_wait=(30)
          PageObject.javascript_framework = :jquery
          #Selenium::WebDriver.logger.level = :info
  end #before scenario

  # "after all"
  After do |scenario|
    @browser.execute_script("javascript:localStorage.clear();")
    @browser.cookies.clear
       if (scenario.passed?)
         puts 'Scenario Passed !'
       else
         puts 'Scenario Failed !'
         take_screenshot(scenario)
       end
  end

  AfterStep('@screen') do
     filename = DateTime.now.strftime("%d%b%Y%H%M%S")
     @browser.screenshot.save ("C:/Users/lohit.kotian/Documents/Automation/screenshots-cucumber/#{filename}.png")
     #@browser.screenshot.save ("C:/Jenkins/workspace/screenshots-cucumber/#{filename}.png")
  end

  Around('@multipletimes') do |scenario, block|
    $counter = 0
    $total_times_to_run = 6
    while $counter < $total_times_to_run  do
       block.call
       puts("Total times scripts were repeated = #$counter" )
       $counter +=1
    end
  end

  Around('@paypal') do |scenario,block|
    @browser = browser
    @browser.goto "https://www.sandbox.paypal.com"
    @browser.cookies.clear
    block.call
  end

  Around('@afterpay') do |scenario,block|
    @browser = browser
    @browser.goto "https://portal-sandbox.afterpay.com"
    @browser.cookies.clear
    block.call
  end

  Around('@zip') do |scenario,block|
    @browser = browser
    @browser.goto "account.sandbox.zipmoney.com.au"
    @browser.cookies.clear
    block.call
  end

  Around('@laybuy') do |scenario,block|
    @browser = browser
    @browser.goto "https://sandbox-payment.laybuy.com/pay#/"
    @browser.cookies.clear
    block.call
  end

  Around('@payflex') do |scenario,block|
    @browser = browser
    @browser.goto "https://checkout.uat.payflex.co.za/"
    @browser.cookies.clear
    block.call
  end

  Around('@ipay') do |scenario, block|
    @browser = browser
    @browser.goto "https://i-pay.co.za"
    @browser.cookies.clear
    block.call
  end

  Around('@klarna') do |scenario, block|
    @browser = browser
    @browser.goto "https://us.portal.klarna.com/"
    @browser.cookies.clear
    block.call
  end

  at_exit do
   browser.close
  end

  def take_screenshot(scenario)
    time = Time.now.strftime("%Y-%m-%d_%H%M")
    opts = {:page_height_limit => 5000}
    scenario_name = scenario.name.gsub(/[^\w\-]/, ' ')
    screenshot_path =  "#{scenario_name}" + "_failure_" + time
    @browser.screenshot.save_stitch("./screenshots/#{screenshot_path}.png", opts)
  end

