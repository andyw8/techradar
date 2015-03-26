if defined? HamlLint
  require 'haml_lint/rake_task'

  HamlLint::RakeTask.new
end
