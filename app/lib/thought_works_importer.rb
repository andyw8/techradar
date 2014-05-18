class ThoughtWorksImporter
  def self.run(*args)
    new(*args).run
  end

  def run
    @owner = User.find_by(name: 'ThoughtWorks')
    fail unless owner
    owner.radars.delete_all
    data = File.read('db/thoughtworks.json')
    radars = JSON.parse(data)
    radars.each do |radar|
      parse_radar(radar)
    end
  end

  private

  def parse_radar(radar_json)
    date = Date.parse(radar_json.fetch('date') + '-01')
    title = "ThoughtWorks " + date.strftime('%B %Y')
    radar = Radar.create!(name: title, owner: owner)
    radar_json.fetch('blips').each do |blip|
      parse_blip(blip, radar)
    end
  end

  def parse_blip(blip, radar)
    name = blip.fetch('name')
    ring = blip.fetch('ring').underscore
    quadrant = blip.fetch('quadrant').underscore
    notes = blip.fetch('description')
    topic = Topic.find_or_create_by!(name: name)
    blip = radar.blips.create(topic: topic, ring: ring, quadrant: quadrant, notes: notes)
    blip.save || fail
  end

  attr_reader :owner
end
