require 'spec_helper'

feature 'Show radar' do
  let(:user) { create(:user) }
  before do
    login_as(user)
  end

  scenario 'User has no radars' do
    visit radars_path
    expect(page).to have_css('.radar', count: 0)
  end

  scenario 'User has a radar' do
    create(:radar, name: 'March 2014', owner: user)
    visit radars_path
    within('.radars') do
      expect(page).to have_text('March 2014')
    end
  end

  scenario 'Create a radar' do
    navigate_to_radars
    click_link 'New Radar'
    fill_in 'Name', with: 'March 2014'
    click_button 'Create Radar'
    within('.radars') do
      expect(page).to have_text('March 2014')
    end
  end

  scenario 'Delete a radar' do
    radar = create(:radar, owner: user)
    navigate_to_radars
    within('.radars') { click_link radar.name }
    click_button 'Delete'
    within('.radars') do
      expect(page).to have_no_text(radar.name)
    end
  end

  private

  def navigate_to_radars
    visit '/'
    within('.nav') { click_link 'Radars' }
  end
end
