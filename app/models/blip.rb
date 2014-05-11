class Blip < ActiveRecord::Base
  QUADRANTS = %w{techniques tools platforms languages_and_frameworks}
  RINGS = %w{adopt trial assess hold}

  belongs_to :radar

  validates :name,
            presence: true,
            uniqueness: { scope: :radar_id, message: 'already exists in this radar' }

  validates :quadrant,
            presence: true,
            inclusion:
              { in: QUADRANTS }

  validates :radar, presence: true

  validates :ring,
            presence: true,
            inclusion: { in: RINGS }

  def radars
    Radar
      .includes(:blips)
      .where(blips: { name: name })
      .order(name: :asc)
  end
end
