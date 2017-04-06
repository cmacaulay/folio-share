module PathsHelper
  def folder_or_upload_path(child)
    if child.class == Upload
      upload_path(child)
    elsif child.class == Folder
      folder_path(child)
    end
  end

  def folder_or_folio_path(folder)
    if folder.root_folder?
      folio_path
    else
      folder_path(folder)
    end
  end

  def public_folder_or_upload_path(child)
    if child.class == Upload
      public_upload_path(child)
    elsif child.class == Folder
      public_folder_path(child)
    end
  end

  def back_path(default_path)
    if request.nil? || request.referer.nil?
      default_path
    else
      URI(request.referer)
    end
  end
end