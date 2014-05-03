class Blip < ActiveRecord::Base
  QUADRANTS = %w{techniques tools platforms languages_and_frameworks}
  belongs_to :radar

  validates :name, presence: true
  validates :quadrant, presence: true,
                       inclusion: { in: QUADRANTS }
  validates :radar, presence: true
end
