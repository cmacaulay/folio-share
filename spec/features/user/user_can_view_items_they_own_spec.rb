require 'rails_helper'

feature 'user can view items they own' do
  context 'file' do
    scenario 'user can view a file in their root director' do
      user = create(:user)
      root = user.folders.first
      upload = create(:upload, name: "Upload", folder: root)

      visit upload_path(upload)

      expect(page).to have_content(upload.name)
      expect(page).to have_content(upload.size)
      expect(page).to have_content(upload.file_type)
    end

    scenario 'user can view a sub-file' do
      user = create(:user)
      root = user.root_folder
      folder = create(:folder, name: "Folder", user: user, parent: root)
      upload = create(:upload, name: "Upload", folder: folder)

      visit folder_path(folder)

      click_link "Folder"

      expect(page).to have_content(upload.name)
      expect(page).to have_content(upload.size)
      expect(page).to have_content(upload.file_type)
    end
  end

  context 'folder' do
    scenario 'user can view the contents of a root directory' do
      user   = create(:user)
      root   = create(:folder, user: user)
      folder = create(:folder, name: "Alex's Folder", user: user, parent: root)
      upload = create(:upload, name: "Upload", folder: root)

      visit folder_path(root)

      expect(page).to have_link("Folder", href: folder_path(folder))
      expect(page).to have_link("Upload", href: upload_path(upload))
    end

    scenario 'user can view the contents of a sub-folder' do
      user    = create(:user)
      root    = create(:folder, user: user)
      folder1 = create(:folder, name: "Folder 1", user: user, parent: root)
      folder2 = create(:folder, name: "Folder 2", user: user, parent: folder1)
      upload1 = create(:upload, name: "Upload 1", folder: root)
      upload2 = create(:upload, name: "Upload 2", folder: folder1)

      visit folder_path(root)

      click_link "Folder 1"

      expect(page).to have_link("Folder 2", href: folder_path(folder1))
      expect(page).to have_link("Upload 2", href: upload_path(upload))
      expect(page).to_not have_link("Folder 1", href: folder_path(folder1))
      expect(page).to_not have_link("Upload 1", href: upload_path(upload))
    end
  end
end