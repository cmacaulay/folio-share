class Upload < ApplicationRecord
  has_attached_file :file
  belongs_to :folder

  alias_attribute :name, :file_file_name
  alias_attribute :content_type, :file_content_type
  alias_attribute :size, :file_file_size
end
