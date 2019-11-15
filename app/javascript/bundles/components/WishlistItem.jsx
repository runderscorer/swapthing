import React, {Component} from 'react';
import axios from 'axios';
import MarkAsPurchasedLink from './MarkAsPurchasedLink';

export default class WishlistItem extends Component {
  constructor(props) {
    super(props);
  }
  
  displayWishlistItemImage = () => {
    const { image: itemImage } = this.props.item.table;

    return (
      itemImage ?
        <span className='image'>
          <img src={itemImage} />
        </span> :
        <i className='fa fa-gift fa-10x' />
    )
  }

  handleDelete = (e) => {
    e.preventDefault();
    const { authenticityToken, userId, wishlistId } = this.props; 
    const { id: itemId } = this.props.item.table;

    axios.delete(
      `/users/${userId}/wishlists/${wishlistId}/items/${itemId}`,
      { headers: {'X-CSRF-Token': authenticityToken}}
    );
    window.location.reload(true);
  }

  render() {
    const {
      id: itemId,
      url: itemUrl,
      price: productPrice,
      short_url: itemShortUrl,
      name: itemName,
      notes: itemNotes,
      purchased,
    } = this.props.item.table;
    const { isOwner, userId, wishlistId } = this.props;

    return (
      <div className='wishlist-item'>
        <div className='card'>
          <a href={itemUrl} target='_blank'>
            <div className='primary'>
              {this.displayWishlistItemImage()}
              <div className='prod_price'>
                {productPrice}
              </div>
            </div>
          </a>

          <div className='secondary'>
            <div className='prod_source'>{itemShortUrl}</div>
            <div className='prod_name'>{itemName}</div>
            <div className='prod_notes'>{itemNotes}</div>
          </div>

          { isOwner &&
            <div className='left_icon'>
              <a href='#' onClick={this.handleDelete}>
                <i className='fa fa-trash-o fa-lg' />
              </a>
            </div> }

          { isOwner &&
            <div className='right_icon'>
              <a href={`/users/${userId}/wishlists/${wishlistId}/items/${itemId}/edit`}>
                <i className='fa fa-pencil-square-o fa-lg' id={`edit-item-${itemId}`}/>
              </a>
            </div> }
        </div>

        <div className='mark-as-purchased'>
          <MarkAsPurchasedLink itemId={itemId} purchased={purchased} />
        </div>
      </div>
    )
  }
}
