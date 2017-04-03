class UsersController < ApplicationController
before_action :authorize!, only: [:show, :index, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.registered_user
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:danger] = "Please fill in every field to create an account."
      render :new
    end
  end

  def show
  end

  def index
    @current_folder = current_user.root_folder
    @folder = Folder.new
    @file = Upload.new
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
