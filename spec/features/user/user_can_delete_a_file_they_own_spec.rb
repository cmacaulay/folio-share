require 'rails_helper'

describe "a registered user" do
  it "can delete a file they own file" do
    user    = create(:user)
    upload  = create(:upload, name: "Flowers", folder: user.root_folder)

    visit "/login"

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password

    click_button "Start Sharing"

    expect(current_path).to eq("/home")
    expect(page).to have_content("Flowers")

    click_on "Delete"

    expect(current_path).to eq("/home")
    expect(page).to_not have_content("Flowers")
    expect(page).to have_content("File deleted.")
  end
end
