require "rails_helper"

module Topics
  describe Blippable do
    it "is empty is there are no topics" do
      radar = create(:radar)

      result = described_class.call(radar)

      expect(result).to be_empty
    end

    it "includes only topics which haven't already been blipped" do
      radar = create(:radar)
      blipped_topic = create(:topic, creator: radar.owner)
      unblipped_topic = create(:topic, creator: radar.owner)
      create(:blip, topic: blipped_topic, radar: radar)

      result = described_class.call(radar)

      expect(result.map(&:id)).to include(unblipped_topic.id)
      expect(result.map(&:id)).not_to include(blipped_topic.id)
    end
  end
end
