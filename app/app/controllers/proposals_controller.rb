class ProposalsController < ApplicationController
  def index
		@proposals = Proposal.where nil
		@proposals = @proposals.status(params[:status]) if params[:status].present?
	end

	def new
		@proposal = Proposal.new
	end

	def edit
		@proposal = Proposal.find params[:id]
	end 

	def create
		 @proposal = Proposal.new proposal_params
		if @proposal.save
			flash[:notice] = 'your proposal was sent'
			redirect_to 'pages/index'
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

	private
	  def proposal_params
	    params.require(:proposal).permit(
	    	:description,
                :cost,
                :essay,
                :website_link
	    	)
	  end

end
