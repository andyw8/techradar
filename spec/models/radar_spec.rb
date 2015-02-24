require "rails_helper"

describe Radar do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner) }
    it { should belong_to(:owner).class_name("User") }
    it { should have_many(:blips).dependent(:delete_all) }

    it "should prevent duplicate names for radars with the same owner" do
      owner = create(:user)
      create(:radar, owner: owner, name: "My Radar")

      another_radar = build(:radar, owner: owner, name: "my radar")

      another_radar.valid?
      expect(another_radar.errors.messages).to include(
        name: ["has already been taken"]
      )
    end

    it "should allow duplicate names for radars with a different owner" do
      owner = create(:user)
      create(:radar, owner: owner, name: "My Radar")

      another_owner = create(:user)
      another_radar = build(:radar, owner: another_owner, name: "My Radar")

      expect(another_radar).to be_valid
    end
  end

  describe "#new_blip" do
    it "builds a new blip on the blips association" do
      params = double
      expect(subject.blips).to receive(:new).with(params)
      subject.new_blip(params)
    end
  end
end
