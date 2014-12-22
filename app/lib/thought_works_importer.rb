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
    ring = blip.fetch("ring").underscore
    quadrant = blip.fetch("quadrant").underscore
    notes = blip.fetch("description")
    last_modified = blip.fetch("lastModified")
    puts "Adding: #{name}"
    topic = Topic.where(["lower(name) = ?", name.downcase]).first ||
            Topic.create!(name: name, creator: User.thoughtworks)
    blip = radar.blips.create(topic: topic, ring: ring, quadrant: quadrant, notes: notes)
    blip.save!

    if last_modified.present?
      date = Date.parse(last_modified + "-01")
      blip.update_attributes!(created_at: date, updated_at: date)
    end
  end

  attr_reader :owner
end
