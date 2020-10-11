class HomePage

  def initialize(driver)
    @driver = driver
  end

  # UI Elements in the format of how and what as expected by Selenium
  ELEMENTS = {'chat_list_item' => [:xpath, "//*[contains(@class, 'celo-elipsis') and text() = \" __custom_name__ \"]"],
              'create_new_message_button' => [:xpath, "//*[contains(@class, 'text') and text() = \"Create new message\"]"],
              'text_message_field' => [:id, "celo-send-message-textarea"],
              'send_chat_button' => [:xpath, "//*[contains(@class, 'notranslate') and text() = \"send\"]"],
              'profile_dropdown_button' => [:xpath, "//*[contains(text(), \"keyboard_arrow_down\")]"],
              'logout_button' => [:xpath, "//*[contains(text(), \"Log out\")]"],
              'chat_message' => [:xpath, "//*[contains(text(), \"__custom_name__\")]"]}

  def select_chat_from_list(chat_name)
    wait_for_element('chat_list_item', chat_name)
    find_element('chat_list_item', chat_name).click
  end

  def type_chat_message(message)
    wait_for_element('text_message_field')
    find_element('text_message_field').send_keys message
  end

  def send_chat_message
    wait_for_element('send_chat_button')
    find_element('send_chat_button').click
  end

  def send_message_to_chat(chat_name, message)
    select_chat_from_list(chat_name)
    type_chat_message(message)
    send_chat_message
  end

  def open_profile_dropdown
    wait_for_element('profile_dropdown_button')
    find_element('profile_dropdown_button').click
  end

  def click_logout_button
    wait_for_element('logout_button')
    find_element('logout_button').click
  end

  def logout_from_application
    open_profile_dropdown
    click_logout_button
  end

  def wait_for_element(element, custom = nil)
    wait = Selenium::WebDriver::Wait.new(timeout: 60)
    if custom
      wait.until { find_element(element, custom) }
    else
      wait.until { find_element(element) }
    end
  end

  def find_element(element, custom = nil)
    if custom
      ele = ELEMENTS[element][1].gsub(/__custom_name__/, custom)
      @driver.find_element(ELEMENTS[element][0], ele)
    else
      @driver.find_element(ELEMENTS[element][0], ELEMENTS[element][1])
    end
  end
end