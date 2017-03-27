require 'rails_helper'

describe VotesController, type: :controller do
  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration, status: :voting
  end

  describe "when getting votes index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "loads all votes into @votes" do
      votes = create_list(:vote, 10, iteration: @iteration)
      get :index
      expect(assigns(:votes)).to match_array(votes)
    end
    it "does not show for residents" do
      sign_in (create :resident)
      get :index
      expect(response).to_not be_success
    end
  end

  describe "when creating a vote" do
    it "saves new vote" do
      vote = build :vote, iteration: @iteration
      expect {
        # NOTE for some reason the vote.attributes does not contain proposal associations
        post :create, params: {vote: vote.attributes.merge({proposal_ids: vote.proposal_ids})}
      }.to change {Vote.count}.by 1
    end
    it "associates new vote with current iteration" do
      iter = create :iteration
      vote = build :vote, :iteration => nil
      post :create, params: {vote: vote.attributes.merge({proposal_ids: vote.proposal_ids})}
      vote = Vote.last
      expect(vote.iteration_id).to eq iter.id
    end
    it "responds with redirect" do
      vote = build :vote
      post :create, params: {vote: vote.attributes.merge({proposal_ids: vote.proposal_ids})}
      expect(response).to be_redirect
    end
    #it "gives an error when a required field isn't present" do
    #  vote = build :invalid_vote
    #  post :create, params: {vote: vote.attributes}
    #  expect(response).to render_template(:new)
    #end
  end
end
