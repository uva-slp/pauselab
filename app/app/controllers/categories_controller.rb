class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @category = Category.new
    index_respond @categories, :categories
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "your category was saved" }
        format.json { render json: @resource }
      else
        format.html { render new_category_path, notice: "there was an error in creating a category" }
        format.json { render json: @resource }
      end
    end
    #
    # if @category.save
    #   flash[:notice] = 'Your category was saved.'
    #   redirect_to categories_path
    # else
    #   flash[:error] = 'There was in error in creating a category.'
    #   render new_category_path
    # end
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
      render edit_category_path @category
    end
  end

  private
    def category_params
      params.require(:category).permit(
          :name,
          :icon
          )
    end

end
