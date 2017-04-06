require "rails_helper"

require "rails_helper"
describe "a user can shares a folder with another user" do
  context "they see a flash message confirming the collaboration" do
    it "the collaborator can view the folder share show page" do
      user1 = create(:user, id: 1)
      user2 = create(:user, id: 2)
      user1.roles.create(name: "registered user")
      user2.roles.create(name: "registered user")
      user1.roles.create(name: "activated")
      user2.roles.create(name: "activated")
      folder = create(:folder,
            user: user1,
            parent: user1.root_folder,
            name: "Code"
                    )
      Collaboration.create(folder: folder, user: user2)

      visit login_path

      fill_in "session[email]", with: user2.email
      fill_in "session[password]", with: user2.password
      click_button "Start Sharing"
      expect(current_path).to eq "/Folio"
      within(".shared-table") do
        expect(page).to have_content(folder.name)
        expect(page).to have_content(user1.username)
      end
      click_on "Code"
      expect(current_path).to eq("/f/share/#{folder.id}")
    end

    it "the collaborator can access nested folders" do
      user1 = create(:user, id: 1)
      user2 = create(:user, id: 2)
      user1.roles.create(name: "registered user")
      user2.roles.create(name: "registered user")
      user1.roles.create(name: "activated")
      user2.roles.create(name: "activated")
      folder = create(:folder,
            user: user1,
            parent: user1.root_folder,
            name: "Code"
                    )
      folder2 = create(:folder,
            user: user1,
            parent: folder,
            name: "Ruby"
                    )

      Collaboration.create(folder: folder, user: user2)

      visit login_path

      fill_in "session[email]", with: user2.email
      fill_in "session[password]", with: user2.password
      click_button "Start Sharing"
      expect(current_path).to eq "/Folio"
      within(".shared-table") do
        expect(page).to have_content(folder.name)
        expect(page).to have_content(user1.username)
      end
      click_on "Code"
      expect(current_path).to eq("/f/share/#{folder.id}")

      click_on "Ruby"
      expect(current_path).to eq("/f/share/#{folder2.id}")
    end

  end
end
