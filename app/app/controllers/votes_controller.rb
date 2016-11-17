class VotesController < ApplicationController


  def new
    @vote = Vote.new
  end
  def create
    @proposal1 = Proposal.find(params[:proposal_id])
    @proposal2 = Proposal.find(params[:proposal_id])
    @proposal3 = Proposal.find(params[:proposal_id])
    @vote1 = @proposal1.votes.create(vote_params)
    @vote2 = @proposal2.votes.create(vote_params)
    @vote3 = @proposal3.votes.create(vote_params)
    
    redirect_to proposals_path
  end

  private
  def vote_params
    params.require(:vote).permit(:proposal_id)
  end

end
