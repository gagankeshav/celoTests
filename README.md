# celo-ui-tests
Repo for Automation of UI Tests for Celo Health Staging Website

# Pre-requisites:
1. Ruby should be installed on the system.
2. Chromedriver should be downloaded on the system and placed in one of the directories in the PATH variable [Follow steps outlined here: https://medium.com/@amdcaruso/selenium-webdriver-chromedriver-ruby-on-windows-1688132cbe3]
3. Following gems should be installed on the system:
    - selenium-webdriver
    - faker
    - rspec
    - yaml

To install the gems outlined above, use following command for each gem installation:
- gem install <gem name> e.g. gem install selenium-webdriver

# Executing the tests
Navigate to the tests folder and execute below command to execute the tests:
- rspec celo_tests.rb --format documentation