class Public::UploadsController < ApplicationController
  include PathsHelper

  def show
    @back_path = back_path(public_path)
    @upload = Upload.find(params[:id])
    if current_user
      @comment = current_user.comments.new()
    else
      @comment = Comment.new
    end
  end
end
