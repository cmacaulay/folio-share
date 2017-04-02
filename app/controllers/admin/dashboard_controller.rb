class Admin::DashboardController < ApplicationController
before_action :authorize!

  def dashboard 
    #byebug
    @uploads = Upload.all
    @users = User.all
  end
end