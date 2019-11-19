import React from 'react';

export default function AddWishlistItem(props) {
  const { userId, wishlistId } = props;

  return (
    <div className='wishlist-item'>
      <div className='card'>
        <a href={`/users/${userId}/wishlists/${wishlistId}/items/new`} >
          <div className='primary'>
            <span className='no_image'>
              <i className='fa fa-plus-circle fa-10x' />
            </span>
          </div>
          <div className='secondary'>
            <p>Add Item</p>
            <p className='hint'>Add a new item to your wishlist.</p>
          </div>
        </a>
      </div>
    </div>
  )
}
