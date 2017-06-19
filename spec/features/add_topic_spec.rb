require "rails_helper"

feature "Add Topic", js: true do
  let(:user) { create(:user) }

  scenario do
    radar = create(:radar, owner: user)
    login_as(user)
    visit radar_path(radar)
    click_link "New Blip"
    click_link "Add a New Topic"
    fill_in "Name", with: "Topic 1"
    click_button "Create Topic"
    visit radar_path(radar)
    click_link "New Blip"
    expect(page).to have_css("option", text: "Topic 1")
  end
end
