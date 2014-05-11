source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.0'

gem 'airbrake'
gem 'bootstrap-sass'
gem 'chosen-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'devise'
gem 'draper'
gem 'haml-rails'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sendgrid'
gem 'simple_form', github: "plataformatec/simple_form", branch: "master"
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :mri_21, :rbx]
  gem 'erb2haml'
  gem 'foreman'
  gem 'html2haml'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rescue', '~> 1.4.1'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: false
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  # simplecov is used by codeclimate-test-reporter but
  # circleci recommends avoiding 0.8 due to
  # https://github.com/colszowka/simplecov/issues/281
  gem 'simplecov', '~> 0.7.1'
end

group :production do
  gem 'rails_12factor'
end
