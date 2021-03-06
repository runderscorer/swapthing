import React from 'react';
import ImagePreview from './ImagePreview';

export default class ImageUrlField extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      imageUrl: this.props.imageUrl || '',
      error: this.props.error || ''
    };

    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState({ imageUrl: event.target.value });
  }

  displayErrorMessage(message) {
    if (message.length) {
      return <p className='error'>{message}</p>;
    };
  }

  render () {
    const { imageUrl, error } = this.state;

    return(
      <div id='item_image_url'>
        <div>
          <label name='item_image_url'>Image URL</label>
          <input
            name='item[image_url]'
            type='text'
            value={this.state.imageUrl}
            onChange={this.handleChange}
            placeholder='www.amazon.com/movies/terminator_2.jpg'
            />
          { this.displayErrorMessage(error) }
        </div>
        <ImagePreview imageUrl={imageUrl} />
      </div>
    );
  }
}
