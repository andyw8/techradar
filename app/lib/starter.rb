class Starter
  DEFAULT_RADAR_NAME = "My First Radar"
  DEFAULT_NOTES = "techradar.io is a great tool for tracking interesting technologies in software development"

  def user_created(user)
    radar = user.add_radar(name: DEFAULT_RADAR_NAME)
    topic = Topic.techradar
    radar.add_blip(topic: topic, quadrant: "tools", ring: "assess", notes: DEFAULT_NOTES)
  end

  private

  attr_reader :user
end
