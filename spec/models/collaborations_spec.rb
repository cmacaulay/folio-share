require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  it {should belong_to(:user) }
  it {should belong_to(:folder) }
  # it {should validate_uniqueness_of(:user_id) }
  # it {should validate_uniqueness_of(:folder_id) }
end
