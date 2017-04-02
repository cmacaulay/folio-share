class Admin::DashboardController < ApplicationController
before_action :authorize!

  def dashboard 
    @uploads = Upload.all
    @users = User.all
  end
end