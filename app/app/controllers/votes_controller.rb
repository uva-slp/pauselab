class VotesController < ApplicationController
  load_and_authorize_resource

  def index
    @votes = @votes.where(:iteration_id => Iteration.get_current.id)
  end

  def new
    @vote = Vote.new
    @proposals = Proposal.where(status: :unchecked)
  end

  def create
    @vote = Vote.new(vote_params)
    puts "--1"
    puts @vote.first_name
    puts "--2"
    @vote.iteration_id = Iteration.get_current.id
    if verify_recaptcha model: @vote, attribute: :proposals  and @vote.save
      flash[:notice] = (t 'votes.save_success')
      redirect_to root_path
    else
      render 'new'
    end
    # render :plain => params.to_yaml
  end

  private
  def vote_params
    params.require(:vote).permit(
    :first_name,
    :last_name,
    :phone,
    :email,
    :proposal_ids => []
    )
  end

end
