class PublicController < ApplicationController
  def index
    @folders = Folder.public_top_folders
    @uploads = Upload.public_uploads
  end
end
