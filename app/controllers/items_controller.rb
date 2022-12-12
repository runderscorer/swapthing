class ItemsController < ApplicationController
  include WishlistItemsSerializer

  before_action :get_item, except: [:new, :create, :mark_as_purchased, :delete_items]
  before_action :get_wishlist, only: [:new, :create, :destroy]
  before_action :get_user, only: [:new, :create]
  skip_before_action :verify_authenticity_token, except: [:create, :update, :destroy, :delete_items]

  def new
    @item = @wishlist.items.new
  end

  def create
    @item = @wishlist.items.new(item_params)

    if @item.save
      flash[:notice] = "Alright! #{@item.name} has been added to your wishlist."
      redirect_to edit_user_wishlist_path(@user.id, @wishlist.id)
    else
      flash.now[:error] = 'Your item was not saved. Please review the errors below.'
      render :new
    end
  rescue
    Rails.logger.info { "ERROR - #{@item.errors.full_messages}" }
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Alright! #{@item.name} has been updated."
      redirect_to edit_user_wishlist_path(params[:user_id], params[:wishlist_id])
    else
      flash.now[:error] = 'Your item was not updated. Please review the errors below.'
      render :edit
    end
  end

  def destroy
    render json: { message: 'Successfully deleted', status: 200 } if @item.destroy
  end

  def mark_as_purchased
    item = Item.find params[:id]
    item.update(purchased: !item.purchased)

    render json: { purchased: item.purchased, status: 200 }
  end

  def delete_items
    wishlist = Wishlist.find(request.params['wishlist_id'])
    items = Item.where(id: request.params['item_ids'])

    if items.delete_all
      render json: { message: 'success', items: build_wishlist_items(wishlist.items) }
    else
      render json: { message: 'error deleting items' }
    end
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
