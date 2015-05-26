class WishlistsController < ApplicationController
  before_action :get_items, only: [:show, :edit, :update]
  before_action :get_wishlist, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:new, :create, :show, :edit, :update]
  # around_action :check_user_memberships, except: [:index, :new, :create]
  def new
    @wishlist = Wishlist.new(user_id: @user.id)
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)
    @wishlist.save

    redirect_to edit_user_wishlist_path(@user.id, @wishlist)
  end

  def show
  end

  def edit
    @item = @wishlist.items.build
  end

  def update
    if @wishlist.update_attributes(wishlist_params)
      redirect_to edit_user_wishlist_path(@user.id, @wishlist)
    else
      puts 'Error! Error!'
      redirect_to wishlists_path
    end
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:id, :user_id, :name, :membership_id, items_attributes: [:id, :name, :description, :price, :notes, :url])
  end

  def get_wishlist
    @wishlist = Wishlist.find_by(id: params[:id])
    redirect_to root_url unless @wishlist
  end

  def get_items
    @items = Wishlist.find(params[:id]).items unless @wishlist.blank?
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