class IdeasController < ApplicationController

	def index
		@ideas = Idea.where nil
		@ideas = @ideas.status(params[:status]) if params[:status].present?
	end

	def new
		@idea = Idea.new
	end

	def idea_collection
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
			render :idea_collection
		end
	end

	def show
		@idea = Idea.find(params[:id])
                @idea.increment!(:likes)
                @idea.save
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
          puts @idea.first_name
          #if @idea.status == "unchecked"
          @idea.status = "approved"
          #@idea.update(status, "approved")
          puts @idea.status
          @idea.save
          puts @idea.errors.full_messages
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
