require 'rails_helper'

describe IdeasController, type: :controller do

  before :each do
    user = sign_in (create :user)
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
  end

  describe "when deleting an idea" do
    it "removes the idea" do
      i = create :idea
      expect {
        delete :destroy, params: {id: i.id}
      }.to change {Idea.count}.by -1
    end
  end

  describe "when updating an idea" do
    it "updates description" do
      i = create :idea
      put :update, params: {id: i, idea: {:description => 'Hello, World!'}}
      i.reload
      expect(i.description).to eq 'Hello, World!'
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
