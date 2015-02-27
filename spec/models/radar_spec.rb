require "rails_helper"

describe Radar do
  describe "validations" do
    it { should belong_to(:owner).class_name("User") }
    it { should have_many(:blips).dependent(:delete_all) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner) }
    it { should validate_uniqueness_of(:name) }

    it "prevents duplicate names for radars with the same owner" do
      owner = create(:user)
      create(:radar, owner: owner, name: "My Radar")

      another_radar = build(:radar, owner: owner, name: "my radar")

      another_radar.valid?
      expect(another_radar.errors.messages).to include(
        name: ["has already been taken"]
      )
    end

    it "allows duplicate names for radars with a different owner" do
      owner = create(:user)
      create(:radar, owner: owner, name: "My Radar")

      another_owner = create(:user)
      another_radar = build(:radar, owner: another_owner, name: "My Radar")

      expect(another_radar).to be_valid
    end
  end

  it "is assigns a UUID before validation" do
    radar = build(:radar)
    allow(SecureRandom).to receive(:uuid) { "abc123" }

    radar.valid?

    expect(radar.uuid).to eq("abc123")
  end

  it "doesn't change the UUID when the radar is updated" do
    radar = create(:radar)
    original_uuid = radar.uuid

    radar.valid?

    expect(radar.uuid).to eq(original_uuid)
  end

  describe "default scope" do
    it "orders by the updated timestamp" do
      middle = create(:radar, updated_at: 2.day.ago)
      oldest = create(:radar, updated_at: 3.day.ago)
      newest = create(:radar, updated_at: 1.day.ago)

      result = described_class.all

      expect(result).to eq([newest, middle, oldest])
    end
  end

  describe "#new_blip" do
    it "builds a new blip on the blips association" do
      params = double(:params)
      allow(subject.blips).to receive(:new)

      subject.new_blip(params)

      expect(subject.blips).to have_received(:new).with(params)
    end
  end

  describe "#find_blip" do
    specify do
      radar = build(:radar)
      topic = create(:topic, slug: "java")
      blip = create(:blip, radar: radar, topic: topic)

      result = radar.find_blip("java")

      expect(result).to eq(blip)
    end
  end

  describe "#owned_by?" do
    specify do
      user = build(:user)
      radar = build(:radar, owner: user)

      result = radar.owned_by?(user)

      expect(result).to be(true)
    end

    specify do
      user = build(:user)
      another_user = build(:user)
      radar = build(:radar, owner: user)

      result = radar.owned_by?(another_user)

      expect(result).to be(false)
    end
  end
end
