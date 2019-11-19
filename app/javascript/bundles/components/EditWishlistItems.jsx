import React, {Component} from 'react';
import WishlistItem from './WishlistItem';
import AddWishlistItem from './AddWishlistItem';

export default class EditWishlistItems extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { authenticityToken, items, isOwner, userId, wishlistId } = this.props;

    return (
      <div className='wishlist-items'>
        <AddWishlistItem userId={userId} wishlistId={wishlistId} />
        { 
          items.map(item => 
            <WishlistItem 
              key={item.table.id}
              authenticityToken={authenticityToken}
              item={item}
              isOwner={isOwner}
              userId={userId}
              wishlistId={wishlistId}
            />
          )
        }
      </div>
    )
  }
}
