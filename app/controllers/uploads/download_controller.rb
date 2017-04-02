class Uploads::DownloadController < ApplicationController
  def index
    upload = Upload.find(params[:id])
    zip = ZipGenerator.new(upload)
    zip.download

    send_data(zip.data, type: "application/zip", filename: zip.file_name)
    zip.close
  end
end
