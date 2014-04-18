class Radar < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  validates :name, presence: true
  validates :owner, presence: true
end
