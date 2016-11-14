class IdeasController < ApplicationController
  load_and_authorize_resource

  def index
          @ideas = Idea.all
          @likes = Array.new
          if cookies[:likes] != nil
            @likes = JSON.parse(cookies[:likes])
          end 
          # TODO status check?
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
		# code for verifying recaptcha - requires SSL, which would need effort
		#unless verify_recaptcha or user_signed_in?
		#	flash[:error] = 'Use RECAPTCHA'
		#	render :idea_collection
		#end
		#
		if @idea.save
			flash[:notice] = 'Your idea was sent.'
			redirect_to ideas_path
		else
			flash[:error] = 'There was an error in sending your idea.'
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
    @id = @idea.id
    @likes = Array.new
    #Check if cookie already exists
    if cookies[:likes] != nil
      @likes = JSON.parse(cookies[:likes])
      #Only add new like to cookie if it doesn't already have it
      unless @likes.include?(@id)
        @likes.push(@id)
        @json_likes = JSON.generate(@likes) 
        cookies[:likes] = @json_likes
      end
    #Else make a new cookie!
    else
      @likes.push(@id)
      @json_likes = JSON.generate(@likes) 
      cookies[:likes] = { :value => @json_likes, :expires => Time.now + 2628000 }
    end
    redirect_to ideas_path
  end
  
  def dislike
    @idea = Idea.find(params[:id])
    @idea.increment!(:likes)
    @idea.save
    @id = @idea.id
    @likes = Array.new
    #Check if cookie already exists
    if cookies[:likes] != nil
      @likes = JSON.parse(cookies[:likes])
      #Only add new like to cookie if it doesn't already have it
      unless @likes.include?(@id)
        @likes.push(@id)
        @json_likes = JSON.generate(@likes) 
        cookies[:likes] = @json_likes
      end
    #Else make a new cookie!
    else
      @likes.push(@id)
      @json_likes = JSON.generate(@likes) 
      cookies[:likes] = { :value => @json_likes, :expires => Time.now + 2628000 }
    end
    redirect_to ideas_path
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
	    	:location
	    	)
	  end

end