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
end
