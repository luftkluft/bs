require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  # config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    # puts 'clean before suite'
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    # puts 'clean before each'
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
    # puts 'clean before each js'
  end

  config.before(:each) do
    DatabaseCleaner.start
    # puts 'clean before each start'
  end

  config.after(:each) do
    DatabaseCleaner.clean
    # puts 'clean after each'
  end
end
