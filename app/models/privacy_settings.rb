module PrivacySettings
  def display_privacy
    privacy_enum[is_private]
  end

  def opposite_privacy
    privacy_enum[!is_private]
  end

  def change_privacy
    update_attributes!(is_private: !is_private)
  end

  def privacy_enum
    {true => "Private", false => "Public"}
  end
end