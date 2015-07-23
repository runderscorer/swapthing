class ItemsController < ApplicationController
  before_action :get_item, except: [:new, :create]
  before_action :get_wishlist, only: [:new, :create]
  before_action :get_user, only: [:new, :create]

  def new
    @item = @wishlist.items.new
  end

  def create
    @item = @wishlist.items.new(item_params)

    if @item.save
      redirect_to edit_user_wishlist_path(@user.id, @wishlist.id)
    end
  end

  def edit
  end

  def update
    @item.update_attributes(item_params)
    redirect_to edit_user_wishlist_path(params[:user_id], params[:wishlist_id])
  end

  def destroy
    redirect_to edit_user_wishlist_path(params[:user_id], params[:wishlist_id]) if @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:id, :wishlist_id, :name, :price, :description, :notes, :url, :image_url)
  end

  def get_item
    @item = Item.find(params[:id])
  end

  def get_wishlist
    @wishlist = Wishlist.find(params[:wishlist_id])
  end
end