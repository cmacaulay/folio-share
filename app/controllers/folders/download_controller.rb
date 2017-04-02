class Folders::DownloadController < ApplicationController
  def index
    folder = Folder.find(params[:id])
    zip = ZipGenerator.new(folder)
    zip.download

    send_data(zip.data, type: "application/zip", filename: zip.file_name)
    zip.close
  end
end
