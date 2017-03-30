require 'rails_helper'

describe "As a registered user, when I am logged in" do
  it "when I select logout my session ends" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit home_path

    click_on "Logout"

    within(".alert-success") do
      expect(page).to have_content("Logged Out")
    end

    expect(page).to_not have_content("Logout")
    expect(page).to have_content("Login")
  end
end
