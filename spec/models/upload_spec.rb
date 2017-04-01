require 'rails_helper'

RSpec.describe Upload, type: :model do
  describe("#ancestors") do
    it "upload is in the root folder" do
      user = create(:user)
      root = user.root_folder
      file = create(:upload, folder: root_folder)
      binding.pry
      expect(file.ancestors).to eq([root])
    end

    it "upload is in a subfolder" do
      
    end
  end
end
