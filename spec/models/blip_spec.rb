require 'spec_helper'

describe Blip do
  it { should belong_to(:radar) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quadrant) }
  it { should ensure_inclusion_of(:quadrant).in_array(Blip::QUADRANTS) }
  it { should validate_presence_of(:ring) }
  it { should ensure_inclusion_of(:ring).in_array(Blip::RINGS) }
  it { should validate_presence_of(:radar) }

  context "duplicate names" do
    let(:user) { create(:user) }
    let(:radar) { create(:radar, owner: user) }
    before { create(:blip, name: 'foo', radar: radar) }

    specify "cannot have two with same name in the same radar" do
      duplicate_blip = build(:blip, name: 'foo', radar: radar)
      expect(duplicate_blip).to_not be_valid
      expect(duplicate_blip.errors[:name]).to eq ['already exists in this radar']
    end

    specify "can have two with same name in a different radar" do
      another_radar = create(:radar, owner: user)
      duplicate_blip = build(:blip, name: 'foo', radar: another_radar)
      expect(duplicate_blip).to be_valid
    end
  end
end
