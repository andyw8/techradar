if ENV["COVERAGE"]
  require "simplecov"
end

ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "shoulda/matchers"

require "support/capybara"
require "support/database_cleaner"
require "support/devise"
require "support/rspec_hooks"
require "support/shoulda"
require "support/stub_current_user"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  include Warden::Test::Helpers
  Warden.test_mode!
end
