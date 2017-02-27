class VotesController < ApplicationController
  load_and_authorize_resource

  def index
    @votes = @votes.where(:iteration_id => Iteration.get_current.id)
  end

  def new
    @vote = Vote.new
    @proposals = Proposal.where(status: :unchecked)
    if cookies[:voted] != nil
      flash[:notice] = 'You have already voted'
      redirect_to proposals_path  # TODO if in voting phase, going to root results in infinite redirect
    end
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.iteration_id = Iteration.get_current.id

    if verify_recaptcha model: @vote, attribute: :proposals  and @vote.save
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
