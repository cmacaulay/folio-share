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
end
