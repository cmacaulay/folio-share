class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file

  process :save_content_type_and_size_in_model

  def save_content_type_and_size_in_model
    model.name = file.original_filename
    model.content_type = file.content_type if file.content_type
    model.size = file.size
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/user_#{model.user.id}/folder_#{model.folder.id}/upload_#{model.id}"
  end
end