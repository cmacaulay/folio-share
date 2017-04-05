require "rails_helper"

feature "User can change the privacy settings" do
  context "on a folder they own" do
    it "from private to public" do
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

    it "from public to private" do
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
  end

  context "on a file they own" do
    it "from private to public" do
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

    it "from public to private" do
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
  end
end