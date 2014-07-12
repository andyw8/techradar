class RadarDecorator < Draper::Decorator
  delegate_all

  def entries(quadrant, ring)
    object.blips.where(quadrant: quadrant, ring: ring).includes(:topic).order('topics.name').to_a
  end

  def created
    l model.created_at.to_date, format: :long
  end

  def updated
    l model.updated_at.to_date, format: :long
  end
end
