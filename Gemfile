source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.2'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jquery-rails'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem 'country_select', '~> 4.0'
gem 'carrierwave-postgresql-table'
gem 'ffaker'
gem 'pagy'
gem 'aasm'
gem 'therubyracer'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'wicked'
gem 'pundit'

group :development, :test do
  gem 'byebug'
  gem 'capybara', '~> 2.13.0'

  gem 'capybara-selenium'
  gem 'chromedriver-helper'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false, group: :test
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'pundit-matchers', '~> 1.6.0', group: :test
end

group :development do
  gem 'fasterer'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
