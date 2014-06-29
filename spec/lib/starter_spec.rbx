require 'rails_helper'

describe Starter do
  let(:user) { create(:user) }

  before do
    Topic.create!(name: "techradar.io")
    Starter.run(user)
  end

  it "creates a sample radar" do
    radars = user.radars
    expect(radars.count).to eq(1)
    expect(radars.first.name).to eq(described_class::DEFAULT_RADAR_NAME)
  end

  it "creates a sample blip" do
    expect(user.radars.first.blips.count).to eq(1)
  end
end
