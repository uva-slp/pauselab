class ProposalsController < ApplicationController
  load_and_authorize_resource

  def index
		@proposals = Proposal.where nil
		@proposals = @proposals.status(params[:status]) if params[:status].present?
                @vote = Vote.new
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
		@ideas = Idea.all
	end

   def approve
    @proposal = Proposal.find(params[:id])
    @proposal.approved!
    @proposal.save
   # end
     redirect_to proposals_path
   end

	private
	  def proposal_params
	    params.require(:proposal).permit(
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

end
