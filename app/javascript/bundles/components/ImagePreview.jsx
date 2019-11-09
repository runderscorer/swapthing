import React from 'react';

export default class ImagePreview extends React.Component {
  validFileType(src) {
    return ['.jpg', '.jpeg', '.gif', '.png'].includes(src.substr(src.lastIndexOf('.'), src.length));
  }

  render () {
    const { imageUrl } = this.props;
    if (imageUrl && this.validFileType(imageUrl)) {
      return (
        <div className='image_url_preview'>
          <label>Image Preview</label>
          <div className='image_url_preview_image'>
            <img src={imageUrl} />
          </div>
        </div>
      );
    };
    return null;
  }
}
