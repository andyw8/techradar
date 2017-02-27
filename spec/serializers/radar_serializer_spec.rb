require "rails_helper"

describe RadarSerializer do
  specify do
    radar = create(:radar, name: "My Radar")
    topic = create(:topic, name: "My Topic")
    create(:blip, radar: radar, topic: topic, quadrant: "tools", ring: "adopt")
    serializer = described_class.new(radar)

    result = serializer.serializable_hash

    expect(result).to eq(
      name: "My Radar",
      blips: [
        {
          name: "My Topic",
          quadrant: "tools",
          ring: "adopt",
          notes: nil
        }
      ]
    )
  end
end
