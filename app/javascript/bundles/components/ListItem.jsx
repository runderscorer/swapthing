import React from 'react';

export default class ListItem extends React.Component {
  constructor() {
    super();
    this.clickHandler = this.clickHandler.bind(this);
  }

  clickHandler() {
    this.props.clickHandler(this.props.index);
  }

  render() {
    const { index, name } = this.props;

    return (
      <div className='list-item'>
        <span>{name}</span>
        <span onClick={this.clickHandler}>Remove</span>
      </div>
    )
  }
}
