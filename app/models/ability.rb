class Ability
  def initialize(user)
    @user = user
  end

  # :reek:TooManyStatements { max_statements: 7}
  def can?(action, resource = nil)
    case action
    when :create_radar
      user.present?
    when :edit_radar, :delete_radar
      resource.owned_by?(user)
    when :create_blip
      radar = resource
      radar.owned_by?(user)
    when :edit_blip, :delete_blip
      blip = resource
      blip.radar.owned_by?(user)
    else
      # :nocov:
      raise "Unknown action #{action} for #{resource}"
      # :nocov:
    end
  end

  private

  attr_reader :user
end
