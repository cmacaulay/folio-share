require 'rails_helper'

describe "as user when I visit the public folders" do
  it "i do not see deactivated users folders" do
    deactivated_user = create(:user)

    deactivated_user = create(:user)
    folder_one = deactivated_user.folders.create(name:"Test_One")
    folder_two = deactivated_user.folders.create(name:"Test_Two")
    folder_three = deactivated_user.folders.create(name:"Test_Three")
    
    folder_one.change_privacy
    folder_two.change_privacy
    folder_two.change_privacy
     byebug
    visit public_path
    #save_and_open_page

    expect(page).to have_content("Test_One")
    expect(page).to have_content("Test_Two")
    expect(page).to have_content("Test_Three")  
  end
end