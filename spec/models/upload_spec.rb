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

  describe "#folio_filepath" do
    it "upload is in the root folder" do
      user = create(:user)
      root = user.root_folder
      file = create(:upload, folder: root)

      expect(file.folio_filepath).to eq("#{root.name}/#{file.name}")
    end

    it "upload is in a subfolder" do
      user = create(:user)
      root = user.root_folder
      subf = create(:folder, parent: root)
      file = create(:upload, folder: subf)

      expect(file.folio_filepath).to eq("#{root.name}/#{subf.name}/#{file.name}")
    end
  end

  describe "#all_uploads" do
    it "returns itself in an array" do
      file = create(:upload)

      expect(file.all_uploads).to eq([file])
    end
  end

  describe "#local_filepath" do
    it "returns itself in an array" do
      file = create(:upload)
      actual_local_filepath = Rails.root
        .join(
          "tmp",
          "uploads",
          "upload",
          "attachment",
          "user_#{file.user.id}",
          "folder_#{file.folder.id}",
          "upload_#{file.id}",
          "#{file.name}"
        ).to_s

      expect(file.local_filepath).to eq(actual_local_filepath)
    end
  end
end
