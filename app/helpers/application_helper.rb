module ApplicationHelper
  def encode_wishlist_id id
    Base64.encode64("wishlist-#{id.to_s}")
  end
end
