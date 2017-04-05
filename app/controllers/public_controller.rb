class PublicController < ApplicationController
  def index
    # byebug
    @folders = Folder.public_top_folders
    @uploads = Upload.public_uploads
  end
end
