class VotesController < ApplicationController
  load_and_authorize_resource

  def index
    @votes = @votes.where(:iteration_id => Iteration.get_current.id)
      .paginate :page => params[:page], :per_page => 25
  end

  def new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.iteration_id = Iteration.get_current.id
    if (user_has_admin_access or verify_recaptcha model: @vote, attribute: :proposals) and @vote.save
      flash[:notice] = (t 'votes.save_success')
      redirect_to root_path
    else
      flash[:error] = (t 'votes.save_error')
      render 'new'
    end
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
