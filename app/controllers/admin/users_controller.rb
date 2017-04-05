class Admin::UsersController < ApplicationController

  def update
   @user = User.find_by(params[:username])
   if @user.activated_user?
     @user.deactivate
    else
      @user.deactivated_user?
      @user.activate
    end
    redirect_back(fallback_location: "admin/dashboard")
  end

  def show
  end
end
