class IdeasController < ApplicationController

	def index
		@ideas = Idea.where nil
		@ideas = @ideas.status(params[:status]) if params[:status].present?
	end

	def new
		@idea = Idea.new
	end

	def edit
		@idea = Idea.find params[:id]
	end 

	def create
		@idea = Idea.new(ideas_params)
		if @idea.save
			flash[:notice] = 'your idea was sent'
			redirect_to '/ideas/'
		else
			# TODO: need to add logic here
			redirect_back fallback_location: root_url
		end
	end

	def show
		@idea = Idea.find(params[:id])
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

	private
	  def ideas_params
	    params.require(:idea).permit(
	        :first_name,
                :last_name,
	    	:phone, 
	    	:description
	    	)
	  end

end
