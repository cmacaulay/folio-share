require "rails_helper"

RSpec.feature "User" do
  context "registered" do
    scenario "can create folder in their root directory" do
      user = create(:user, id: 1)
      root = user.folders.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home_path
      expect(page).to_not have_content("Pictures")
      click_on "Create New Folder"

      fill_in "folder[name]", with: "Pictures"

      click_on "Create Folder"

      expect(page).to have_content("Pictures")
      expect(current_path).to eq("/f/#{root.id}")
    end

    scenario "doesn't enter any info before clicking Create Folder" do
      user = create(:user, id: 1)
      root = user.folders.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit home_path
      expect(page).to_not have_content("Pictures")
      click_on "Create New Folder"

      click_on "Create Folder"

      expect(page).to have_content("Incorrect Entry")
      expect(current_path).to eq("/f")
    end
  end
end
