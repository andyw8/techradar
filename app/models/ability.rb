class Ability
  def initialize(user)
    @user = user
  end

  def can?(action, resource = nil)
    case action
    when :create
      resource == Radar && user.present?
    when :edit, :delete
      resource.is_a?(Radar) && resource.owned_by?(user)
    when :create_blip
      resource.owned_by?(user)
    when :edit_blip, :delete_blip
      resource.radar.owned_by?(user)
    else
      # :nocov:
      raise "Unknown action #{action} for #{resource}"
      # :nocov:
    end
  end

  private

  attr_reader :user
end
