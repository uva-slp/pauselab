class PagesController < ApplicationController
  def go_home
    case Iteration.get_current.status
    when 'ideas'
      redirect_to :action => :ideas
    when 'proposals'
      redirect_to :action => :card_index, :controller => :ideas
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
    authorize! :read, Category
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
    authorize! :read, @user
  end

  def steering_home
    unless user_has_steering_access?  # prevent residents and artists from seeing
      flash[:error] = (t 'common.authorization_error')
      redirect_to root_path
    end
  end

  def artist_home
    unless user_signed_in?  # prevent residents from seeing
      flash[:error] = (t 'common.authorization_error')
      redirect_to root_path
    end
  end

end
