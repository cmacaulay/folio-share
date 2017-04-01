class Admin::DashboardController < ApplicationController
before_action :authorize!
  def dashboard 
  
    @user =current_user
  end

end