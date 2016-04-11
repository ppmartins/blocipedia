require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { User.create!(email: "user@blocipedia.com", password: "password") }
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", public: true, user: user) }


  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST create" do
    it "increases the number of Wiki by 1" do
      expect{post :create, wiki: {title: "New Wiki Title", body: "New Wiki Body", user: user}}.to change(Wiki,:count).by(1)
    end

    it "assigns the new wiki to @wiki" do
      post :create, wiki: {title: "New Wiki Title", body: "New Wiki Body", user: user}
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new wiki" do
      post :create, wiki: {title: "New Wiki Title", body: "New Wiki Body", user: user}
      expect(response).to redirect_to Wiki.last
    end
  end


  describe "GET show" do
    it "returns http success" do
      get :show, {id: user_id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: user_id}
      expect(response).to render_template :show
    end

    it "assigns user_wikis to @wiki" do
      get :show, {id: user_id}
      expect(assigns(:wiki)).to eq(user_wikis)
    end
  end
end
