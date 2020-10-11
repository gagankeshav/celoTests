# Initial configuration
$LOAD_PATH.unshift File.expand_path('../../', __FILE__)
require 'helpers'

RSpec.describe "Celo UI Tests" do
  context "UI tests" do

    before(:all) do
      # Instantiating webdriver instance for chrome browser
      @driver = Selenium::WebDriver.for :chrome

      # Maximizing the browser window
      @driver.manage.window.maximize

      # Loading the configuration from config.yml file
      @config = YAML.load_file(File.expand_path('../../config/config.yml', __FILE__))

      # Opening the Celo staging website
      @driver.get(@config['celo_staging_webaddress'])

      # Instantiating the objects for Celo Application Page libraries
      @landing_page = LandingPage.new(@driver)
      @login_page = LoginPage.new(@driver)
      @pin_page = SetupPinPage.new(@driver)
      @home_page = HomePage.new(@driver)
    end

    it "Validate that user is able to login to the application" do
      @landing_page.click_login_button
      @login_page.login_to_application(@config['login_email'], @config['login_password'])
      @pin_page.wait_for_element('pin_field')
      aggregate_failures do
        expect(@pin_page.find_element('pin_field').displayed?).to eq(true)
        expect(@pin_page.find_element('pin_confirm_field').displayed?).to eq(true)
        expect(@driver.current_url).to eq('https://stagingapp.celohealth.com/pin?returnUrl=%2Fconversations')
      end
    end

    it "Validate that user is able to setup a pin" do
      @pin_page.setup_user_pin(Faker::Number.number(digits: 4))
      expect(@home_page.find_element('create_new_message_button').displayed?).to eq(true)
    end

    it "Validate that user is able to send messages in an existing conversation" do
      message = Faker::Lorem.sentence(word_count: 5)
      @home_page.send_message_to_chat('Admin QA', message)
      aggregate_failures do
        expect(@home_page.find_element('chat_message', message).displayed?).to eq(true)
        expect(@home_page.find_element('chat_message', message).text).to eq(message)
      end
    end

    it "Validate that user is able to log out of the application" do
      @home_page.logout_from_application
      expect(@landing_page.find_element('login_button', 'true').displayed?).to eq(true)
    end

    after(:all) do
      @driver.quit
    end
  end
end
