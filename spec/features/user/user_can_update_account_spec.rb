require "rails_helper"

describe "As a registered user, when I am logged in" do
  it "I am able to update my account information" do
    user = create(:user, id: 1, first_name: "Harry")
    user = UserDecorator.new(user)
    controller = ApplicationController

    allow_any_instance_of(controller).to receive(:current_user).and_return(user)

    visit folio_path

    click_on "#{user.full_name}"
    click_on "Edit Account"
    expect(current_path).to eq(edit_user_path(user))

    fill_in "user[first_name]", with: "Purple"
    fill_in "user[last_name]", with: "Unicorn"
    fill_in "user[email]", with: "iama@unicorn.net"
    fill_in "user[cellphone]", with: "12345678910"

    click_on "Update"

    expect(current_path).to eq(folio_path)

    within(".alert-success") do
      expect(page).to have_content("Account Successfully Updated!")
    end

    expect(page).to have_content("Purple")
    within("h1") do
      expect(page).to_not have_content("Harry")
    end
  end
end
