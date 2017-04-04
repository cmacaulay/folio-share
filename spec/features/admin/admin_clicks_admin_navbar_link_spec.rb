require 'rails_helper'

feature "admin visit user index(show) page" do
  describe "clicks admin link" do
    it "redirects to admin dashboard" do
      admin = create(:user)
      admin.roles.create(name: "admin")

      controller = ApplicationController
      allow_any_instance_of(controller).to receive(:current_user).and_return(admin)

      visit folio_path

      click_on "Admin"
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Admin Dashboard")
    end
  end
end