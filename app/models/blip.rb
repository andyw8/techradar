class Blip < ActiveRecord::Base
  belongs_to :radar

  validates :name, presence: true
  validates :quadrant, presence: true
  validates :radar, presence: true
end
