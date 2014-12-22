require "rails_helper"

feature "Guest views radar" do
  scenario do
    owner = create(:user)
    radar = create(:radar, name: "My Radar", owner: owner)
    visit radar_path(radar)
    expect(page).to have_content("My Radar")
  end
end

feature "Show radar" do
  let(:user) { create(:user) }
  before do
    login_as(user)
  end

  scenario "User has no radars" do
    visit radars_path
    expect(page).to have_css(".radar", count: 0)
  end

  scenario "User has a radar" do
    create(:radar, name: "March 2014", owner: user)
    visit radars_path
    within("ul.radars") do
      expect(page).to have_text("March 2014")
    end
  end

  scenario "Create a radar" do
    navigate_to_radars
    click_link "New Radar"
    fill_in "Name", with: "March 2014"
    click_button "Create Radar"
    expect(current_path).to eq radar_path(Radar.last)
    expect(page).to have_text("March 2014")
  end

  scenario "Create radar (invalid data)" do
    visit new_radar_path
    click_button "Create Radar"
    expect(page).to have_content("can't be blank")
  end

  scenario "Delete a radar" do
    radar = create(:radar, owner: user)
    navigate_to_radars
    within("ul.radars") { click_link radar.name }
    click_button "Delete"
    expect(page).to have_no_text(radar.name)
  end

  private

  def navigate_to_radars
    visit "/"
    within(".nav") { click_link "Radars" }
  end
end
