import React from 'react';

export default function MarkAsPurchasedLink(props) {
  const handleClick = (e) => {
    e.preventDefault();

    props.clickHandler();
  }

  const displayLinkMessage = () => {
    const { purchased } = props;

    return purchased ? 'Unmark as Purchased' : 'Mark as Purchased';
  }

  return (
    <a href='#' onClick={handleClick}>
      { displayLinkMessage() }        
    </a>
  )
}