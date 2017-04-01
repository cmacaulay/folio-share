require "rails_helper"

describe "when a user clicks on their user name" do
  describe "they are redirected to their account page" do
    it "and they are able to see their user information" do
      user = create(:user, id: 1)
      controller = ApplicationController
      allow_any_instance_of(controller).to receive(:current_user).and_return(user)

      visit home_path

      click_on "#{user.full_name}"

      expect(current_path).to eq(account_details_path(user))

      within("h1") do
       expect(page).to have_content(user.full_name)
      end

      
    end
  end
end
