require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
ActiveRecord::Migration.maintain_test_schema!
require 'rubocop-rspec'
require 'rspec/rails'
require 'capybara/rspec'
require 'selenium-webdriver'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

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
