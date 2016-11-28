class VotesController < ApplicationController

  def index
    @votes = Vote.all
  end
    
  def new
    @vote = Vote.new
  end

  def create

    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = 'You just voted'
      redirect_to root_path
    else
      render 'new'
    end
  end

  

  private
  def vote_params

    params.require(:vote).permit(:proposal_ids => [])
  end

end
