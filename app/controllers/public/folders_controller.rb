class Public::FoldersController < ApplicationController
  def show
    session[:current_folder_id] = params[:id]
  end
end
