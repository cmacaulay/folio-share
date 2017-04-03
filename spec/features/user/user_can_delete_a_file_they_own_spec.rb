require 'rails_helper'

describe "a registered user" do
  it "can delete a file they own from root" do
    user    = create(:user)
    root = user.folders.first
    upload = create(:upload, name: "Elephant", folder: root, attachment: "/spec/fixtures/elephant.jpg")
    user.roles.create(name: "activated")
    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(user)

    visit "/home"

    expect(page).to have_content("Elephant")

    click_on "Delete"

    expect(current_path).to eq("/home")
    expect(page).to_not have_content("Elephant")
    expect(page).to have_content("File deleted.")
  end

  it "can delete a file they own from the file show page" do
    user    = create(:user)
    root = user.folders.first
    upload = create(:upload, name: "Elephant", folder: root, attachment: "/spec/fixtures/elephant.jpg")
    user.roles.create(name: "activated")
    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(user)

    visit "/home"

    expect(page).to have_content("Elephant")

    click_on "Elephant"

    click_on "Delete File"

    expect(current_path).to eq("/home")
    expect(page).to_not have_content("Elephant")
    expect(page).to have_content("File deleted.")
  end
end
