class Ability
  def initialize(user)
    @user = user
  end

  def can?(action, resource = nil)
    case action
    when :create
      (resource == Radar && user.present?) ||
        (resource.is_a?(Blip) && resource.radar.owned_by?(user))
    when :edit, :delete
      (resource.is_a?(Radar) && resource.owned_by?(user)) ||
        (resource.is_a?(Blip) && resource.radar.owned_by?(user))
    else
      # :nocov:
      raise "Unknown action #{action} for #{resource}"
      # :nocov:
    end
  end

  private

  attr_reader :user
end
