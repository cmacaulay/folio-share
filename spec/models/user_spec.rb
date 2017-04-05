require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should have_many(:folders) }
  it { should have_many(:uploads) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:cellphone) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:cellphone) }

  describe "#root_folder" do
    it "should return the root_folder for a user" do
      user = create(:user)
      root = user.folders.first

      expect(user.root_folder).to eq(root)
    end
  end

  describe "create_reset_digest" do
    it "should assing a random token" do
      user = create(:user)
      user.create_reset_digest

      expect(user.reset_token).to_not be(nil)
    end
  end

  describe "verify user role" do
    it "should verify if user is admin" do
      user = create(:user)
      user.roles.create(name: "admin")

      expect(user.admin?).to eq(true)
    end

    it "should verify if user is activated" do
      user = create(:user)
      user.roles.create(name: "activated")

      expect(user.activated_user?).to eq(true)
    end

    it "should verify if user is deactivated" do
      user = create(:user)
      user.roles.create(name: "deactivated")

      expect(user.deactivated_user?).to eq(true)
    end

    it "should locate or create a registered user role" do
      user = create(:user)
      user.registered_user
      registered_role = Role.find_by(name: "registered user")

      expect(user.roles.include?(registered_role)).to eq(true)
    end

    it "should locate or create an activated role" do
      user_one = create(:user)
      user_one.activated

      expect(user_one.activated_user?).to eq(true)
    end

    it "should locate or create a deactivated user role" do
      user_two = create(:user)
      user_two.deactivated

      expect(user_two.deactivated_user?).to eq(true)
    end

    it "should activate a deactivated user" do
      user_three = create(:user)
      user_three.deactivate
      user_three.activate

      expect(user_three.activated_user?).to eq(true)
    end

    it "should deactivate an activated user" do
      user_four = create(:user)
      user_four.activate
      user_four.deactivate

      expect(user_four.deactivated_user?).to eq(true)
    end
  end
end