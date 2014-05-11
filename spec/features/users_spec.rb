require 'spec_helper'

feature 'Users' do
  scenario 'Non-admin tries to view users list' do
    user = create(:user)
    login_as(user)
    visit users_path
    expect(current_path).to eq root_path
    expect(page).to have_content('Access denied, admin only')
  end

  scenario 'Admin tries to view users list' do
    admin = create(:admin)
    login_as(admin)
    visit users_path
    expect(current_path).to eq users_path
  end
end
