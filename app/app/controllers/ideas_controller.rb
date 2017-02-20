class IdeasController < ApplicationController
  load_and_authorize_resource

  def index
    logger.info("~~~~~~~~~~~~\nbeginning of INDEX");
    @ideas = filter_idea_columns(@ideas.where(:iteration_id => Iteration.get_current.id))
    if params[:sort].present?
      if params[:sort]=="likes"
        @ideas = @ideas.order likes: :desc
      end
      if params[:sort]=="id"
        @ideas = @ideas.order :id
      end
      if params[:sort]=="date"
        @ideas = @ideas.order :created_at
      end
      if user_has_admin_access
        if params[:sort]=="author_last_name"
          @ideas = @ideas.order :last_name
        end
        if params[:sort]=="author_first_name"
          @ideas = @ideas.order :first_name
        end
      end
    end
    @likes = Array.new
    if cookies[:likes] != nil
      @likes = JSON.parse(cookies[:likes])
    end
    index_respond @ideas, :ideas
  end

  def new
    @idea = Idea.new
  end

  alias_method :idea_collection, :new

  def edit
    @idea = Idea.find params[:id]
  end

	def create
		@idea = Idea.new(idea_params)
    @idea.iteration_id = Iteration.get_current.id
		if @idea.save
			flash[:notice] = 'Your idea was sent.'
			redirect_to ideas_path
		else
      puts @idea.errors.full_messages.to_yaml
			render 'new'
		end
	end

	def show
		@idea = filter_idea_columns(Idea.where(:id => params[:id])).first
	end

  # TODO: make this into an AJAX call
  def like
    @id = @idea.id
    @likes = Array.new
    #Check if cookie already exists
    if cookies[:likes] != nil
      @likes = JSON.parse(cookies[:likes])
      #Only add new like to cookie if it doesn't already have it
      if @likes.include?(@id)
        #Decrease value in database
        @idea = Idea.find(params[:id])
        @idea.decrement!(:likes)
        @idea.save
        #Update likes cookie
        @likes.delete(@id)
        @json_likes = JSON.generate(@likes)
        cookies[:likes] = @json_likes
      else
        #Update database values
        @idea = Idea.find(params[:id])
        @idea.increment!(:likes)
        @idea.save
        @likes.push(@id)
        @json_likes = JSON.generate(@likes)
        cookies[:likes] = @json_likes
      end
    #Else make a new cookie!
    else
      #Update database values
      @idea = Idea.find(params[:id])
      @idea.increment!(:likes)
      @idea.save
      #Make a new cookie
      @likes.push(@id)
      @json_likes = JSON.generate(@likes)
      cookies[:likes] = { :value => @json_likes, :expires => Time.now + 2628000 }
    end
    @div_id = '#like_button_'+@idea.id.to_s
     respond_to do |format|
         format.html
         format.js
     end
    #redirect_to ideas_path
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update idea_params
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
	  def idea_params
	    params.require(:idea).permit(
	    	:first_name,
	    	:last_name,
	    	:category_id,
	    	:email,
	    	:phone,
	    	:description,
        :address,
        :lat,
        :lng
	    	)
	  end

    def filter_idea_columns ideas
      unless user_has_admin_access
        return ideas.select(:id,:address,:created_at,:likes,:lat,:lng,:category_id,:description)
      end
      return ideas
    end
end
