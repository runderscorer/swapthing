class WishlistDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_edit_link(item)
    render 'edit_link', item: item if params[:user_id].present?
  end

  def show_delete_link(item)
    render 'delete_link', item: item if params[:user_id].present?
  end

  def show_add_item_card
    render 'add_item' if params[:user_id].present?
  end

  def show_reminder?
    render 'reminder' if self.items.empty?
  end

  def show_mark_as_purchased_link(item)
    react_component('MarkAsPurchasedLink', props: { id: item.id, purchased: item.purchased })
  end
end
