# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path("../config/application", __FILE__)

Rails.application.load_tasks

desc "Run RSpec with code coverage"
task :spec_with_coverage do
  ENV["RAILS_ENV"] = "test"
  ENV["COVERAGE"] = "true"
  Rake::Task["spec"].clear
  Rake::Task["spec"].execute
end

task default: %i[spec_with_coverage rubocop reek haml_lint]
