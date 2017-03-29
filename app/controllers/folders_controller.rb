class FoldersController < ApplicationController
  def show
    @folder = Folder.find(params[:id])
  end
end
