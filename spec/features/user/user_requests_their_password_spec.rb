require 'rails_helper'

describe "user" do
  it "user receives sms with password" do
    user = User.create!(
           first_name: "Ames",
           last_name: "James",
           email: "ames@sample.com",
           cellphone: "720-770-2071",
           password: "password",   
           username: "AmesJames"    
    )

    visit login_path
    click_button("Forgot Password")

    expect(current_path).to eq(password_path)

    fill_in :email, with: user.email
    click_button("Send SMS")
 
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Password Sent")
  end

  it "user enters incorrect email" do 

    visit login_path
    click_button("Forgot Password")

    expect(current_path).to eq(password_path)

    fill_in :email, with: "fail@test.com"

    expect(current_path).to eq(password_path)
    expect(page).to have_content("Incorrect Email.Try Again.")
  end
end