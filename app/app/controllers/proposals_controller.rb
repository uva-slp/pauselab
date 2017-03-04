class ProposalsController < ApplicationController
  load_and_authorize_resource

  def index
    @proposals = @proposals.where(:iteration_id => Iteration.get_current.id)
      .paginate :page => params[:page], :per_page => 25
    if params[:sort].present?
      @proposals = @proposals.order params[:sort]
    end
		@proposals = @proposals.where(status: Proposal.statuses[params[:status]]) if params[:status].present?
    index_respond @proposals, :proposals
	end

	def new
		@proposal = Proposal.new
	end

	def edit
		@proposal = Proposal.find params[:id]
	end

	def create
    @proposal = Proposal.new proposal_params
    @proposal.user_id = current_user.id
    @proposal.iteration_id = Iteration.get_current.id

		if @proposal.save
			flash[:notice] = 'your proposal was sent'
			redirect_to proposals_path
		else
			# TODO: need to add logic here
			redirect_back fallback_location: root_url
		end
	end

	def show
		@proposal = Proposal.find(params[:id])
	end

	def destroy
	  @proposal = Proposal.find(params[:id])
    @proposal.proposal_comments.destroy_all # remove all associated comments
	  @proposal.destroy
	  redirect_to proposals_path
	end

	def update
	  @proposal = Proposal.find(params[:id])
	  if @proposal.update proposal_params
	  	redirect_to @proposal
	  else
	    render 'edit'
	  end
	end

	def proposal_collection
    @ideas = Idea.where :iteration_id => Iteration.get_current.id
		# @ideas = Idea.all
    @likes = Array.new
    if cookies[:likes] != nil
      @likes = JSON.parse(cookies[:likes])
    end
	end

   def approve
    @proposal = Proposal.find(params[:id])
    @proposal.approved!
    @proposal.save
    redirect_to proposals_path
   end

	private
	  def proposal_params
	    params.require(:proposal).permit(
                :title,
                :description,
                :artist_fees,
                :project_materials,
                :printing,
                :marketing,
                :documentation,
                :volunteer,
                :insurance,
                :events,
                :cost,
                :essay,
                :website_link,
                :artist_cv,
	    	)
	  end

    #def filter_proposal_columns proposals
    #  unless user_has_admin_access
    #    return proposals.select(:id,:cost,:description,:essay,:created_at,:updated_at,:website_link,:title)
    #  end
    #  return proposals
    #end
end
