class VotesController < ApplicationController


  def new
    @vote = Vote.new
  end
  def create
    #puts "check check"
    #puts :proposal1
    #@proposal1 = Proposal.find(params[:proposal1])
    #@proposal2 = Proposal.find(params[:proposal2])
    #@proposal3 = Proposal.find(params[:proposal3])
    #puts @proposal1
    #puts @proposal2
    #puts @proposal3
    @vote = Vote.new(vote_params)
    
    redirect_to proposals_path
  end

  private
  def vote_params
    params.require(:vote).permit(:proposal_ids =>[])
  end

end
