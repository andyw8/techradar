require "rails_helper"

describe Radar do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should belong_to(:owner).class_name("User") }
  it { should have_many(:blips).dependent(:delete_all) }

  describe "#new_blip" do
    it "builds a new blip on the blips association" do
      params = double
      expect(subject.blips).to receive(:new).with(params)
      subject.new_blip(params)
    end
  end
end
