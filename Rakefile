# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

require 'quality/rake/task'
Quality::Rake::Task.new do |t|
  t.skip_tools = %w(cane flog flay)
end

task default: [:spec, :quality]
