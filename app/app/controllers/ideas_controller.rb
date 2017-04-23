class IdeasController < ApplicationController
  load_and_authorize_resource

  def index
    @ideas = filter_idea_columns(@ideas.where(:iteration_id => Iteration.get_current.id))
          .paginate :page => params[:page], :per_page => 25

    case params[:sort]
    when "category"
      @ideas = @ideas.order :category_id
    when "id"
      @ideas = @ideas.order :id
    when "date"
      @ideas = @ideas.order created_at: :desc
    when "author_last_name"
      if user_has_admin_access # prevent non-privileged users from sorting
        @ideas = @ideas.order :last_name
      end
    when "author_first_name"
      if user_has_admin_access # prevent non-privileged users from sorting
        @ideas = @ideas.order :first_name
      end
    when "likes"
      @ideas = @ideas.order likes: :desc
    end

    @likes = Array.new
    if cookies[:likes] != nil
      @likes = JSON.parse(cookies[:likes])
    end
    index_respond @ideas, :ideas

  end

  alias_method :proposal_collection, :index

  def new
  end

  def edit
  end

	def create
		@idea = Idea.new(idea_params)
    @to = @idea.email
    @idea.iteration_id = Iteration.get_current.id
		if @idea.save
			flash[:notice] = (t 'ideas.save_success')
      SlpMailer.email_custom_text(@to, (t 'ideas.thanks_subject', :name => @idea.first_name),
        (t 'ideas.thanks_body', :name => @idea.first_name)).deliver
			redirect_to root_path
		else
      flash[:error] = (t 'ideas.save_error')
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
    @idea.destroy
    redirect_to ideas_path
  end

  def update
    if @idea.update idea_params
      redirect_to @idea
    else
      render 'edit'
    end
  end

  def approve
    @idea = Idea.find(params[:id])
    if @idea.approved?
      @idea.unchecked!
    else
      @idea.approved!
    end
    @idea.save
		render 'show'
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
        :medium,
        :address,
        :lat,
        :lng
	    	)
	  end

    def filter_idea_columns ideas
      unless user_has_steering_access
        return ideas.select(:id,:address,:created_at,:likes,:lat,:lng,:category_id,:description)
      end
      return ideas
    end
end
