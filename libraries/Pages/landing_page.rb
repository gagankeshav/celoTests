class LandingPage

  def initialize(driver)
    @driver = driver
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'login_button' => [:id, 'login']}

  def click_login_button
    wait_for_element('login_button')
    find_element('login_button').click
  end

  def wait_for_element(element)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { find_element(element) }
  end

  def find_element(element, wait = nil)
    Selenium::WebDriver::Wait.new(timeout: 10).until { find_element(element) } if wait
    @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
  end
end