class WishlistDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_edit_link(item)
    if params[:user_id].present?
      render 'edit_link', item: item
    end
  end
end