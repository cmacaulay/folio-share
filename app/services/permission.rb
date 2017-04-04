class Permission
  extend Forwardable
  attr_reader :user, :controller, :action

  def_delegators :user, :admin?,
                        :activated_user?,
                        :deactivated_user?

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    case
    when user.admin?
      admin_permissions
    when user.deactivated_user?
      user_deactivated_permissions
    when user.activated_user?
      user_activated_permissions
    else
      guest_permissions
    end
  end

private
  def admin_permissions
    return true if controller == "sessions"
    return true if controller == "admin/dashboard" && action.in?("index")
    return true if controller == "users" && action.in?(%w(index edit update show))
    return true if controller == "folders" && action.in?(%(show new create))
    return true if controller == "uploads" && action.in?(%(new create show destroy))
  end

  def user_activated_permissions
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(index edit update show))
    return true if controller == "folders" && action.in?(%(show new create update destroy))
    return true if controller == "uploads" && action.in?(%(new create show destroy))
  end

  def user_deactivated_permissions
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(index edit update))
  end

  def guest_permissions
    return true if controller == "sessions"
    return true if controller == "users" && action.in?(%w(new create))
  end
end
