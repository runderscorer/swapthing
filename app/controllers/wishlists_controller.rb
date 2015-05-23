class WishlistsController < ApplicationController
  before_action :get_items, only: [:show, :edit, :update]
  before_action :get_wishlist, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:show, :edit, :update]
  # around_action :check_user_memberships, except: [:index, :new, :create]

  def create
  end

  def show
  end

  def edit
    @item = @wishlist.items.build
  end

  def update
    if @wishlist.update_attributes(wishlist_params)
      binding.pry
      redirect_to edit_user_wishlist_path(@user.id, @wishlist)
    else
      puts 'Error! Error!'
      redirect_to wishlists_path
    end
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:id, :name, :membership_id, items_attributes: [:id, :name, :description, :price, :notes, :url])
  end

  def get_wishlist
    @wishlist = Wishlist.find(params[:id])
  end

  def get_items
    @items = Wishlist.find(params[:id]).items
  end

  def check_user_memberships
    accessible_wishlists = current_user.memberships.map {|membership| membership.wishlist_id}
    if accessible_wishlists.include? params[:id].to_i
      yield
    else
      redirect_to wishlists_path
      Rails.logger.debug 'User does not have access to this wishlist'
    end
  end
end