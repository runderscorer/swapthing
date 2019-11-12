import React, {Component} from 'react';
import axios from 'axios';

export default class MarkAsPurchasedLink extends Component {
  constructor(props) {
    super(props);

    this.state = {
      id: this.props.id,
      purchased: this.props.purchased
    };
  }

  handleClick = async (e) => {
    e.preventDefault();

    const { id } = this.state;
    const response = await axios.post('/mark_as_purchased', { item: { id } });

    this.setState({ purchased: response.data.purchased });
  }

  displayLinkMessage = () => {
    const { purchased } = this.state;

    return purchased ? 'Unmark as Purchased' : 'Mark as Purchased';
  }

  render() {
    return (
      <a href='#' onClick={this.handleClick}>
        { this.displayLinkMessage() }        
      </a>
    )
  }
}