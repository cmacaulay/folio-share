class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      if current_user.admin?
        redirect_to admin_dashboard_path
      elsif current_user.deactivated?
        flash[:danger] = "Your privelages have been restricted. Please contact our adminstrator at admin@admin.com for more information."
        redirect_to folio_path        
    else
        flash[:success] = "#{user.first_name} Has Successfully Logged In"
        redirect_to folio_path
      end
    else
      flash[:error] = "Incorrect entry"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:success] = "Logged Out"
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
