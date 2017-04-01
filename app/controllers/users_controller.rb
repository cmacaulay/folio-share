class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:danger] = "Please fill in every field to create an account."
      render :new
    end
  end

  def show
    @current_folder = current_user.root_folder
    @folder = Folder.new
    @file = Upload.new
  end

  def show
    @user = User.find_by(slug: params[:username])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    @user.update_attribute(:password, params[:user][:new_password])
    flash[:success] = "Account Successfully Updated!"
    redirect_to home_path
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:username, :first_name, :last_name, :email, :cellphone, :password)
  end
end
