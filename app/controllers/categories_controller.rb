class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.order(:created_at).reverse_order.page(params[:page]).per(10)
    @stories = @category.stories.order(:created_at).reverse_order.page(params[:page]).per(10)
  end
end
