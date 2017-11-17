class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_partner_row(user)
    @partner = GetPartner.call(self, params[:event_id])
    if @partner && @partner == user
      render 'partner_row', partner: @partner
    else
      render 'user_row', user: user
    end
  end

  def show_partner(event_id)
    partner = GetPartner.call(self, event_id)
    if partner && partner.wishlist
      content_tag(:p, partner.fname) +
      button_tag do
        link_to "View #{partner.full_name}'s wishlist", wishlist_path(partner.wishlist.id)
      end
    else
      content_tag(:p, 'Unassigned')
    end
  end
end
