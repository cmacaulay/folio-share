class UploadsController < ApplicationController
  def show
    @upload = Upload.find(params[:id])
  end
end
