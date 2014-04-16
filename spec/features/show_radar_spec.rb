require 'spec_helper'

feature 'Show radar' do
  scenario 'User has no radars' do
    visit radars_path
    expect(page).to have_css('.radar', count: 0)
  end

  scenario 'User has a radar' do
    create(:radar, name: 'March 2014')
    visit radars_path
    within('.radars') do
      expect(page).to have_text('March 2014')
    end
  end
end
