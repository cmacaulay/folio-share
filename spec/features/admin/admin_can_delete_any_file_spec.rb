require 'rails_helper'

describe "admin" do
  it "can delete any file" do
    admin = create(:user)
    admin.roles.create(name: "admin")

    user_one = create(:user)
      root = user_one.folders.first
      upload_one = create(:upload, name: "Upload_one", folder: root)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Upload_one")

      click_on "delete"

      expect(page).to_not have_content("Upload_one")
  end
end
