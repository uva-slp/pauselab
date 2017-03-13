class ProposalCommentsController < ApplicationController
  load_and_authorize_resource
  before_action :locate_proposal

  def index
    @proposal_comments = @proposal.proposal_comments
  end

  def new
  end

  def create
    @proposal_comment = @proposal.proposal_comments.create(proposal_comment_params)
    @proposal_comment.user_id = current_user.id if current_user
    if @proposal_comment.save
      flash[:notice] = (t 'proposal_comments.save_success')
    else
      flash[:error] = (t 'proposal_comments.save_error')
    end
    redirect_to proposal_path(@proposal)
  end

  def edit
    locate_comment
  end

  def show
    locate_comment
  end

  def update
    locate_comment
    if @proposal_comment.update proposal_comment_params
      flash[:notice] = (t 'proposal_comments.save_success')
    else
      flash[:error] = (t 'proposal_comments.save_error')
    end
    redirect_to proposal_path(@proposal)
  end

  def destroy
    locate_comment
    if @proposal_comment.destroy
      flash[:notice] = (t 'proposal_comments.remove_success')
    else
      flash[:error] = (t 'proposal_comments.remove_error')
    end
    redirect_to proposal_path(@proposal)
  end

  private
  def proposal_comment_params
    params.require(:proposal_comment).permit(:body)
  end

  def locate_proposal
    @proposal = Proposal.find(params[:proposal_id])
  end

  def locate_comment
    @proposal_comment = @proposal.proposal_comments.find(params[:id])
  end
end
