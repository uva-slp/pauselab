class ProposalsController < ApplicationController
  load_and_authorize_resource

  def index
    @proposals = @proposals.where(:iteration_id => Iteration.get_current.id)
      .paginate :page => params[:page], :per_page => 25

    if params[:sort].present?
      if params[:sort] == "cost"
        @proposals = @proposals.includes(:proposal_budget).order("proposal_budgets.cost")
      elsif params[:sort] == "votes"
        if user_has_admin_access # prevent non-privileged members from sorting by votes
          @proposals = @proposals.left_joins(:votes).group(:id).order("count(votes.id) desc")
        end
      elsif params[:sort] == "first_name"
        @proposals = @proposals.includes(:user).order("users.first_name")
      elsif params[:sort] == "last_name"
        @proposals = @proposals.includes(:user).order("users.last_name")
      else
        @proposals = @proposals.order params[:sort]
      end
    end
		@proposals = @proposals.where(status: Proposal.statuses[params[:status]]) if params[:status].present?
    index_respond @proposals, :proposals
	end

	def new
		@proposal = Proposal.new
    @proposal.build_proposal_budget
	end

	def edit
		@proposal = Proposal.find params[:id]
	end

	def create
    @proposal = Proposal.new proposal_params
    # @proposal.build_proposal_budget

    @proposal.user_id = current_user.id
    @proposal.iteration_id = Iteration.get_current.id

		if @proposal.save
			flash[:notice] = (t 'proposals.save_success')
			redirect_to proposals_path
		else
			# TODO: need to add logic here
      render 'new'
			# redirect_back fallback_location: root_url
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
     if @proposal.approved?
       @proposal.unchecked!
     else
       @proposal.approved!
       @creator = @proposal.user
       @to = @creator.email

       SlpMailer.email_custom_text(@to, "CONGRATULATIONS " + @creator.first_name, "Congrats " + @creator.first_name + "! Your proposal was approved by PauseLab!").deliver

     end
     @proposal.save
    # end
    render 'show'
   end


   def fund
     @proposal = Proposal.find(params[:id])
     if @proposal.funded?
       @proposal.approved!
     else
       @proposal.funded!
       @creator = @proposal.user
       @to = @creator.email
       SlpMailer.email_custom_text(@to, "CONGRATULATIONS " + @creator.first_name, "Congrats " + @creator.fullname + "! Your proposal was approved by PauseLab!").deliver
     end
     @proposal.save
    # end
    render 'show'
   end


	private
	  def proposal_params
	    params.require(:proposal).permit(
                :title,
                :description,
                :essay,
                :website_link,
                :artist_cv,
                {:proposal_budget_attributes => [
                  :artist_fees,
                  :project_materials,
                  :printing,
                  :marketing,
                  :documentation,
                  :volunteers,
                  :insurance,
                  :events
                ]}
	    	)
	  end

    #def filter_proposal_columns proposals
    #  unless user_has_admin_access
    #    return proposals.select(:id,:cost,:description,:essay,:created_at,:updated_at,:website_link,:title)
    #  end
    #  return proposals
    #end
end
