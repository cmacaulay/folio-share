class Upload < ApplicationRecord
  belongs_to :folder
  has_many :comments

  def size
    "200TB"
  end

  def file_type
    "PDF"
  end
end
