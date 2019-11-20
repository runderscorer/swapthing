module WishlistDecoder
  def decode_string_to_wishlist_id(string)
    Base64.decode64(string).scan(/\d+/).first.to_i
  end
end