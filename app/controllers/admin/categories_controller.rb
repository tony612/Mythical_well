class Admin::CategoriesController < Admin::ApplicationController
  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:node])
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end
end
