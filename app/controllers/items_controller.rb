class ItemsController < ApplicationController
  before_action :get_item, except: [:new, :create]
  before_action :get_wishlist, only: [:new, :create]
  before_action :get_user, only: [:create]

  def new
    @item = @wishlist.items.build
  end

  def create
    @item = @wishlist.items.build(item_params)

    if @item.save
      redirect_to user_wishlist_path(@user.id, @wishlist.id)
    end
  end

  def edit
  end

  def update
    @item.update_attributes(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:id, :wishlist_id, :name, :price, :description, :notes, :url)
  end

  def get_item
    @item = Item.find(params[:id])
  end

  def get_wishlist
    @wishlist = Wishlist.find(params[:wishlist_id])
  end
end