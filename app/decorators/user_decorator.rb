class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_partner_name(event_id)
    partner = GetPartner.call(self, event_id)

    partner ? partner.full_name : 'Unassigned'
  end

  def show_partner_wishlist_link(event_id)
    return unless partner = GetPartner.call(self, event_id)

    link_to "View #{partner.fname}'s Wishlist", wishlist_path(encode_wishlist_id(partner.wishlist.id))
  end
end
