class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @category = Category.new
    index_respond @categories, :categories
  end

  def show
  end

  def new
  end

  def create
    @category = Category.new category_params
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: (t 'categories.save_success') }
        format.json { render json: @resource }
      else
        format.html { render new_category_path, notice: (t 'categories.save_error') }
        format.json { render json: @resource }
      end
    end
  end

  def edit
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  def update
    if @category.update category_params
      redirect_to @category
    else
      render 'edit'
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
