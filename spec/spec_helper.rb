if ENV["COVERAGE"]
  require "simplecov"
end

require "wisper/rspec/matchers"

RSpec.configure do |config|
  config.include Wisper::RSpec::BroadcastMatcher

  config.order = :random
  config.warnings = false

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.fail_if_no_examples = true

  Kernel.srand config.seed
end
