require "rails_helper"

RSpec.describe Folder, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:parent) }
  it { should have_many(:subfolders) }
  it { should have_many(:uploads) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should define_enum_for(:status).with([:active, :inactive]) }

  describe "#ancestors" do
    it "returns a list of the ancestors of a folder" do
      user  = create(:user)
      root  = create(:folder, user: user)
      one   = create(:folder, user: user, parent: root)
      two   = create(:folder, user: user, parent: one)
      three = create(:folder, user: user, parent: two)

      expect(three.ancestors).to eq([root, one, two])
    end
  end

  describe "#all_uploads" do
    describe "returns a list of all uploads" do
      it "for the user if the root folder" do
        user  = create(:user)
        root  = create(:folder, user: user)
        one   = create(:folder, user: user, parent: root)
        file1 = create(:upload, folder: root)
        file2 = create(:upload, folder: one)

        expect(root.all_uploads).to eq([file1, file2])
      end

      it "in itself" do
        user  = create(:user)
        root  = create(:folder, user: user)
        one   = create(:folder, user: user, parent: root)
        file1 = create(:upload, folder: root)
        file2 = create(:upload, folder: one)

        expect(one.all_uploads).to eq([file2])
        expect(one.all_uploads).to_not eq([file1])
      end

      it "in itself and a subfolder" do
        user  = create(:user)
        root  = create(:folder, user: user)
        one   = create(:folder, user: user, parent: root)
        two   = create(:folder, user: user, parent: one)
        file1 = create(:upload, folder: root)
        file2 = create(:upload, folder: one)
        file3 = create(:upload, folder: two)

        expect(one.all_uploads).to eq([file2, file3])
        expect(one.all_uploads).to_not eq([file1])
      end

      it "in itself and multiple subfolders" do
        user  = create(:user)
        root  = create(:folder, user: user)
        one   = create(:folder, user: user, parent: root)
        two1  = create(:folder, user: user, parent: one)
        two2  = create(:folder, user: user, parent: one)
        file1 = create(:upload, folder: root)
        file2 = create(:upload, folder: one)
        file3 = create(:upload, folder: two1)
        file4 = create(:upload, folder: two2)

        expect(one.all_uploads).to eq([file2, file3, file4])
        expect(one.all_uploads).to_not eq([file1])
      end
    end
  end

  describe "#self.public_top_folders" do
    it "returns only the public folders where the parent folder is private" do
      user = create(:user)
      folio = user.root_folder

      private_folder = create(:folder, user: user, parent: folio)
      public_folder1 = create(:folder, is_private: false, user: user, parent: private_folder)
      public_folder2 = create(:folder, is_private: false, user: user, parent: private_folder)
      public_folder3 = create(:folder, is_private: false, user: user, parent: public_folder2)

      folders = Folder.public_top_folders

      expect(folders).to eq([public_folder1, public_folder2])
      expect(folders).to_not eq(public_folder3)
      expect(folders).to_not eq(private_folder)
      expect(folders).to_not eq(folio)
    end
  end





  context "PrivacySettings" do
    describe "#parent_is_private?" do
      it "returns true if the parent folder is private" do
        root = create(:folder, is_private: true)
        folder = create(:folder, parent: root)

        expect(folder.parent_is_private?).to eq(true)
      end

      it "returns false if the parent folder is not private (i.e. public)" do
        root = create(:folder, is_private: false)
        folder = create(:folder, parent: root)

        expect(folder.parent_is_private?).to eq(false)
      end
    end

    describe "#display_privacy" do
      it "returns 'Private' if the folder is private" do
        folder = create(:folder, is_private: true)

        expect(folder.display_privacy).to eq("Private")
      end

      it "returns 'Public' if the folder is not private" do
        folder = create(:folder, is_private: false)

        expect(folder.display_privacy).to eq("Public")
      end
    end

    describe "#opposite_privacy" do
      it "returns 'Private' if the folder is not private" do
        folder = create(:folder, is_private: false)

        expect(folder.opposite_privacy).to eq("Private")
      end

      it "returns 'Public' if the folder is private" do
        folder = create(:folder, is_private: true)

        expect(folder.opposite_privacy).to eq("Public")
      end
    end

    describe "#change_privacy" do
      it "changes the privacy setting from true to false" do
        folder = create(:folder, is_private: false)
        folder.change_privacy

        expect(folder.is_private).to eq(true)
      end

      it "changes the privacy setting from false to true" do
        folder = create(:folder, is_private: true)
        folder.change_privacy

        expect(folder.is_private).to eq(false)
      end

      it "changes the privacy setting for an upload in the folder" do
        folder = create(:folder, is_private: true)
        create(:upload, is_private: true, folder: folder)

        folder.change_privacy

        expect(folder.is_private).to eq(false)
        expect(folder.uploads.first.is_private).to eq(false)
      end

      it "changes the privacy setting for a subfolder" do
        folder = create(:folder, is_private: true)
        create(:folder, is_private: true, parent: folder)
        folder.change_privacy

        subfolder = folder.subfolders.first

        expect(folder.is_private).to eq(false)
        expect(subfolder.is_private).to eq(false)
      end

      it "changes the privacy setting for all children" do
        folder = create(:folder, is_private: true)
        subfolder = create(:folder, is_private: true, parent: folder)
        create(:upload, is_private: true, folder: folder)
        create(:upload, is_private: true, folder: subfolder)
        folder.change_privacy

        subfolder = folder.subfolders.first
        upload1 = folder.uploads.first
        upload2 = subfolder.uploads.first

        expect(folder.is_private).to eq(false)
        expect(subfolder.is_private).to eq(false)
        expect(upload1.is_private).to eq(false)
        expect(upload2.is_private).to eq(false)
      end
    end
  end
end
