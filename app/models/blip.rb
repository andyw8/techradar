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

  scope :in_quadrant, ->(quadrant) { where(quadrant: quadrant.value) }
  scope :in_scope, lambda { |ring, quadrant|
    includes(:topic)
      .where(ring: ring, quadrant: quadrant)
      .order("topics.name")
  }

  def to_param
    topic.slug
  end

  def ring_object
    RingList.new.find { |record| record.value == ring }
  end
end
