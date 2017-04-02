require "rails_helper"

describe "a user can shares a folder with another user" do
  context "they see a flash message confirming the collaboration" do
    it "redirects them to their home page" do
      user1 = create(:user, id: 1)
      user2 = create(:user, id: 2)
      create folder
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
      fill_in :user, with: user2.username
      click_on "Collaborate"

      expect(page).to have_content("You shared Code with #{user2.username}!")
      expect(current_path)to eq "/home"
    end

    it "the collaborator sees the folder when they visit their homepage" do
      user1 = create(:user, id: 1)
      user2 = create(:user, id: 2)
      create folder
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
      fill_in :user, with: user2.username
      click_on "Collaborate"

      expect(page).to have_content("You shared Code with #{user2.username}!")
      expect(current_path)to eq "/home"

      click_on "Logout"
      expect(current_path).to eq('/login')

      fill_in "session[email]", with: user1.email
      fill_in "session[password]", with: user1.password

      click_button "Start Sharing"
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      # allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user2.root_folder)
      #
      # visit '/'
      #
      # expect(page).to have_content(user1.username)
      # expect(page).to have_content("Music")
    end
  end
end
