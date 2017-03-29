class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    folders = Folder.new
    if @user.save
      session[:user_id] = @user.id
      @user.folders.create!(name: "#{@user.first_name}'s folder")
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cellphone, :password)
  end
end