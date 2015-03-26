require "rails_helper"

feature "Sign up and confirm", :admin do
  scenario "Happy path" do
    user = create(:user)
    sign_in(user)
    expect(current_path).to eq(new_bulk_topic_path)
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in "Username", with: user.username
    fill_in "user_password", with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully")
  end
end
