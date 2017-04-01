require "rails_helper"

  describe "admin" do 
    it "views a list of all files" do 
      admin = create(:user)
      admin.roles.create(name: "admin")

      user_one = create(:user)
      root = user_one.folders.first
      upload_one = create(:upload, name: "Upload_one", folder: root)
      upload_two = create(:upload, name: "Upload_two", folder: root)
      upload_three = create(:upload, name: "Upload_three", folder: root)
      
      user_two = create(:user)
      root = user_two.folders.first
      upload_two_one = create(:upload, name: "Upload_two_one", folder: root)
      upload_two_two = create(:upload, name: "Upload_two_two", folder: root)
      upload_two_three = create(:upload, name: "Upload_two_three", folder: root)

      controller = ApplicationController
      allow_any_instance_of(controller).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_content("Upload_one")
      expect(page).to have_content("Upload_two_two")
      expect(page).to have_content("Upload_three")
    end
  end      
      