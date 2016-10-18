class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end  
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'your category was saved'
      redirect_to '/categories/'
    else
      # TODO: need to add logic here
      redirect_back '/categories/new/'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end 
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def update
    @category = Category.find(params[:id])
    if @category.update category_params
          redirect_to @category
    else
      render edit_category_path
    end
  end  
  
  private
    def category_params
      params.require(:category).permit(
          :name
          )
    end
  
end
