require "rails_helper"

feature "Guest" do
  scenario "can create an account" do
    visit new_user_path

    fill_in "user[first_name]", with: "Sal"
    fill_in "user[last_name]", with: "Espinosa"
    fill_in "user[email]", with: "sal@email.com"
    fill_in "user[cellphone]", with: "1234567890"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    fill_in "user[username]", with: "espinosa3"

    expect { click_on "Create Folio" }.to change(User, :count).by(1)

    expect(current_path).to eq(folio_path)
    expect(page).to have_content("Sal's Folio")
    within("div.breadcrumbs") do
      expect(page).to have_content("Folio")
    end
    expect(page).to have_link("Logout")
    expect(page).to have_link("Create New Folder")
    expect(page).to_not have_link("Signup")
  end

  it "can't create an account without all user information" do
    visit new_user_path

    fill_in "user[first_name]", with: "Sal"
    fill_in "user[last_name]", with: "Espinosa"
    fill_in "user[email]", with: "sal@email.com"
    fill_in "user[cellphone]", with: "1234567890"

    click_on "Create Folio"

    within(".alert-danger") do
      expected = "Please fill in every field to create an account."
      expect(page).to have_content(expected)
    end
    expect(page).to_not have_content("Sal's Folio")
    expect(page).to_not have_link("Logout")
    expect(page).to_not have_link("Create New Folder")
    expect(page).to have_link("Signup")
    # expect(current_path).to eq(new_user_path)
  end
end
