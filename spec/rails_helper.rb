require 'spec_helper'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter 'app/admin/'
  minimum_coverage 90
end
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
