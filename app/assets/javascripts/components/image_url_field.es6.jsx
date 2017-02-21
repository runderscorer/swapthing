class ImageUrlField extends React.Component {
  constructor(props) {
    super(props)
    this.state = { imageUrl: this.props.imageUrl || '' }

    this.handleImageUrlChange = this.handleImageUrlChange.bind(this)
  }

  handleImageUrlChange(event) {
    this.setState({ imageUrl: event.target.value })
  }

  render () {
    const { imageUrl } = this.state;

    return(
      <div>
        <label name='item_image_url'>Image URL</label>
        <input 
          name='item[image_url]' 
          type='text' 
          value={this.state.imageUrl}
          onChange={this.handleImageUrlChange}
          placeholder='www.amazon.com/movies/terminator_2.jpg'
        />

        <ImagePreview imageUrl={imageUrl} />
      </div>
    )
  }
}

