require "rails_helper"

describe Topic do
  before do
    # uniqueness matcher requires an existing record:
    # https://github.com/thoughtbot/shoulda-matchers/issues/300
    user = create(:user)
    create(:topic, creator: user)
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive.scoped_to(:creator_id) }

  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_uniqueness_of(:slug) }

  it { is_expected.to have_many(:blips) }

  it { is_expected.to belong_to(:creator).class_name("User") }
  it { is_expected.to validate_presence_of(:creator) }

  describe ".techradar", :admin do
    it "uses the existing topic if present" do
      existing = create(:topic, name: "techradar.io", creator: User.admin)

      result = described_class.techradar

      expect(result.id).to eq existing.id
    end

    it "creates the  topic if not present" do
      result = described_class.techradar

      expect(result.name).to eq "techradar.io"
    end
  end

  describe ".blippable" do
    it "is empty is there are no topics" do
      radar = create(:radar)

      result = described_class.blippable(radar)

      expect(result).to be_empty
    end

    it "includes only topics which haven't already been blipped" do
      radar = create(:radar)
      blipped_topic = create(:topic, creator: radar.owner)
      unblipped_topic = create(:topic, creator: radar.owner)
      create(:blip, topic: blipped_topic, radar: radar)

      result = described_class.blippable(radar)

      expect(result.map(&:id)).to include(unblipped_topic.id)
      expect(result.map(&:id)).not_to include(blipped_topic.id)
    end
  end
end
