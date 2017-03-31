class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file

  process :save_content_type_and_size_in_model

  def save_content_type_and_size_in_model
    model.name = file.original_filename
    model.content_type = file.content_type if file.content_type
    model.size = file.size
  end

  def store_dir
    model_class = model.class.to_s.underscore
    user_id = "user_#{model.user.id}"
    folder_id = "folder_#{model.folder.id}"
    upload_id = "upload_#{model.id}"
    "uploads/#{model_class}/#{mounted_as}/#{user_id}/#{folder_id}/#{upload_id}"
  end
end