require 'rails_helper'

RSpec.feature "User" do
  scenario "can comment on one of their uploaded files" do
    user = create(:user)
    root = user.folders.first
    upload = create(:upload, name: "Upload", folder: root)
    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(user)

    visit upload_path(upload)

    expect(page).to_not have_content("This upload rules!!!")

    fill_in "comment[content]", with: "This upload rules!!!"
    click_on "Submit"

    expect(page).to have_content("This upload rules!!!")
  end
end
