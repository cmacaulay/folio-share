require "rails_helper"

RSpec.describe Folders::DownloadController, type: :controller do
  describe "GET #index" do
    xit "returns http success" do
      root = create(:folder)
      get :index, params: { id: root.id }

      expect(response).to have_http_status(:success)
    end
  end
end
