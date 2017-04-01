class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.upload_id = params[:upload_id]
    @comment.user  = current_user
    @comment.save
    redirect_to upload_path(@comment.upload)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
