class Admin::UsersController < ApplicationController

  def update
   @user = User.find_by(params[:username])
   if @user.activated_user?
     @user.deactivate
    elsif
      @user.deactivated_user?
      @user.activate
    else
    end
    redirect_back(fallback_location: "admin/dashboard")
  end

  def show
    @user = User.find(params[:id])
  end
end
