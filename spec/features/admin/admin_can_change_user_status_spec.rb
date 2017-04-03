require 'rails_helper'

describe "admin" do 
  it "changes a registered user to deactivated and activated" do 
    admin = create(:user)
    admin.roles.create(name: "admin")

    user_one =create(:user)
    user_one.roles.create(name: "registered user") 
    user_one.roles.create(name: "activated")
    Role.create(name: "deactivated")

    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(admin)
    visit admin_dashboard_path

    click_on "deactivate"

    expect(user_one.roles.take.name).to eq("deactivated")
    expect(user_one.roles.take.name).to_not eq("activated")

    click_on "activate"

    expect(user_one.roles.take.name).to eq("activated")
    expect(user_one.roles.take.name).to_not eq("deactivated")
    
  end
end