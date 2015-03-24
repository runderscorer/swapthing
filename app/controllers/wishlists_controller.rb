class WishlistsController < ApplicationController

  def index
    @wishlists = current_user.wishlists
  end

  def show
  end

  def create
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:id, :membership_id, items_attributes: [:id, :name, :description, :price, :notes, :url])
end