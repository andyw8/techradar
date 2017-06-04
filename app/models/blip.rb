class Blip < ApplicationRecord
  RINGS = %w[adopt trial assess hold]

  belongs_to :radar, touch: true
  belongs_to :topic

  validates :topic_id,
            presence: true,
            uniqueness: {
              scope: :radar_id, message: "already exists in this radar"
            }
  validates :radar, presence: true
  validates :quadrant,
            presence: true,
            inclusion: { in: QuadrantList.new.values }
  validates :ring,
            presence: true,
            inclusion: { in: RINGS }

  delegate :name, to: :topic

  def to_param
    topic.slug
  end
end
