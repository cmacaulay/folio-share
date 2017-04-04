require 'rails_helper'

describe "a registered user" do
  it "can delete a file they own from root" do
    user = create(:user)
    user = UserDecorator.new(user)
    root = user.root_folder
    upload = create(:upload, folder: root)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/Folio"

    expect(page).to have_content(upload.name)

    click_on "Delete"

    expect(current_path).to eq("/Folio")
    expect(page).to_not have_content(upload.name)
    expect(page).to have_content("File successfully deleted.")
  end

  it "can delete a file they own from the file show page" do
    user = create(:user)
    user = UserDecorator.new(user)
    root = user.root_folder
    upload = create(:upload, folder: root)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/Folio"

    expect(page).to have_content(upload.name)

    click_on upload.name

    click_on "Delete File"

    expect(current_path).to eq("/Folio")
    expect(page).to_not have_content("Elephant")

    expect(page).to have_content("File successfully deleted.")
  end
end
