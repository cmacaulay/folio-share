class Permission
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
  
    case
    when user.admin? 
      admin_permissions
    else
    end
  end

  def admin_permissions
    return true if controller == "sessions"
    return true if controller == "admin/dashboard" && action.in?("dashboard")
  end
end