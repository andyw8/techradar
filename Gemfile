source "https://rubygems.org"

ruby RUBY_VERSION

gem "active_model_serializers"
gem "analytics-ruby", require: "segment"
gem "bh"
gem "bootstrap-sass"
gem "devise"
gem "draper"
gem "font-awesome-sass"
gem "friendly_id"
gem "hamlit"
gem "high_voltage"
gem "intercom-rails"
gem "jbuilder"
gem "jquery-rails"
gem "oj" # recommended by Rollbar README
gem "pg"
gem "rails"
gem "rails_admin"
gem "rasem", "0.6.1" # https://github.com/aseldawy/rasem/issues/14
gem "rollbar"
gem "sass-rails"
gem "select2-rails"
gem "sidekiq"
gem "simple_form"
gem "twitter", require: false
gem "uglifier"
gem "unicorn"
gem "wisper"

group :development do
  gem "foreman"
  gem "letter_opener"
  gem "rails_layout"
  gem "rails_stdout_logging"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"
  gem "bullet"
  gem "bundler-audit"
  gem "capybara-email", require: false
  gem "coveralls", "0.8.21", require: false
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "haml_lint", require: false
  gem "launchy"
  gem "pry"
  gem "pry-byebug"
  gem "pry-rails"
  gem "reek", require: false
  gem "rspec-rails"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "shoulda-matchers"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara"
  gem "capybara-selenium"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "rails-controller-testing"
  gem "rspec-activemodel-mocks"
  gem "wisper-rspec"
end

group :production do
  gem "rack-timeout" # https://devcenter.heroku.com/articles/rails-unicorn#rack-timeout
  gem "sendgrid"
end
