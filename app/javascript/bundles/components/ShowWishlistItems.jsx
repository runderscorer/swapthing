import React from 'react';
import WishlistItem from './WishlistItem';

export default function ShowWishlistItems(props) {
  const { items, isOwner } = props;

  return (
    <div className='wishlist-items'>
      { items.map(item => <WishlistItem key={item.table.id} item={item} isOwner={isOwner} />) }
    </div>
  )
}
