import React, {Component} from 'react';
import WishlistItem from './WishlistItem';
import AddWishlistItem from './AddWishlistItem';

export default class EditWishlistItems extends Component {
  constructor(props) {
    super(props);

    this.state = {
      wishlistItems: props.items,
    }
  }

  handleDeleteItemCallback = (itemId) => {
    const { wishlistItems } = this.state;
    const newWishlistItems = wishlistItems.filter(item => item.table.id != itemId)

    this.setState({ wishlistItems: newWishlistItems })
  }

  render() {
    const { authenticityToken, isOwner, userId, wishlistId } = this.props;
    const { wishlistItems } = this.state;

    return (
      <div className='wishlist-items'>
        <AddWishlistItem userId={userId} wishlistId={wishlistId} />
        { 
          wishlistItems.map(item => 
            <WishlistItem 
              key={item.table.id}
              authenticityToken={authenticityToken}
              deleteItemCallback={this.handleDeleteItemCallback}
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
