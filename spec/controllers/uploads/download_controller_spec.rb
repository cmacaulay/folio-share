require "rails_helper"

RSpec.describe Uploads::DownloadController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      upload = create(:upload)
      get :index, params: {id: upload.id}

      expect(response).to have_http_status(:success)
    end
  end

end
