class PagesController < ApplicationController
  def go_home
    case Iteration.get_current.status
    when 'ideas'
      redirect_to :action => :ideas
    when 'proposals'
      redirect_to :action => :proposal_collection, :controller => :ideas
    when 'voting'
      redirect_to :action => :new, :controller => :votes
    # when 'progress'
    #   redirect_to :action => :index, :controller => :blogs
    #else
    #  render :text => 'not in ideas'
    end
  end

  def get_ideas
    # map will show ideas that current user is authorized to see
    redirect_to ideas_path(:format => :json)
  end

  def get_categories
    ret_cat = {}
    categories = Category.all.each do |cat|
      ret_cat[cat.id] = if cat.icon.present? then view_context.image_path(cat.icon.url) else "" end
    end
    render json: ret_cat
  end

  def ideas
  end

  def about
  end

  def user_info
    @user = User.find(current_user.id)
  end

  def steering_home
  end

  def artist_home
  end

end
