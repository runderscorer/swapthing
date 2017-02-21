class ImagePreview extends React.Component {
  displayImagePreview() {
    const { imageUrl } = this.props;

    if (imageUrl) {
      return(
        <div className='image_url_preview'>
          <img src={imageUrl} style={{ maxHeight: '300px' }} />
        </div>
      );
    }
  }

  render () {
    return(
      <div>
        {this.displayImagePreview()}
      </div>
    );
  }
}

