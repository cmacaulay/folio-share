require 'rails_helper'

feature 'user logs in' do
  context 'appropriate login' do
    scenario 'user logs in and is directed to their dashboard' do
      User.create(first_name: "sal",
                  last_name: "espinosa",
                  email: "espinosa@aol.com",
                  cellphone: "3033333333",
                  password: "password",
                  password_confirmation: "password")

      visit login_path

      fill_in "session[email]", with: "espinosa@aol.com"
      fill_in "session[password]", with: "password"

      click_button 'Login'

      expect(current_path).to eq('/home')
      expect(page).to have_content("sal's Folio")
      expect(page).to_not have_content("Login")
      # expect(page).to have_link("Logout")
    end
  end

  context "inappropriate login" do
    scenario 'with incorrect information the user remains at login' do
      User.create(first_name: "sal",
                  last_name: "espinosa",
                  email: "espinosa@aol.com",
                  cellphone: "3033333333",
                  password: "password",
                  password_confirmation: "password")

      visit login_path

      fill_in "session[email]", with: "espinosa@hotmail.com"
      fill_in "session[password]", with: "pass"
      click_button 'Login'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Incorrect entry')
    end
  end 
end
      
      
      