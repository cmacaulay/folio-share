require 'rails_helper'

describe "As a registered user, when I am logged in" do
  it "when I select logout my session ends" do
    user = create(:user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "password"
    click_button "Login"

    click_on "Logout"

    within(".alert-success") do
      expect(page).to have_content("Logged Out")
    end

    expect(page).to have_content("Login")
  end
end
