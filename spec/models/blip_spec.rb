require 'rails_helper'

describe Blip do
  it { should belong_to(:radar) }
  it { should belong_to(:topic) }

  it { should validate_presence_of(:topic_id) }
  it { should validate_presence_of(:quadrant) }
  it { should ensure_inclusion_of(:quadrant).in_array(Blip::QUADRANTS) }
  it { should validate_presence_of(:ring) }
  it { should ensure_inclusion_of(:ring).in_array(Blip::RINGS) }
  it { should validate_presence_of(:radar) }

  context "duplicate topics" do
    let(:user) { create(:user) }
    let(:radar) { create(:radar, owner: user) }
    let(:topic) { create(:topic) }
    before { create(:blip, topic: topic, radar: radar) }

    specify "cannot have two with same topic in the same radar" do
      duplicate_blip = build(:blip, topic: topic, radar: radar)
      expect(duplicate_blip).to_not be_valid
      errors = duplicate_blip.errors[:topic_id]
      expect(errors).to eq(['already exists in this radar'])
    end

    specify "can have two with same name in a different radar" do
      another_radar = create(:radar, owner: user)
      duplicate_blip = build(:blip, topic: topic, radar: another_radar)
      expect(duplicate_blip).to be_valid
    end
  end

  xit "should touch its parent radar when saved" do
  end

  xit "should touch its parent when a new blip is added" do
  end
end
