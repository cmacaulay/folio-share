class Upload < ApplicationRecord
  belongs_to :folder

  def size
    '200TB'
  end

  def file_type
    'PDF'
  end
end
