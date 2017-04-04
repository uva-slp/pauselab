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
    else
      render :text => 'not in ideas'
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

  def test_email
    #SlpMailer.email_self.deliver_later
    #SlpMailer.email_self.deliver
    @to   = 'goldjet45@gmail.com'
    @subj = 'subways $5 for 5 deals'
    @body = 'non html body'
    SlpMailer.email_custom_text(@to, @subj, @body).deliver
    flash[:notice] = "Your mail has been sent"
    redirect_to cookies_path
  end

  def cookies_song
    if cookies[:likes] != nil
      @likes = cookies[:likes]
    else
      @likes = "oh no im nil"
    end

    #<%= f.input :to, collection: User.roles, as: :check_boxes %>
    #SELECT * FROM  users WHERE role=0;
    #SELECT * FROM  users WHERE role=0 OR role=1;
    #@emails_users = JSON.generate(User.connection.select_values(User.select("email").where("role"==1).to_sql))
    @emails_list = Array.new
    @role_list = ["admin"]
    @emails_users = User.pluck(:email, :role)
    @emails_users.each do |eu|
        if @role_list.include?(eu[1])
          @emails_list.push(eu[0])
        end
    end
    @emails_ideas = JSON.generate(Idea.pluck(:email))
    #@emails_ideas.reject!(&:null?)
  end

end
