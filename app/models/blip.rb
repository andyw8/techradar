class Blip < ApplicationRecord
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
            inclusion: { in: RingList.new.values }

  delegate :name, to: :topic

  def to_param
    topic.slug
  end

  def ring_object
    RingList.new.for_value(ring)
  end
end
