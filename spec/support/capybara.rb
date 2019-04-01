Capybara.ignore_hidden_elements = false
Capybara.save_path = Rails.root.join('tmp')
Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu window-size=1366,768] }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome,
                                      desired_capabilities: capabilities)
end
Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome
Capybara.register_driver(:headless_chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end
