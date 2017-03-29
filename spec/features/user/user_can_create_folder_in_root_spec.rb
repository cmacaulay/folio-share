require "rails_helper"

RSpec.feature "User" do
  context "registered" do
    scenario "can create folder in their root directory" do
      user   = create(:user, id: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home_path
      expect(page).to_not have_content("Pictures")
      click_on "Create New Folder"

      fill_in "folder[name]", with: "Pictures"

      click_on "Create Folder"

      expect(page).to have_content("Pictures")
      expect(current_path).to eq("/home")
    end
  end
end
