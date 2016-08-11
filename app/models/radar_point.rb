class RadarPoint
  def initialize(ring:, title:, id:)
    @id = id
    @ring = ring
    @title = title
  end

  attr_reader :id, :ring, :title
end
