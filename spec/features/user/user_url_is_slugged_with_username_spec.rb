require 'rails_helper'

RSpec.feature "User" do
  scenario "sees url for user show page with their slugged username" do
    user = User.create(
      first_name: "Sal",
      last_name: "Espinosa",
      email: "espinosa1@example.com",
      cellphone: "3033333333",
      password: "password",
      username: "espinosa1"
    )

    controller = ApplicationController
    allow_any_instance_of(controller).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(current_path).to eq("/espinosa1")
  end
end
