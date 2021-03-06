require 'rails_helper'

describe "a registered user" do
  it "can delete a folder they own" do
    user    = create(:user)
    user = UserDecorator.new(user)
    user.roles.create(name: "activated")
    user.roles.create(name: "registered user")
    root = user.folders.first
    folder  = create(:folder, name: "Flowers", parent: user.root_folder)

    visit "/login"

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password

    click_button "Start Sharing"

    expect(current_path).to eq("/Folio")
    expect(page).to have_content("Flowers")

    click_button "Delete"

    expect(current_path).to eq("/Folio")
    expect(page).to_not have_content("Flowers")
    expect(page).to have_content("Folder deleted.")
  end
end
