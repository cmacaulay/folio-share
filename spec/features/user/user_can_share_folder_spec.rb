require "rails_helper"

describe "a user can shares a folder with another user" do
  context "they see a flash message confirming the collaboration" do
    it "redirects them to their home page" do
      user1 = create(:user, id: 1)
      user2 = create(:user, id: 2)
      folder = create(:folder,
            user: user1,
            parent: user1.root_folder,
            name: "Code"
                    )
      visit "/"
      click_on "Login"

      fill_in "session[email]", with: user1.email
      fill_in "session[password]", with: user1.password

      click_button "Start Sharing"

      expect(current_path).to eq("/home")
      expect(page).to have_content(folder.name)

      click_on "Share Folder"
      fill_in "collaboration[user]", with: user2.username
      click_on "Collaborate"

      expect(page).to have_content("You shared Code with #{user2.username}!")
      expect(current_path).to eq "/f/#{folder.id}"
    end

    it "the collaborator sees the folder when they visit their homepage" do
      user1 = create(:user, id: 1)
      user2 = create(:user, id: 2)
      folder = create(:folder,
            user: user1,
            parent: user1.root_folder,
            name: "Code"
                    )

      visit "/"
      click_on "Login"

      fill_in "session[email]", with: user1.email
      fill_in "session[password]", with: user1.password

      click_button "Start Sharing"

      expect(current_path).to eq("/home")
      expect(page).to have_content(folder.name)

      click_on "Share Folder"

      fill_in "collaboration[user]", with: user2.username
      click_on "Collaborate"

      expect(page).to have_content("You shared Code with #{user2.username}!")
      expect(current_path).to eq("/f/#{folder.id}")

      click_on "Logout"
      expect(current_path).to eq('/login')

      fill_in "session[email]", with: user2.email
      fill_in "session[password]", with: user2.password

      click_button "Start Sharing"

      expect(current_path).to eq "/home"
      within(".shared-table") do
        expect(page).to have_content(folder.name)
        expect(page).to have_content(user1.username)
      end
    end

    it "won't successfully share if the username" do
      user1 = create(:user, id: 1)
      folder = create(:folder,
            user: user1,
            parent: user1.root_folder,
            name: "Code"
                    )

      visit "/"
      click_on "Login"

      fill_in "session[email]", with: user1.email
      fill_in "session[password]", with: user1.password

      click_button "Start Sharing"

      expect(current_path).to eq("/home")
      expect(page).to have_content(folder.name)

      click_on "Share Folder"

      fill_in "collaboration[user]", with: "Casey"
      click_on "Collaborate"

      expect(page).to have_content("User not found, please try again.")
      expect(current_path).to eq("/f/#{folder.id}/share")
    end
  end
end
