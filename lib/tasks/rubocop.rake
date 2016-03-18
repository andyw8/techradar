if Rails.env.development? || Rails.env.test?
  require "rubocop/rake_task"

  desc "Run RuboCop config"
  RuboCop::RakeTask.new(:rubocop) do |task|
    # task.requires << 'rubocop-rspec'
    task.options = %w(--display-cop-names)
  end
end
