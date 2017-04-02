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
        two_A = create(:folder, user: user, parent: one)
        two_B = create(:folder, user: user, parent: one)
        file1 = create(:upload, folder: root)
        file2 = create(:upload, folder: one)
        file3 = create(:upload, folder: two_A)
        file4 = create(:upload, folder: two_B)

        expect(one.all_uploads).to eq([file2, file3, file4])
        expect(one.all_uploads).to_not eq([file1])
      end
    end
  end
end
