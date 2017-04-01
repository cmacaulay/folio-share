class Admin::DashboardController < ApplicationController
before_action :authorize!
  def dashboard 
    @uploads = Upload.all
  end

end