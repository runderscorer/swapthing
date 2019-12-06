import React, {Component} from 'react';
import axios from 'axios';
import MarkAsPurchased from './MarkAsPurchased';

export default class WishlistItem extends Component {
  constructor(props) {
    super(props);

    this.state = {
      purchased: props.item.table.purchased,
    }
  }
  
  displayWishlistItemImage = () => {
    const { image: itemImage } = this.props.item.table;

    return (
      itemImage ?
        <span className='image'>
          <img src={this.appendProtocolToURL(itemImage)} />
        </span> :
        <i className='fa fa-gift fa-10x' />
    )
  }

  handleChange = (e) => {
    const { item: { table: { id: itemId } }, selectedItemCallback } = this.props;

    selectedItemCallback(itemId, e.target.checked);
  }

  handleDelete = async (e) => {
    e.preventDefault();

    const result = confirm('Delete this item?');
    if (!result) { return }; 

    const { authenticityToken, deleteItemCallback, userId, wishlistId } = this.props; 
    const { id: itemId } = this.props.item.table;

    const response = await axios.delete(
      `/users/${userId}/wishlists/${wishlistId}/items/${itemId}`,
      { headers: {'X-CSRF-Token': authenticityToken} }
    );

    if (response.status === 200) { deleteItemCallback(itemId) };
  }

  handlePurchasedCallback = async () => {
    const { id } = this.props.item.table;
    const response = await axios.post('/mark_as_purchased', { item: { id } });

    this.setState({ purchased: response.data.purchased });
  }

  isPurchased = () => {
    const { isOwner } = this.props;
    const { purchased } = this.state;

    return !isOwner && purchased ? 'purchased' : '';
  }

  appendProtocolToURL = (itemUrl) => itemUrl.includes('http') ? itemUrl : 'http://' + itemUrl;

  render() {
    const {
      id: itemId,
      url: itemUrl,
      price: productPrice,
      short_url: itemShortUrl,
      name: itemName,
      notes: itemNotes,
    } = this.props.item.table;
    const { isOwner, selected, userId, wishlistId } = this.props;
    const { purchased } = this.state;

    return (
      <div className='wishlist-item'>
        <div className='card'>
          <a href={this.appendProtocolToURL(itemUrl)} target='_blank'>
            <div className='primary'>
              { isOwner && 
                <input type='checkbox' onChange={this.handleChange} checked={selected} /> }
              { this.displayWishlistItemImage() }
              <div className={`product_price ${this.isPurchased()}`}>
                ${productPrice}
              </div>
            </div>
          </a>

          <div className='secondary'>
            <div className='product_source'>{itemShortUrl}</div>
            <div className={`product_name ${this.isPurchased()}`}>{itemName}</div>
            <div className='product_notes'>{itemNotes}</div>
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

        { !isOwner && 
          <div className='mark-as-purchased'>
            <MarkAsPurchased 
              clickHandler={this.handlePurchasedCallback}
              itemId={itemId}
              purchased={purchased} 
            />
          </div> }
      </div>
    )
  }
}
