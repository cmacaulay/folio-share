require "rails_helper"

feature "user can view" do
  context "a file they own" do
    scenario   "located in their root directory" do
      user = create(:user)
      root = user.folders.first
      upload = create(:upload, name: "Upload", folder: root)

      visit upload_path(upload)

      expect(page).to have_content(upload.name)
      expect(page).to have_content(upload.size)
      expect(page).to have_content(upload.content_type)
      expect(page).to have_css("div.comments")
    end

    scenario "located in a subfolder" do
      user = create(:user)
      root = user.root_folder
      folder = create(:folder, name: "Folder", user: user, parent: root)
      upload = create(:upload, name: "Upload", folder: folder)

      visit folder_path(folder)

      click_link "Upload"

      expect(page).to have_content(upload.name)
      expect(page).to have_content(upload.size)
      expect(page).to have_content(upload.content_type)
      expect(page).to have_css("div.comments")
    end
  end

  context "inside" do
    context "their root folder" do
      scenario "that has items" do
        user   = create(:user)
        root   = user.folders.first
        folder = create(:folder, name: "Folder", user: user, parent: root)
        upload = create(:upload, name: "Upload", folder: root)

        visit folder_path(root)

        expect(page).to have_link("Folder", href: folder_path(folder))
        expect(page).to have_link("Upload", href: upload_path(upload))
      end

      xscenario "that is empty" do
        
      end
    end

    context "a subfolder they own" do
      scenario "that has items" do
        user    = create(:user)
        root    = user.folders.first
        folder1 = create(:folder, name: "Folder 1", user: user, parent: root)
        folder2 = create(:folder, name: "Folder 2", user: user, parent: folder1)
        upload1 = create(:upload, name: "Upload 1", folder: root)
        upload2 = create(:upload, name: "Upload 2", folder: folder1)

        visit folder_path(root)

        click_link "Folder 1"

        expect(page).to have_link("Folder 2", href: folder_path(folder2))
        expect(page).to have_link("Upload 2", href: upload_path(upload2))
        expect(page).to_not have_link("Folder 1", href: folder_path(folder1))
        expect(page).to_not have_link("Upload 1", href: upload_path(upload1))
      end

      xscenario "that is empty" do
        
      end
    end
  end
end
