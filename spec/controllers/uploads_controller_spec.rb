require "rails_helper"

RSpec.describe UploadsController, type: :controller do
  describe "GET #show" do
    xit "returns http success" do
      upload = create(:upload)
      get :show, params: { id: upload.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    xit "returns http success" do
      root = create(:upload)
      new_params = attributes_for(:upload, folder_id: root.id)
      post :create, params: new_params
      expect(response).to have_http_status(:success)
    end
  end
end
