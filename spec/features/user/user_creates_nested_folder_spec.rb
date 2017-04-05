require "rails_helper"

RSpec.feature "User" do
  context "registered" do
    scenario "can create a nested folder" do
      user = create(:user)
      user_decorator = UserDecorator.new(user)
      root = user.root_folder
      subfolder = create(:folder, user: user, parent: root)

      controller = ApplicationController
      allow_any_instance_of(controller).to receive(:current_user).and_return(user_decorator)

      visit folder_path(subfolder)
      expect(page).to_not have_content("Puppies")
      click_on "Create New Folder"

      fill_in "folder[name]", with: "Puppies"

      click_on "Create Folder"

      expect(current_path).to eq("/f/#{Folder.last.id}")
      within("div.breadcrumbs") do
        expect(page).to have_link("Folio", href: folio_path)
        expect(page).to have_link(subfolder.name, href: folder_path(subfolder))
        expect(page).to have_content("Puppies")
      end
    end
  end
end
