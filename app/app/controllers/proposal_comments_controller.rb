class ProposalCommentsController < ApplicationController
  load_and_authorize_resource
  before_action :locate_proposal

  def index
    @comments = @proposal.proposal_comments
    authorize! :read, :proposal_comments # TODO handle index automatically
  end

  def new
    @comment = ProposalComment.new
  end

  def create
    @comment = @proposal.proposal_comments.create(proposal_comment_params)
    @comment.user_id = current_user.id if current_user
    if @comment.save
      flash[:notice] = 'Your comment was posted.'
    else
      flash[:error] = 'There was an error posting your comment.'
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
    if @comment.update proposal_comment_params
      flash[:notice] = 'Comment updated.'
    else
      flash[:error] = 'Comment failed to update.'
    end
    redirect_to proposal_path(@proposal)
  end

  def destroy
    locate_comment
    if @comment.destroy
      flash[:notice] = 'Comment removed.'
    else
      flash[:error] = 'Comment failed to remove.'
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
    @comment = @proposal.proposal_comments.find(params[:id])
  end
end
