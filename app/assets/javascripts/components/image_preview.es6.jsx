class ImagePreview extends React.Component {
  validTypes() {
    return ['.jpg', '.jpeg', '.gif', '.png'];
  }

  displayImagePreview() {
    const { imageUrl } = this.props;

    if (imageUrl) {
      if (this.validateUrlByFileType(imageUrl)) {
        return(
          <div className='image_url_preview'>
            <img src={imageUrl} style={{ maxHeight: '300px' }} />
          </div>
        );
      }
    }
  }

  validateUrlByFileType(src) {
    let url = src;

    return this.validTypes().includes(url.substr(url.lastIndexOf('.'), url.length))
  }

  render () {
    return(
      <div>
        {this.displayImagePreview()}
      </div>
    );
  }
}

