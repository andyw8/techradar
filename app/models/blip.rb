class Blip < ActiveRecord::Base
  QUADRANTS = %w(techniques tools platforms languages_and_frameworks)
  CORNERS = {
    nw: "techniques",
    ne: "tools",
    sw: "platforms",
    se: "languages_and_frameworks"
  }
  RINGS = %w(adopt trial assess hold)

  belongs_to :radar
  belongs_to :topic

  validates :topic_id,
            presence: true,
            uniqueness: { scope: :radar_id, message: "already exists in this radar" }

  validates :radar, presence: true

  validates :quadrant,
            presence: true,
            inclusion:
              { in: QUADRANTS }

  validates :ring,
            presence: true,
            inclusion: { in: RINGS }

  def radars
    Radar
      .includes(:blips)
      .where(blips: { name: name })
  end

  delegate :name, to: :topic

  def radar_name
    radar.name
  end

  def radar_owner
    radar.owner
  end

  def to_param
    topic.slug
  end
end
