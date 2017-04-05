require "rails_helper"

RSpec.feature "User" do
  context "registered" do
    scenario "can create folder in their root directory" do
      user = create(:user)
      user = UserDecorator.new(user)

      root = user.folders.first
      controller = ApplicationController
      allow_any_instance_of(controller).to receive(:current_user).and_return(user)

      visit folio_path
      expect(page).to_not have_content("Pictures")
      click_on "Create New Folder"

      fill_in "folder[name]", with: "Pictures"

      click_on "Create Folder"

      expect(current_path).to eq("/f/#{Folder.last.id}")
      within("div.breadcrumbs") do
        expect(page).to have_link("Folio", href: folio_path)
        expect(page).to have_content("Pictures")
      end
    end

    scenario "doesn't enter any info before clicking Create Folder" do
      user = create(:user)
      user = UserDecorator.new(user)

      root = user.folders.first
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit folio_path
      expect(page).to_not have_content("Pictures")
      click_on "Create New Folder"

      click_on "Create Folder"

      expect(page).to have_content("Incorrect Entry")
      expect(current_path).to eq(new_folder_path(root))
    end
  end
end
