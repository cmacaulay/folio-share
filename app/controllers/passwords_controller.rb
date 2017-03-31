class PasswordsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  end
 
  def create 
    @user = User.find_by(email: params[:email])
     if @user
       @user.create_reset_digest
       cellphone = @user.cellphone
       send_password(cellphone, @user)
       flash[:notice] = "SMS with reset code sent."
       redirect_to reset_password_path
     else
       flash[:alert] = "Incorrect Email.Try Again."
       redirect_to password_path
     end
   end
 
   def edit 
   end
 
   def update
    @user = User.find_by(reset_token: params[:reset_token], email: params[:email])
    if @user
      @user.update(password: params[:password])
      flash[:success] = "Password Successfully Updated!"
      redirect_to login_path
    else
      flash[:alert] = "Your Credentials Are Incorrect. Try Again."
      redirect_to password_path
    end  
  end

  private
  def send_password(cellphone, user)
    TwilioService.new(cellphone, user).sms
  end
end 