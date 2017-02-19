# This is intended to ease the transition to Rails 5

if Rails::VERSION::MAJOR > 4
  raise "Remove this file"
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
