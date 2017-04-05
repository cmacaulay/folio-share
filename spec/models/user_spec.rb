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

  describe "user" do 
    it "should verify if user is admin" do
      user = create(:user)
      user.roles.create(name: "admin")
      user.admin?

      expect(user.roles.take.name).to eq("admin")
    end
  end

  describe "user" do 
    it "should verify if user is activated" do
      user = create(:user)
      user.roles.create(name: "activated")
      user.activated_user?

      expect(user.roles.take.name).to eq("activated")
    end
  end

  describe "user" do 
    it "should verify if user is deactivated" do
      user = create(:user)
      user.roles.create(name: "deactivated")
      user.deactivated_user?

      expect(user.roles.take.name).to eq("deactivated")
    end
  end

  describe "user" do 
    it "should locate or create a registered user role" do
      user = create(:user)
      user.registered_user

      expect(user.roles.first.name).to eq("registered user")
    end
  end

  describe "user" do 
    it "should activate a deactivated user" do
      user_three = create(:user)
      user_three.deactivate
      user_three.activate

      expect(user_three.status).to eq("activated")
    end
  end

    describe "user" do 
    it "should deactivate an activated user" do
      user_four = create(:user)
      user_four.activate
      user_four.deactivate

      expect(user_four.status).to eq("deactivated")
    end
  end
end