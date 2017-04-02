require 'rails_helper'

describe "admin" do
  it "can delete any file" do 
    admin = create(:user)
    admin.roles.create(name: "admin")

    user_one = create(:user)
      root = user_one.folders.first
      upload_one = create(:upload, name: "Upload_one", folder: root)
 
      controller = ApplicationController
      allow_any_instance_of(controller).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path
      click_on "delete"
  
      expect(page).to_not have_content("Upload_one")
  end
end
