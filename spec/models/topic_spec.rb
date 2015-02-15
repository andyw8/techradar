require "rails_helper"

describe Topic do
  before(:all) do
    # uniqueness matcher requires an existing record:
    # https://github.com/thoughtbot/shoulda-matchers/issues/300
    user = create(:user)
    create(:topic, creator: user)
  end

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }

  it { should have_many(:blips) }

  it { should belong_to(:creator).class_name("User") }
  it { should validate_presence_of(:creator) }

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
end
