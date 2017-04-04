class Admin::DashboardController < ApplicationController
before_action :authorize!

  def index
    @uploads = Upload.all
    @users = User.all
  end
end