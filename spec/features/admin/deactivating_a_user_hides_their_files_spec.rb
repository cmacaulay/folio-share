require 'rails_helper'

describe "admin deactivates a user" do
  it "hides their files from the site" do
    admin = create(:user)
    admin.roles.create(name: "admin")

    user_one = create(:user)
    root = user_one.folders.first
    upload_one = create(:upload, name: "Upload_one", folder: root)
    upload_two = create(:upload, name: "Upload_two", folder: root)
    upload_three = create(:upload, name: "Upload_three", folder: root)
    user_one.deactivate 

    controller = ApplicationController
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    
    visit admin_dashboard_path

    expect(page).to_not have_content("Upload_one")
    expect(page).to_not have_content("Upload_two_two")
    expect(page).to_not have_content("Upload_three")
  end
end
    