require "rails_helper"

feature "User can change the privacy settings" do
  describe "on a folder they own" do
    it "from private to public" do
      folder = create(:folder, is_private: true)
      user = folder.owner
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit folio_path

      binding.pry

      click_on "Make Public"

      binding.pry

      expect(folder.is_private).to eq(false)
      expect(page).to have_content("Make Private")
      within(:css, "i.material-icons") do
        expect(page).to have_content("visibility")
      end
    end

    it "from public to private" do
      
    end
  end
end