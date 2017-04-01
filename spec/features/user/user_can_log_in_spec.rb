require "rails_helper"

feature "user logs in" do
  context "appropriate login" do
    scenario "user logs in and is directed to their dashboard" do
      user = User.create(
        first_name: "Sal",
        last_name: "Espinosa",
        email: "espinosa1@example.com",
        cellphone: "3033333333",
        password: "password",
        username: "espinosa1"
      )

      visit login_path

      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password

      click_button "Login"

      expect(current_path).to eq("/home")
      expect(page).to have_content("Sal's Folio")
      expect(page).to_not have_content("Login")
      expect(page).to have_link("Logout")
    end
  end

  context "inappropriate login" do
    scenario "with incorrect information the user remains at login" do
      User.create(
        first_name: "Sal",
        last_name: "Espinosa",
        email: "espinosa2@example.com",
        cellphone: "3033333333",
        password: "password", 
        username: "espinosa2"
      )

      visit login_path

      fill_in "session[email]", with: "espinosa@hotmail.com"
      fill_in "session[password]", with: "pass"

      click_button "Login"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect entry")
      expect(page).to have_link("Login")
      expect(page).to_not have_link("Logout")
    end
  end
end
