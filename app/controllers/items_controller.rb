class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_msg

  def index
    if params[:user_id] 
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create 
    item = Item.create!(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def render_not_found_msg
    render json: { error: "Item not found" }, status: :not_found
  end

end
