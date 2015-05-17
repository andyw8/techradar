# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path("../config/application", __FILE__)

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require "quality/rake/task"
  Quality::Rake::Task.new do |t|
    t.skip_tools = %w(cane flog flay reek)
    t.ruby_dirs = %w(app lib spec)
  end
end

desc "Run RSpec with code coverage"
task :spec_with_coverage do
  ENV["RAILS_ENV"] = "test"
  ENV["COVERAGE"] = "true"
  Rake::Task["spec"].clear
  Rake::Task["spec"].execute
end

task default: [:spec_with_coverage, :rubocop, :haml_lint]
