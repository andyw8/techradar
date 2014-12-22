desc "Run haml-lint"
task :haml_lint do
  require "haml_lint"
  system("bundle exec haml-lint app/views") || abort("haml-lint failed")
end
