module ApplicationHelper

  def admin?
    current_user && current_user.admin?
  end

  def activated_user?
    current_user && current_user.activated_user?
  end

  def deactivated_user?
    current_user && current_user.deactivated_user?
  end
end
