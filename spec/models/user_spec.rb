require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should have_many(:folders) }
  it { should have_many(:uploads) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:cellphone) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:first_name) }
  it { should validate_uniqueness_of(:last_name) }
  it { should validate_uniqueness_of(:cellphone) }

  describe '#root_folder' do
    it 'should return the root_folder for a user' do
      user = create(:user)
      root = create(:folder, user: user)

      expect(user.root_folder).to eq(root)
    end
  end
end
