class Public::FoldersController < ApplicationController
  after_action :current_folder

  def show
    session[:current_folder_id] = params[:id]
  end
end
