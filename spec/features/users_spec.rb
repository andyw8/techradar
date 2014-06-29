require 'rails_helper'

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

feature 'Sign up and confirm' do
  scenario 'Happy path' do
    visit new_user_registration_path
    fill_in "Email", with: "foo@example.com"
    fill_in "user_password", with: "password1234"
    fill_in "user_password_confirmation", with: "password1234"
    click_button "Sign up"
    expect(page).to have_content('Please open the link to activate your account')
    open_email('foo@example.com')
    current_email.click_link 'Confirm my account'
    fill_in "Email", with: "foo@example.com"
    fill_in "user_password", with: "password1234"
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_css(".radars", text: "My First Radar")
    click_link "My First Radar"
    within("table") { click_link "techradar.io" }
    expect(page).to have_text('techradar.io is a great tool')
  end
end
