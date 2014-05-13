class Starter
  DEFAULT_RADAR_NAME = "My First Radar"
  DEFAULT_NOTES = "techradar.io is a great tool for tracking interesting technologies in software development"

  def initialize(user)
    @user = user
  end

  def run
    radar = user.add_radar(name: DEFAULT_RADAR_NAME)
    topic = Topic.where(name: "techradar.io").first || fail("Could not find starter radar")
    radar.add_blip(topic: topic, quadrant: 'tools', ring: 'assess', notes: DEFAULT_NOTES)
  end

  def self.run(*args)
    new(*args).run
  end

  private

  attr_reader :user
end
