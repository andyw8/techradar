if ENV["CI"]
  require "coveralls"
  Coveralls.wear!
end

require "wisper/rspec/matchers"

RSpec.configure do |config|
  config.include Wisper::RSpec::BroadcastMatcher

  config.order = :random
  Kernel.srand config.seed
  config.warnings = false

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
