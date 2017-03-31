require 'rails_helper'

describe "user" do
  it "user receives sms with password reset code" do
    user = User.create!(
           first_name: "Ames",
           last_name: "James",
           email: "ames@sample.com",
           cellphone: "720-770-2071",
           password: "password",   
           username: "AmesJames",
           reset_token: ""    
    )

    visit login_path
    click_link("Forgot Password")

    expect(current_path).to eq(password_path)
    
    fill_in :email, with: user.email
    click_button("Send SMS")
    user.create_reset_digest

    expect(current_path).to eq(reset_password_path)
    expect(page).to have_content("SMS with reset code sent.")

    fill_in :reset_token, with: user.reset_token
    fill_in :email, with: user.email
    fill_in :password, with: "pass"
    fill_in :password_confirmation, with: "pass"
    click_button("Reset Password")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Password Successfully Updated!")
  end

  it "user enters incorrect email" do 

    visit login_path
    click_link("Forgot Password")

    expect(current_path).to eq(password_path)

    fill_in :email, with: "fail@test.com"
    click_button("Send SMS")
    
    expect(current_path).to eq(password_path)
    expect(page).to have_content("Incorrect Email.Try Again.")
  end
end