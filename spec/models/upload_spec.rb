require 'rails_helper'

RSpec.describe Upload, type: :model do
  describe("#ancestors") do
    it "upload is in the root folder" do
      user = create(:user)
      root = user.root_folder
      file = create(:upload, folder: root)

      expect(file.ancestors).to eq([root])
    end

    it "upload is in a subfolder" do
      user = create(:user)
      root = user.root_folder
      subf = create(:folder, parent: root)
      file = create(:upload, folder: subf)

      expect(file.ancestors).to eq([root, subf])
    end
  end

  describe "#directory" do
    it "upload is in the root folder" do
      user = create(:user)
      root = user.root_folder
      file = create(:upload, folder: root)

      expect(file.directory).to eq("#{root.name}")
    end

    it "upload is in a subfolder" do
      user = create(:user)
      root = user.root_folder
      subf = create(:folder, parent: root)
      file = create(:upload, folder: subf)

      expect(file.directory).to eq("#{root.name}/#{subf.name}")
    end
  end
end
