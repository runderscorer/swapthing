import React, {Component} from 'react';
import axios from 'axios';
import WishlistItem from './WishlistItem';
import AddWishlistItem from './AddWishlistItem';

export default class EditWishlistItems extends Component {
  constructor(props) {
    super(props);

    this.state = {
      wishlistItems: props.items,
      selectedItemIds: [],
    }
  }

  handleChange = (e) => {
    const { items } = this.props;

    if (e.target.checked) {
      this.setState({
        selectedItemIds: [...items.map(item => item.table.id)]
      })
    } else {
      this.setState({
        selectedItemIds: []
      })
    }
  }

  handleClick = async (e) => {
    e.preventDefault();

    const result = confirm('Delete these items?');
    if (!result) { return };

    const { authenticityToken, wishlistId } = this.props;
    const { selectedItemIds } = this.state;
    const options = {
      headers: { 'X-CSRF-Token': authenticityToken },
      data: { item_ids: selectedItemIds, wishlist_id: wishlistId }
    };

    const response = await axios.delete('/delete_items', options);
    const { data: { items } } = response;

    this.setState({ 
      wishlistItems: items,
      selectedItemIds: []
    });
  }

  handleDeleteItemCallback = (itemId) => {
    const { wishlistItems } = this.state;
    const newWishlistItems = wishlistItems.filter(item => item.table.id != itemId)

    this.setState({ wishlistItems: newWishlistItems })
  }

  handleSelectedItemCallback = (itemId, add) => {
    if (add) {
      this.setState({
        selectedItemIds: [...this.state.selectedItemIds, itemId]
      })
    } else {
      this.setState({
        selectedItemIds: [...this.state.selectedItemIds.filter(id => id != itemId)]
      })
    }
  }

  displaySelectAll = () => {
    const { selectedItemIds, wishlistItems } = this.state;
    const checked = selectedItemIds.length;

    return (
      wishlistItems.length > 0 &&
      <div className='controls'>
        <div>
          <input type="checkbox" name='select-all' id='select-all' onChange={this.handleChange} checked={checked} />
          <label htmlFor='select-all'>Select All</label>
        </div>
        { this.displayDeleteSelectedLink() }
      </div>
    )
  }

  displayDeleteSelectedLink = () => {
    const { selectedItemIds } = this.state;

    return (
      selectedItemIds.length > 0 && 
      <div className='delete-selected'>
        <i className='fa fa-trash-o fa-lg' />
        <a href='#' onClick={this.handleClick}>
          <span className='label'>Delete Selected Items</span>
        </a>
      </div>
    )
  }

  render() {
    const { authenticityToken, isOwner, userId, wishlistId } = this.props;
    const { wishlistItems, selectedItemIds } = this.state;

    return (
      <div>
        { this.displaySelectAll() }
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
                selected={selectedItemIds.includes(item.table.id)}
                selectedItemCallback={this.handleSelectedItemCallback}
                userId={userId}
                wishlistId={wishlistId}
              />
            )
          }
        </div>
      </div>
    )
  }
}
