class ImagePreview extends React.Component {
  displayImagePreview() {
    const { imageUrl } = this.props;

    if (imageUrl) {
      return <img src={imageUrl} style={{ maxHeight: '300px' }} />
    } else {
      return <p>No image preview</p>
    }
  }

  render () {
    return(
      <div class='image_url_preview'>
        {this.displayImagePreview()}
      </div>
    );
  }
}

