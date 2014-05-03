class RadarDecorator < Draper::Decorator
  delegate_all

  def entries(quadrant, ring)
    object.blips.where(quadrant: quadrant, ring: ring).to_a
  end
end
