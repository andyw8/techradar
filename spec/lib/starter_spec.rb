require 'rails_helper'
require 'starter'

describe Starter do
  it "creates a sample radar" do
    user = create(:user)

    Starter.new.user_created(user)

    radars = user.radars
    expect(radars.count).to eq(1)
    expect(radars.first.name).to eq(described_class::DEFAULT_RADAR_NAME)
  end

  it "creates a sample blip" do
    user = create(:user)

    Starter.new.user_created(user)

    expect(user.radars.first.blips.count).to eq(1)
  end
end
