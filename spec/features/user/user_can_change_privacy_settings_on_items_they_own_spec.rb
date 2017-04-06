require "rails_helper"

feature "User can change the privacy setting" do
  describe "on a folder they own" do
    describe "from private to public" do
      it "" do
        user = create(:user)
        folio = user.root_folder
        folder = create(:folder, name: "Subfolder 1", is_private: true, parent: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path

        within("#folder-#{folder.id}") do
          expect(page).to have_content("Subfolder 1")
          expect(page).to have_css(".make-public-button")
          expect(page).to have_css(".private-icon")
        end

        click_on "Make Public"

        within("#folder-#{folder.id}") do
          expect(page).to have_content("Subfolder 1")
          expect(page).to have_css(".make-private-button")
          expect(page).to have_css(".public-icon")
        end
      end

      it "and it will appear on the list of public folders" do
        user = create(:user)
        folio = user.root_folder
        folder = create(:folder, name: "Subfolder 1", is_private: true, parent: folio, user: user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path
        click_on "Make Public"
        visit public_path

        within("#public-folders") do
          expect(page).to have_link(folder.name, href: public_folder_path(folder))
          expect(page).to have_content(user.username)
        end
      end

      it "and they can view the folder contents publicly" do
        user = create(:user)
        folio = user.root_folder
        folder1 = create(:folder, name: "Subfolder 1", is_private: true, parent: folio, user: user)
        folder2 = create(:folder, name: "Subfolder 1.1", is_private: true, parent: folder1, user: user)
        upload = create(:upload, is_private: true, folder: folder1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path
        click_on "Make Public"
        visit public_path

        click_on "Subfolder 1"

        expect(page).to have_link("Return to Browsing", href: public_path)
        expect(page).to have_link("Download Folder", href: folder_download_path(folder1))
        expect(page).to have_link("View in Folio", href: folder_path(folder1))
        expect(page).to have_content("Subfolder 1.1")
        expect(page).to have_content(upload.name)

        expect(page).to_not have_css(".public_icon")
        expect(page).to_not have_css(".make-private-button")
        expect(page).to_not have_css(".delete-button")
        expect(page).to_not have_css(".share-button")
      end
    end

    describe "from public to private" do
      it "" do
        user = create(:user)
        folio = user.root_folder
        folder = create(:folder, name: "Subfolder 1", is_private: false, parent: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path

        within("#folder-#{folder.id}") do
          expect(page).to have_content("Subfolder 1")
          expect(page).to have_css(".make-private-button")
          expect(page).to have_css(".public-icon")
        end

        click_on "Make Private"

        within("#folder-#{folder.id}") do
          expect(page).to have_content("Subfolder 1")
          expect(page).to have_css(".make-public-button")
          expect(page).to have_css(".private-icon")
        end
      end

      it "and it will not appear on the list of public folders" do
        user = create(:user)
        folio = user.root_folder
        folder = create(:folder, name: "Subfolder 1", is_private: false, parent: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path

        click_on "Make Private"

        visit public_path

        within("#public-folders") do
          expect(page).to_not have_link(folder.name, href: public_folder_path(folder))
        end
      end
    end
  end

  describe "on a file they own" do
    describe "from private to public" do
      it "" do
        user = create(:user)
        folio = user.root_folder
        upload = create(:upload, is_private: true, folder: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path

        within("#upload-#{upload.id}") do
          expect(page).to have_content(upload.name)
          expect(page).to have_css(".make-public-button")
          expect(page).to have_css(".private-icon")
        end

        click_on "Make Public"

        within("#upload-#{upload.id}") do
          expect(page).to have_content(upload.name)
          expect(page).to have_css(".make-private-button")
          expect(page).to have_css(".public-icon")
        end
      end

      it "and it will appear on the list of public files" do
        user = create(:user)
        folio = user.root_folder
        upload = create(:upload, is_private: true, folder: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path
        click_on "Make Public"
        visit public_path

        within("#public-files") do
          expect(page).to have_link(upload.name, href: public_upload_path(upload))
          expect(page).to have_content(user.username)
        end
      end

      it "and they can view the file contents publicly" do
        user = create(:user)
        folio = user.root_folder
        upload = create(:upload, is_private: true, folder: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path
        click_on "Make Public"
        visit public_path

        click_on upload.name

        expect(page).to have_link("Download", href: upload_download_path(upload))
        expect(page).to have_content(upload.name)
        expect(page).to have_content(upload.user.username)
        expect(page).to have_content(upload.size)
        expect(page).to have_content(upload.content_type)
        expect(page).to have_css(".comment_section")
        expect(page).to_not have_button("Delete")
      end
    end

    describe "from public to private" do
      it "" do
        user = create(:user)
        folio = user.root_folder
        upload = create(:upload, is_private: false, folder: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path

        within("#upload-#{upload.id}") do
          expect(page).to have_content(upload.name)
          expect(page).to have_css(".make-private-button")
          expect(page).to have_css(".public-icon")
        end

        click_on "Make Private"

        within("#upload-#{upload.id}") do
          expect(page).to have_content(upload.name)
          expect(page).to have_css(".make-public-button")
          expect(page).to have_css(".private-icon")
        end
      end

      it "and it will not appear on the list of public files" do
        user = create(:user)
        folio = user.root_folder
        upload = create(:upload, is_private: false, folder: folio)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit folio_path
        click_on "Make Private"
        visit public_path

        within("#public-files") do
          expect(page).to_not have_link(upload.name, href: public_upload_path(upload))
        end
      end
    end
  end
end