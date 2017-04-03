RSpec.describe FoldersController, type: :controller do
  describe "GET #new" do
    xit "returns http success" do
      folder = create(:folder)
      get :new, params: { id: folder }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    xit "returns http success" do
      root = create(:folder)
      params = { params: attributes_for(:folder, parent_id: root.id, user_id: root.user.id) }
      post :create, params
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    xit "returns http success" do
      folder = create(:folder)
      get :show, params: { id: folder }
      expect(response).to have_http_status(:success)
    end
  end
end
