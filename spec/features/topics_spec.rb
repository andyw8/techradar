require 'spec_helper'

feature 'Topics' do
  scenario "View list of topics" do
    create(:topic, name: "Java")
    create(:topic, name: "Python")
    visit root_path
    click_link "Topics"
    expect(page).to have_css(".topic", text: "Java")
    expect(page).to have_css(".topic", text: "Python")
  end

  scenario "View a single topic" do
    create(:topic, name: "Java")
    visit topics_path
    click_link "Java"
    expect(page).to have_css("h1", text: "Java")
  end

  scenario "A topic with blips" do
    java = create(:topic, name: "Java")
    radar_1 = create(:radar, name: "Radar 1")
    radar_2 = create(:radar, name: "Radar 2")
    create(:blip, topic: java, radar: radar_1)
    create(:blip, topic: java, radar: radar_2)
    visit topic_path(java)
    expect(page).to have_text("Radar 1")
    expect(page).to have_text("Radar 2")
  end
end
