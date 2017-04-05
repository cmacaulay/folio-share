require "rails_helper"

RSpec.describe Upload, type: :model do
  it { should belong_to(:folder) }
  it { should have_many(:comments) }
  it { should delegate_method(:user).to(:folder)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:content_type) }
  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:folder_id) }
  it { should validate_presence_of(:attachment) }

  describe("alias_attributes") do
    it "has an owner alias for user" do
      upload = create(:upload)

      expect(upload.user).to eq(upload.owner)
      expect(upload.owner).to eq(upload.user)
    end

    it "has a parent alias for folder" do
      upload = create(:upload)

      expect(upload.folder).to eq(upload.parent)
      expect(upload.parent).to eq(upload.folder)
    end
  end

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

      expect(file.directory).to eq(root.name)
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
        file.name
      ).to_s

      expect(file.local_filepath).to eq(actual_local_filepath)
    end
  end

  describe "#self.public_uploads" do
    it "returns all uploads that are not private (i.e. public)" do
      user = create(:user)
      folio = user.root_folder
      subfolder = create(:folder, user: user, parent: folio, is_private: false)
      upload_private = create(:upload, folder: folio)
      upload_public1 = create(:upload, folder: folio, is_private: false)
      upload_public2 = create(:upload, folder: subfolder, is_private: false)

      expect(Upload.public_uploads.include?(upload_public1)).to eq(true)
      expect(Upload.public_uploads.include?(upload_public2)).to eq(true)
      expect(Upload.public_uploads.include?(upload_private)).to eq(false)
    end
  end

  context "PrivacySettings" do
    describe "#parent_is_private?" do
      it "returns true if the folder is private" do
        folder = create(:folder, is_private: true)
        upload = create(:upload, folder: folder)

        expect(upload.parent_is_private?).to eq(true)
      end

      it "returns false if the folder is not private (i.e. public)" do
        folder = create(:folder, is_private: false)
        upload = create(:upload, folder: folder)

        expect(upload.parent_is_private?).to eq(false)
      end
    end

    describe "#display_privacy" do
      it "returns 'Private' if the upload is private" do
        upload = create(:upload, is_private: true)

        expect(upload.display_privacy).to eq("Private")
      end

      it "returns 'Public' if the upload is not private" do
        upload = create(:upload, is_private: false)

        expect(upload.display_privacy).to eq("Public")
      end
    end

    describe "#opposite_privacy" do
      it "returns 'Private' if the upload is not private" do
        upload = create(:upload, is_private: false)

        expect(upload.opposite_privacy).to eq("Private")
      end

      it "returns 'Public' if the folder is private" do
        upload = create(:upload, is_private: true)

        expect(upload.opposite_privacy).to eq("Public")
      end
    end

    describe "#change_privacy" do
      it "changes the privacy setting from true to false" do
        upload = create(:upload, is_private: false)
        upload.change_privacy

        expect(upload.is_private).to eq(true)
      end

      it "changes the privacy setting from false to true" do
        upload = create(:upload, is_private: true)
        upload.change_privacy

        expect(upload.is_private).to eq(false)
      end
    end
  end
end
