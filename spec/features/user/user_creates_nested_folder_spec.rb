require "rails_helper"

RSpec.feature "User" do
  context "registered" do
    scenario "can create a nested folder" do
      user   = create(:user)
      root = user.folders.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit folder_path(root)
      expect(page).to_not have_content("Puppies")
      click_on "Create New Folder"

      fill_in "folder[name]", with: "Puppies"

      click_on "Create Folder"

      expect(page).to have_content("Puppies")
      expect(current_path).to eq("/f/#{root.id}")
    end
  end
end
