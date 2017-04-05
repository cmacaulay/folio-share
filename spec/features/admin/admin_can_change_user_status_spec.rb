require 'rails_helper'

describe "admin" do
  it "changes a registered user to deactivated and activated" do
    admin = create(:user)
    admin.roles.create(name: "admin")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_dashboard_path

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content(admin.username)

    click_on "deactivate"

    expect(admin.status).to eq("deactivated")
    expect(admin.status).to_not eq("activated")

    click_on "activate"

    expect(admin.status).to eq("activated")
    expect(admin.status).to_not eq("deactivated")
  end
end