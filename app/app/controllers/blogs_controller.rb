class BlogsController < ApplicationController
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    @blogs = Blog.where(:iteration_id => Iteration.get_current.id)
      .order(created_at: :desc)
      .paginate :page => params[:page], :per_page => 10
    index_respond @blogs, :blogs
  end

  def admin_console
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.iteration_id = Iteration.get_current.id
    if @blog.save
      flash[:notice] = (t 'blogs.save_success')
      redirect_to blogs_path
    else
      # TODO: need to add logic here
      render new_blog_path
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update blog_params
          redirect_to @blog
    else
      render "edit"
    end
  end

  def record_not_found
    flash[:error] = (t 'common.record_not_found')
    redirect_to action: :index
  end

  private
    def blog_params
      params.require(:blog).permit(
          :title,
          :body
          )
    end


end
