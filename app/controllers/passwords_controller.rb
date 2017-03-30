class PasswordsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def verify 
    #byebug
    @user = User.find_by(email: params[:email])
    if @user
      cellphone = @user.cellphone
      send_password(cellphone, @user)
      flash[:notice] = "Password Sent"
      redirect_to login_path
    else
      flash[:alert] = "Incorrect Email.Try Again."
      redirect_to password_path
    end
  end

  private
  def send_password(cellphone, user)
    TwilioService.new(cellphone, user).sms
  end
end