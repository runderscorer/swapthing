import React from 'react';

export default function MarkAsPurchased(props) {
  const { itemId, purchased } = props;

  const handleClick = (e) => {
    props.clickHandler();
  }

  const displayLinkMessage = () => {
    return purchased ? 'Purchased' : 'Mark as Purchased';
  }

  return (
    <span>
      <input 
        type='checkbox' 
        checked={purchased}
        id={`mark-as-purchased-${itemId}`} 
        onClick={handleClick} 
      />
      <label for={`mark-as-purchased-${itemId}`}>
        { displayLinkMessage() }        
      </label>
    </span>
  )
}