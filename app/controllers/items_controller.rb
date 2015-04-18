class ItemsController < ApplicationController
  before_action :get_item

  def edit
  end

  def update
    @item.update_attributes(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :price, :description, :notes, :url)
  end

  def get_item
    @item = Item.find(params[:id])
  end
end