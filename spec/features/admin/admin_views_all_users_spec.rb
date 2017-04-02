require 'rails_helper'

describe "admin" do
  it "views a list of all users" do 
    admin = create(:user)
    admin.roles.create(name: "admin")

    user_one =create(:user)
    user_one.roles.create(name: "registered user")    
    user_two =create(:user)
    user_two.roles.create(name: "registered user")
    user_three =create(:user)
    user_three.roles.create(name: "registered user")

    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(admin)
    visit admin_dashboard_path

    expect(page).to have_content(user_one.username)
    expect(page).to have_content(user_two.username)
    expect(page).to have_content(user_three.username)
  end

  
end
    
    