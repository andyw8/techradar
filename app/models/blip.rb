class Blip < ActiveRecord::Base
  belongs_to :radar

  validates :radar, presence: true
  validates :name, presence: true
end
