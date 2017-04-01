class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @user ||= user_decorator if session[:user_id]
  end

  def user_decorator
    UserDecorator.new(User.find(session[:user_id]))
  end
end
