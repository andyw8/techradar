if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start "rails" do
    add_filter "/config/initializers/analytics_ruby.rb"
    add_filter "/config/initializers/intercom.rb"
    add_filter "/config/initializers/rails_admin.rb"
  end
end

require "wisper/rspec/matchers"

RSpec.configure do |config|
  config.include Wisper::RSpec::BroadcastMatcher

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
