require 'rails_helper'

describe "when an admin logs in" do
  it "is redirected to the admin dashboard page" do
    admin = User.create(
          first_name: "Admin",
          last_name: "Admin",
          email: "admin@example.com",
          cellphone: "3033333333",
          password: "password",
          username: "admin_one",
          reset_token: ""
          )
    admin.roles.create(name: "admin")
#byebug
    visit login_path

    fill_in "session[email]", with: admin.email
    fill_in "session[password]", with: admin.password

    click_button "Login"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Welcome Admin")
  end
end
    