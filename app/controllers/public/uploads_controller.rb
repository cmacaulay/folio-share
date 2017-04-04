class Public::UploadsController < ApplicationController
  def show
    @upload = Upload.find(params[:id])
    if current_user
      @comment = current_user.comments.new()
    else
      @comment = Comment.new
    end
  end
end
