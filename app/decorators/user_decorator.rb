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

  def show_exclude_link(event_id, user_id)
    event = Event.find(event_id)
    user = User.find(user_id)
    eligible_users_for_exclusion = (event.users - [user]).pluck(:fname, :id)

    simple_form_for Exclusion.new do |f|
      form_html = ''
      form_html += f.input :excluded_user_id, collection: eligible_users_for_exclusion, prompt: 'Pick a person', label: false
      form_html += f.input :event_id, input_html: { value: event_id }, as: :hidden
      form_html += f.input :user_id, input_html: { value: user_id }, as: :hidden
      form_html += f.submit 'Exclude', class: 'btn btn-primary'
      form_html.html_safe
    end
  end
end
