require 'rails_helper'

describe IdeasController, type: :controller do

  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when getting idea index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end
    it "loads all ideas into @ideas" do
      idea = create_list(:idea, 10, iteration: @iteration)
      get :index
      expect(assigns(:ideas)).to match_array(idea)
    end
    it "does not show unapproved ideas to residents" do
      user = sign_in (create :resident)
      idea1 = create_list(:idea, 3, iteration: @iteration, status: :approved)
      idea2 = create_list(:idea, 3, iteration: @iteration, status: :unchecked)
      get :index
      expect(assigns(:ideas)).to match_array(idea1)
    end
  end

  describe "when creating an idea" do
    it "saves the idea" do
      i = build :idea
      expect {
        post :create, params: {idea: i.attributes}
      }.to change { Idea.count }.by 1
    end
    it "associates new idea with current iteration" do
      iter = create :iteration
      idea = build :idea, :iteration => nil
      post :create, params: {idea: idea.attributes}
      idea = Idea.last
      expect(idea.iteration_id).to eq iter.id
    end
    it "responds with redirect" do
      i = build :idea
      post :create, params: {idea: i.attributes}
      expect(response).to be_redirect
    end
  end

  describe "when deleting an idea" do
    it "removes the idea" do
      i = create :idea
      expect {
        delete :destroy, params: {id: i.id}
      }.to change {Idea.count}.by -1
    end
    it "responds with redirect" do
      i = create :idea
      delete :destroy, params: {id: i.id}
      expect(response).to be_redirect
    end
  end

  describe "when updating an idea" do
    it "updates description" do
      i = create :idea
      put :update, params: {id: i, idea: {:description => 'Hello, World!'}}
      i.reload
      expect(i.description).to eq 'Hello, World!'
    end
    it "responds with redirect" do
      i = create :idea
      put :update, params: {id: i, idea: {:description => 'Hello, World!'}}
      expect(response).to be_redirect
    end
    # TODO: validation checks
  end

  describe "when liking an idea" do
    it "updates like count" do
      i = create :idea
      expect {
        get :like, params: {id: i}
      }.to change {Idea.find(i.id).likes}.by 1
    end
    it "updates cookie" do
      i = create :idea
      get :like, params: {id: i}
      expect(cookies[:likes]).to eq "[#{i.id}]"
    end
    it "likes multiple ideas" do
      cookies[:likes] = "[12]"
      i = create :idea
      get :like, params: {id: i}
      expect(cookies[:likes]).to eq "[12,#{i.id}]"
    end
  end

  describe "when unliking an idea" do
    it "updates like count" do
      i = create :idea
      get :like, params: {id: i}
      expect {
        get :like, params: {id: i}
      }.to change {Idea.find(i.id).likes}.by -1
    end
    it "updates cookie" do
      i = create :idea
      get :like, params: {id: i}
      get :like, params: {id: i}
      expect(cookies[:likes]).to eq "[]"
    end
  end

end
