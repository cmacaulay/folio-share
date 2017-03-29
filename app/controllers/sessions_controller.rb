class SessionsController < ApplicationController
  def new
  end

  # def create
  #   user = User.find_by(email: session_params[:email])
  #   if user && user.authenticate(session_params[:password])
  #     session[:user_id] = user.id
  #     redirect_to dashboard_path
  #     flash[:success] = "Successfully Created Account as #{user.username}"
  #   else
  #     flash[:error] = "Incorrect entry"
  #     redirect_to login_path
  #   end
  # end
end
