class IdeasController < ApplicationController
	load_and_authorize_resource

	def index
		@ideas = Idea.all
		# TODO status check?
	end

	def new
		@idea = Idea.new
	end

	def idea_collection	# TODO redundant?
		@idea = Idea.new
	end

	def edit
		@idea = Idea.find params[:id]
	end

	def create
		@idea = Idea.new(ideas_params)
		if @idea.save
			flash[:notice] = 'your idea was sent'
			redirect_to ideas_path
		else
			render :idea_collection
		end
	end

	def show
		@idea = Idea.find(params[:id])
	end

  def like
    @idea = Idea.find(params[:id])
    @idea.increment!(:likes)
    @idea.save
    redirect_to ideas_path
	end

	def destroy
	  @idea = Idea.find(params[:id])
	  @idea.destroy
	  redirect_to ideas_path
	end

	def update
	  @idea = Idea.find(params[:id])
	  if @idea.update ideas_params
	  	redirect_to @idea
	  else
	    render 'edit'
	  end
	end

  def approve
    @idea = Idea.find(params[:id])
    @idea.approved!
    @idea.save
		# end
		redirect_to ideas_path
	end


	private
	  def ideas_params
	    params.require(:idea).permit(
	    	:first_name,
	    	:last_name,
	    	:category_id,
	    	:email,
	    	:phone,
	    	:description,
	    	:location
	    	)
	  end

end
