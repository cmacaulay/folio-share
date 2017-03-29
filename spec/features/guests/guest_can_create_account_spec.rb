require 'rails_helper'

RSpec.feature "Guest" do
  scenario "can create an account" do

    visit new_user_path

    fill_in "user[first_name]", with: "Sal"
    fill_in "user[last_name]", with: "Espinosa"
    fill_in "user[email]", with: "sal@email.com"
    fill_in "user[cellphone]", with: "12345678910"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    expect { click_on "Create Account" }.to change(User, :count).by(1)

    expect(current_path).to eq("/home")
    expect(page).to have_content("Sal's Folio")
    # expect(page).to have_link("Logout")
    # expect(page).to have_link("Create New Folder")
    # expect(page).to_not have_link("Create Account")

  end
end
