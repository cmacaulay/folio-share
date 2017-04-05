module PrivacySettings
  def parent_is_private?
    parent.is_private
  end

  def display_privacy
    privacy_enum[is_private]
  end

  def opposite_privacy
    privacy_enum[!is_private]
  end

  def change_privacy(setting = nil)
    setting = !is_private if setting.nil?
    if update_attributes!(is_private: setting)
      if self.class == Folder
        uploads.each { |upload| upload.change_privacy(setting) }
        subfolders.each { |subfolder| subfolder.change_privacy(setting) }
      end
      true
    else
      false
    end
  end

  def privacy_enum
    {true => "Private", false => "Public"}
  end
end