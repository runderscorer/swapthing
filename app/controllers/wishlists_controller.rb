class WishlistsController < ApplicationController

  def index
    @wishlists = current_user.wishlists
  end

  def show
  end

  def create
  end
end