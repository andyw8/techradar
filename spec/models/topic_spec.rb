require 'spec_helper'

describe Topic do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }

  it { should have_many(:blips) }

  it { should belong_to(:creator).class_name('User') }

  describe "#techradar" do
    it "uses the existing topic if present" do
      existing = create(:topic, name: "techradar.io")

      result = described_class.techradar

      expect(result).to eq existing
    end

    it "creates the  topic if not present" do
      result = described_class.techradar

      expect(result.name).to eq "techradar.io"
    end
  end
end
