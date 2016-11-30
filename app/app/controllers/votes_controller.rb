class VotesController < ApplicationController
  load_and_authorize_resource

  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
    @proposals = Proposal.where(status: :unchecked)
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = 'You just voted'
      redirect_to root_path
    else
      render 'new'
    end
    # render :plain => params.to_yaml
  end



  private
  def vote_params

    params.require(:vote).permit(:proposal_ids => [])
  end

end
