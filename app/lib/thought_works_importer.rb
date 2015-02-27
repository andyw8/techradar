class ThoughtWorksImporter
  def self.run(*args)
    new(*args).run
  end

  def run
    ActiveRecord::Base.record_timestamps = false
    ActiveRecord::Base.transaction do
      @owner = User.thoughtworks
      owner.radars.delete_all
      data = File.read("db/thoughtworks.json")
      radars = JSON.parse(data)
      radars.each do |radar|
        parse_radar(radar)
      end
    end
    ActiveRecord::Base.record_timestamps = true
  end

  private

  def corrections
    {
      "Capture domain events explicitily" => "Capture domain events explicitly",
      "Exhaustive browser-based testing" => "Exhaustive browser based testing",
      "HTML 5 for offline applications" => "HTML5 for offline applications",
      "Ruby/Jruby" => "Ruby/JRuby",
      "SASS, SCSS, and LESS" => "SASS, SCSS, LESS, and Stylus"
    }
  end

  def parse_radar(radar_json)
    date = Date.parse(radar_json.fetch("date") + "-01")
    title = "ThoughtWorks " + date.strftime("%B %Y")
    radar = Radar.create!(name: title, owner: owner)
    radar.update_attributes!(created_at: date, updated_at: date)
    radar_json.fetch("blips").each do |blip|
      parse_blip(blip, radar)
    end
  end

  def parse_blip(blip, radar)
    name = blip.fetch("name")
    name = corrections.fetch(name) if corrections.key?(name)
    ring = blip.fetch("ring").underscore
    quadrant = blip.fetch("quadrant").underscore
    notes = ActionController::Base.helpers.strip_tags(blip.fetch("description"))
    Rails.logger.info "Adding: #{name}"
    topic = Topic.lookup(name) ||
      Topic.create!(name: name, creator: User.thoughtworks)
    blip = radar.blips.create(topic: topic, ring: ring, quadrant: quadrant, notes: notes)
    blip.save!
  end

  attr_reader :owner
end
