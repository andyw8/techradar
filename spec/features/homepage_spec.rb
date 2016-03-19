require "rails_helper"

feature "Homepage" do
  scenario do
    visit root_path
    expect(page).to have_text("Build Your Own Technology Radar")
  end
end
