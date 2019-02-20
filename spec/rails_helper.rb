require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
ActiveRecord::Migration.maintain_test_schema!
require 'rubocop-rspec'
require 'rspec/rails'
require 'capybara/rspec'

# require 'support/factory_bot'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

# brew install geckodriver
# brew services start geckodriver
# Capybara.default_driver = :selenium

# brew install chromedriver
# brew services start chromedriver
# Capybara.default_driver = :selenium_chrome
# Capybara.default_driver = :selenium_chrome_headless

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.app_host = 'http://localhost:3001'
Capybara.server_host = 'localhost'
Capybara.server_port = '3001'
