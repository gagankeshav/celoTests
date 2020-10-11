class SetupPinPage

  def initialize(driver)
    @driver = driver
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'pin_field' => [:id, 'pin_code'],
              'pin_confirm_field' => [:id, "pin_code_confirm"],
              'next_button' => [:xpath, "//*[contains(@class, 'mat-button-wrapper') and text() = \" NEXT \"]"]}

  def enter_pin(pin)
    wait_for_element('pin_field')
    find_element('pin_field').send_keys pin
  end

  def confirm_pin(pin)
    wait_for_element('pin_confirm_field')
    find_element('pin_confirm_field').send_keys pin
  end

  def click_next_button
    wait_for_element('next_button')
    find_element('next_button').click
  end

  def setup_user_pin(pin)
    enter_pin(pin)
    confirm_pin(pin)
    click_next_button
  end

  def wait_for_element(element)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { find_element(element) }
  end

  def find_element(element)
    @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
  end
end