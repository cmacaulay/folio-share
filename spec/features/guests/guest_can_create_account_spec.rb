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

    expect { click_on "Start Sharing" }.to change(User, :count).by(1)

    expect(current_path).to eq("/home")
    expect(page).to have_content("Sal's Folio")
    within("div.breadcrumbs") do
      expect(page).to have_content("Folio")
    end
    expect(page).to have_link("Logout")
    expect(page).to have_link("Create New Folder")
    expect(page).to_not have_link("Signup")
  end

  it "can't create an account without all user information or duplicate information" do
    user = User.create!(
      first_name: "Ames",
      last_name: "James",
      email: "ames@sample.com",
      cellphone: "17207702071",
      password: "password",
      username: "AmesJames",
      reset_token: ""
    )

    visit new_user_path

    fill_in "user[first_name]", with: "Sal"
    fill_in "user[last_name]", with: "Espinosa"
    fill_in "user[email]", with: "ames@sample.com"
    fill_in "user[cellphone]", with: "17207702071"
    fill_in "user[username]", with: "AmesJames"

    click_on "Start Sharing"

    expect(page).to have_content("Email has already been taken")
    expect(page).to have_content("Username has already been taken")
    expect(page).to have_content("Cellphone has already been taken")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_link("Signup")

    expect(page).to_not have_content("Sal's Folio")
    expect(page).to_not have_link("Logout")
    expect(page).to_not have_link("Create New Folder")

  end
end
