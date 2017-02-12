source "https://rubygems.org"

ruby RUBY_VERSION

gem "rails", "4.2.7.1"

gem "analytics-ruby", require: "segment"
gem "bh", "~> 1.2"
gem "bootstrap-sass"
gem "coffee-rails", "~> 4.1.0"
gem "devise", "~> 4.0.0"
gem "draper"
gem "font-awesome-sass"
gem "friendly_id"
gem "haml-rails"
gem "high_voltage"
gem "intercom-rails"
gem "jbuilder", "~> 2.0"
gem "jquery-rails", "~> 3.1.3"
gem "pg"
gem "rack-timeout" # https://devcenter.heroku.com/articles/rails-unicorn#rack-timeout
gem "rails_admin"
gem "rasem", "0.6.1" # https://github.com/aseldawy/rasem/issues/14
gem "responders"
gem "rollbar"
gem "rubocop", "0.46.0" # match Code Climate
gem "rubocop-rspec", "1.8.0" # match Code Climate
gem "sass-rails", "~> 5.0"
gem "select2-rails"
gem "sendgrid"
gem "simple_form"
gem "twitter"
gem "uglifier", ">= 2.7.2"
gem "unicorn"
gem "wisper"

group :development do
  gem "foreman"
  gem "letter_opener"
  gem "quiet_assets"
  gem "rails_layout"
  gem "rails_stdout_logging"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bundler-audit"
  gem "capybara-email", "~> 2.4"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "haml_lint", "~> 0.19.0"
  gem "launchy"
  gem "nokogiri"
  gem "pry"
  gem "pry-byebug"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "rspec-rails", "~> 3.4.2"
  gem "shoulda-matchers"
end

group :test do
  gem "capybara"
  gem "codeclimate-test-reporter", require: false
  gem "database_cleaner"
  gem "rspec-activemodel-mocks"
  gem "rspec_junit_formatter", git: "git@github.com:circleci/rspec_junit_formatter.git" # for CircleCI
  gem "simplecov", "~> 0.9"
end

group :production do
  gem "rails_12factor"
end
