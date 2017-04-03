class Folders::DownloadController < ApplicationController
  def index
    folder = Folder.find(params[:id])
    zip = ZipGenerator.new(folder)
    result = zip.download

    if result == :success
      send_data(zip.data, type: "application/zip", filename: zip.file_name)
    elsif result == :failure
      flash[:danger] = "You cannot download an empty folder."
      redirect_to request.env["HTTP_REFERER"]
    end

    zip.close
  end
end
