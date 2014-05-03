require 'spec_helper'

feature "Blip with quadrant" do
  let(:user) { create(:user) }
  before do
    login_as(user)
  end

  scenario 'adding a blip' do
    radar = create(:radar, owner: user)
    visit new_radar_blip_path(radar)
    fill_in 'Name', with: 'My Blip'
    select 'tools', from: 'Quadrant'
    click_button 'Create Blip'
    expect(page).to have_content("My Blip (tools)")
  end
end
