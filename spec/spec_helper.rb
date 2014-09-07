require "wisper/rspec/matchers"

RSpec.configure do |config|
  config.include Wisper::Rspec::BroadcastMatcher

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
