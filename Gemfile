source "https://rubygems.org"

ruby `cat .ruby-version`.strip

gem "rails", "4.2.6"

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
gem "rasem"
gem "responders"
gem "rollbar"
# gem "rubocop-rspec"
gem "rubocop"
gem "sass-rails", "~> 5.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc
gem "sendgrid"
gem "select2-rails"
gem "simple_form", github: "plataformatec/simple_form", branch: "master"
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
  gem "capybara-email", "~> 2.4"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "haml_lint", github: "brigade/haml-lint" # "https://github.com/brigade/haml-lint/issues/108"
  gem "launchy"
  gem "nokogiri", ">= 1.6.8"
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
  gem "rspec_junit_formatter", git: "git@github.com:circleci/rspec_junit_formatter.git" # for CircleCI
  gem "rspec-activemodel-mocks"
  gem "simplecov", "~> 0.9"
end

group :production do
  gem "rails_12factor"
end
