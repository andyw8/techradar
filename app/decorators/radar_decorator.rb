class RadarDecorator < Draper::Decorator
  delegate_all

  def created
    l model.created_at.to_date, format: :long
  end

  def updated
    l model.updated_at.to_date, format: :long
  end
end
