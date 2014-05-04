require 'spec_helper'

feature 'Blips' do
  let(:user) { create(:user) }
  let(:radar) { create(:radar, owner: user) }

  before do
    login_as(user)
  end

  scenario 'Radar has no blips' do
    visit radar_path(radar)
    expect(page).to have_css('.blip', count: 0)
  end

  scenario 'Radar has blips' do
    2.times { create(:blip, radar: radar) }
    visit radar_path(radar)
    expect(page).to have_css('.blip', count: 2)
  end

  scenario 'Adding a blip' do
    visit radar_path(radar)
    click_link 'New Blip'
    fill_in 'Name', with: 'Purple'
    select 'tools', from: 'Quadrant'
    select 'adopt', from: 'Ring'
    fill_in 'Notes', with: 'My Notes'
    click_button 'Create Blip'
    expect(page).to have_css('tr.tools td.adopt', text: 'Purple')
    purple = page.find('.blip', text: 'Purple')
    expect(purple[:title]).to eq 'My Notes'
  end
end
