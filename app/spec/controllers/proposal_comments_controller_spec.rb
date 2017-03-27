require 'rails_helper'

describe ProposalCommentsController, type: :controller do
  before :each do
    user = sign_in(create :admin)
    @proposal = create :proposal_with_comments
  end

  describe "when getting proposal comment index" do
    it "responds with success" do
      get :index, params: {proposal_id: @proposal.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "loads comments into @comments" do
      get :index, params: {proposal_id: @proposal.id}
      expect(assigns(:proposal_comments)).to match_array(@proposal.proposal_comments)
    end
    it "does not show for residents" do
      user = sign_in(create :resident)
      get :index, params: {proposal_id: @proposal.id}
      expect(response).to_not be_success
    end
  end

  describe "when creating a proposal comment" do
    it "saves the comment" do
      proposal = create :proposal
      proposal_comment = build :proposal_comment, proposal: proposal
      expect {
        post :create, params: {proposal_id: proposal.id, proposal_comment: proposal_comment.attributes}
      }.to change {ProposalComment.count}.by 1
    end
    it "responds with redirect" do
      proposal = create :proposal
      proposal_comment = build :proposal_comment, proposal: proposal
      post :create, params: {proposal_id: proposal.id, proposal_comment: proposal_comment.attributes}
      expect(response).to be_redirect
    end
    it "does not work for residents" do
      user = sign_in(create :resident)
      proposal = create :proposal
      proposal_comment = build :proposal_comment, proposal: proposal
      expect {
        post :create, params: {proposal_id: proposal.id, proposal_comment: proposal_comment.attributes}
      }.to_not change {ProposalComment.count}
    end
    it "flashes an error when comment isn't valid" do
      user = sign_in(create :admin)
      proposal = create :proposal
      proposal_comment = build :invalid_proposal_comment, proposal: proposal
      post :create, params: {proposal_id: proposal.id, proposal_comment: proposal_comment.attributes}
      expect(flash[:error]).to be_present
    end
  end

  describe "when updating a proposal comment" do
    it "can update the body" do
      proposal_comment = @proposal.proposal_comments.first
      put :update, params: {proposal_id: @proposal.id, id: proposal_comment, proposal_comment: {:body => 'Hello, World!'}}
      proposal_comment.reload
      expect(proposal_comment.body).to eq 'Hello, World!'
    end
    it "responds with redirect" do
      proposal_comment = @proposal.proposal_comments.first
      put :update, params: {proposal_id: @proposal.id, id: proposal_comment, proposal_comment: {:body => 'Hello, World!'}}
      expect(response).to be_redirect
    end

    it "does not work for residents" do
      user = sign_in (create :resident)
      proposal_comment = @proposal.proposal_comments.first
      put :update, params: {proposal_id: @proposal.id, id: proposal_comment, proposal_comment: {:body => 'Hello, World!'}}
      proposal_comment.reload
      expect(proposal_comment.body).to_not eq 'Hello, World!'
    end
    it "works for owner of comment" do
      steerer = create :steerer
      user = sign_in (steerer)
      proposal = create :proposal
      proposal_comment = create :proposal_comment, proposal: proposal, user: steerer
      put :update, params: {proposal_id: proposal.id, id: proposal_comment, proposal_comment: {:body => 'Hello, World!'}}
      proposal_comment.reload
      expect(proposal_comment.body).to eq 'Hello, World!'
    end
  end

  describe "when deleting a proposal comment" do
    it "removes the comment" do
      proposal_comment = @proposal.proposal_comments.first
      expect {
        delete :destroy, params: {proposal_id: @proposal.id, id: proposal_comment.id}
      }.to change {ProposalComment.count}.by -1
    end
    it "responds with redirect" do
      proposal_comment = @proposal.proposal_comments.first
      delete :destroy, params: {proposal_id: @proposal.id, id: proposal_comment.id}
      expect(response).to be_redirect
    end
    it "does not work for residents" do
      user = sign_in (create :resident)
      proposal_comment = @proposal.proposal_comments.first
      expect {
        delete :destroy, params: {proposal_id: @proposal.id, id: proposal_comment.id}
      }.to_not change {ProposalComment.count}
    end
    #it "it gives an error when unable to delete correctly" do
    #  proposal_comment = @proposal.proposal_comments.first
    #  allow(proposal_comment).to receive(:destroy).and_return(false)
    #  expect(flash[:error]).to be_present
    #end
    it "works for owner of comment" do
      steerer = create :steerer
      user = sign_in (steerer)
      proposal = create :proposal
      proposal_comment = create :proposal_comment, proposal: proposal, user: steerer
      expect {
        delete :destroy, params: {proposal_id: proposal.id, id: proposal_comment.id}
      }.to change {ProposalComment.count}.by -1
    end
  end

end
