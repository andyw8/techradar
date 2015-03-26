require "rails_helper"

feature "Bulk Add Topics" do
  let(:user) { create(:user) }

  scenario do
    create(:radar, owner: user)
    login_as(user)
    visit new_bulk_topic_path
    fill_in "Topics", with: "Topic 1\nTopic 2"
    click_button "Create Topics"
    visit radar_path(user.radars.last)
    click_link "New Blip"
    expect(page).to have_css("option", text: "Topic 1")
    expect(page).to have_css("option", text: "Topic 2")
  end
end
