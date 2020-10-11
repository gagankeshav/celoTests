class LoginPage

  def initialize(driver)
    @driver = driver
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'email_field' => [:id, 'Username'],
              'password_field' => [:id, "Password"],
              'login_button' => [:xpath, "//*[contains(@class, 'btn-primary') and text() = \"LOG IN\"]"]}

  def enter_email(email)
    wait_for_element('email_field')
    find_element('email_field').send_keys email
  end

  def enter_password(password)
    wait_for_element('password_field')
    find_element('password_field').send_keys password
  end

  def click_login_button
    wait_for_element('login_button')
    find_element('login_button').click
  end

  def login_to_application(email, password)
    enter_email(email)
    enter_password(password)
    click_login_button
  end

  def wait_for_element(element)
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { find_element(element) }
  end

  def find_element(element)
    @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
  end
end