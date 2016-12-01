class VotesController < ApplicationController
  load_and_authorize_resource

  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
    @proposals = Proposal.where(status: :unchecked)
    if cookies[:voted] != nil
      flash[:notice] = 'You have already voted'
      redirect_to root_path
    end
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = 'Your vote has been received!'
      cookies[:voted] = { :value => "already voted", :expires => Time.now + 2628000 }
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
