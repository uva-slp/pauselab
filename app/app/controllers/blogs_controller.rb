class BlogsController < ApplicationController
  
  def index
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
    if @blog.save
      flash[:notice] = 'your blog was saved'
      redirect_to blogs_path
    else
      # TODO: need to add logic here
      redirect_back new_blog_path
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
      render edit_blog_path
    end
  end  
  
  private
    def blog_params
      params.require(:blog).permit(
          :title,
          :body
          )
    end
  
end
