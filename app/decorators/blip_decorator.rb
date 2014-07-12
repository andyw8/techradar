class BlipDecorator < Draper::Decorator
  delegate_all

  def last_modified
    l blip.updated_at, format: "%B %Y"
  end
end
