class Admin::UsersController < ApplicationController

  def update
   @user = User.find(params[:id])
   if @user.roles.where(name: "activated").exists?
     @user.deactivate
    elsif
      @user.roles.where(name: "deactivated").exists?
      @user.activate
    else
    end
    redirect_back(fallback_location: "admin/dashboard")
  end

  def show
    @user = User.find(params[:id])
  end
end