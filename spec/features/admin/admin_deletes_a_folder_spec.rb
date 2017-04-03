require 'rails_helper'

describe "admin" do
  it "deletes a folder" do
    admin = create(:user)
    admin.roles.create(name: "admin")

    user_one = create(:user)
    user_one.roles.create(name: "activated")
    root = user_one.folders.first
    folder_one = create(:folder, name:"Folder_one", user: user_one, parent: root)

    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_on "delete"

    expect(page).to_not have_content("Folder_one")
  end
end