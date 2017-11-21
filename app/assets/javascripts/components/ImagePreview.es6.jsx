class ImagePreview extends React.Component {
  validFileType(src) {
    return ['.jpg', '.jpeg', '.gif', '.png'].includes(src.substr(src.lastIndexOf('.'), src.length));
  }

  render () {
    const { imageUrl } = this.props;
    if (imageUrl && this.validFileType(imageUrl)) {
      return (
        <div className='image_url_preview'>
          <img src={imageUrl} />
        </div>
      );
    };
    return null;
  }
}
