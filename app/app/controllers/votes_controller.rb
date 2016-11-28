class VotesController < ApplicationController


  def new
    @vote = Vote.new
  end

  def create
    # render :plain => params.to_yaml
   
    @vote = Vote.new(vote_params)
    render :plain => @proposal.to_yaml
  end

  private
  def vote_params

    params.require(:vote).permit(:proposal_ids => [])
  end

end
