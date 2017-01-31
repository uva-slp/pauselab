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
      expect(idea.iteration_id).to be iter.id
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
      attrs = i.attributes
      attrs[:description] = 'Hello, World!'
      put :update, params: {idea: i.attributes}
      i.reload
      expect(i.description).to be 'Hello, World!'

    end

  end

end
