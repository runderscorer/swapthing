module WishlistItemsSerializer
  def build_wishlist_items items
    return unless items
    items.ordered_by_name.reduce([]) do |item_attrs, item|
      item_attrs.push(
        OpenStruct.new(
          {
            id: item.id,
            name: item.name,
            url: item.url,
            price: item.price,
            image: item.image_url,
            vendor_name: item.vendor_name,
            notes: item.notes,
            purchased: item.purchased,
            date_added: item.created_at.strftime("%m/%d/%Y")
          }
        )
      )
    end
  end
end
