class NewItemForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      name: '',
      url: '',
      image_url: '',
      description: '',
      notes: '',
      price: 0
    }

    this.handleNameChange = this.handleNameChange.bind(this);
    this.handleNotesChange = this.handleNotesChange.bind(this);
    this.handleUrlChange = this.handleUrlChange.bind(this);
    this.handleImageUrlChange = this.handleImageUrlChange.bind(this);
    this.handlePriceChange = this.handlePriceChange.bind(this);
  }

  renderNameField() {
    const { name } = this.state;

    return(
      <div>
        <label name='item_name'>Item Name</label>
        <input 
          name='item_name' 
          placeholder='Terminator 2' 
          type='text'
          value={name}
          onChange={this.handleNameChange}
        />
      </div>
    )
  }

  renderNotesField() {
    const { notes } = this.state;

    return(
      <div>
        <label name='notes'>Notes</label>
        <input 
          name='item_notes' 
          placeholder='Special edition Bluray' 
          type='text' 
          value={notes}
          onChange={this.handleNotesChange}
        />
      </div>
    )
  }

  renderUrlField() {
    const { url } = this.state;

    return(
      <div>
        <label name='item_url'>URL</label>
        <input 
          name='item_url' 
          placeholder='www.hastalavistababy.com/illbeback' 
          type='text'
          value={url}
          onChange={this.handleUrlChange}
        />
      </div>
    )
  }

  renderImageUrlField() {
    const { imageUrl } = this.state;

    return(
      <div>
        <label name='item_image_url'>Image URL</label>
        <input 
          name='item_image_url' 
          placeholder='www.terminatorpics.org/2' 
          type='text'
          value={imageUrl}
          onChange={this.handleImageUrlChange}
        />
      </div>
    )
  }

  renderPriceField() {
    const { price } = this.state;

    return(
      <div>
        <label name='item_price'>Price</label>
        <input 
          name='item_price' 
          placeholder='20' 
          type='text'
          value={price}
          onChange={this.handlePriceChange}
        />
      </div>
    )
  }

  handleNameChange(event) {
    this.setState({ name: event.target.value });
  }

  handleNotesChange(event) {
    this.setState({ notes: event.target.value });
  }

  handleUrlChange(event) {
    this.setState({ url: event.target.value });
  }

  handlePriceChange(event) {
    this.setState({ price: event.target.value });
  }

  handleImageUrlChange(event) {
    this.setState({ imageUrl: event.target.value });
  }

  newItemSubmit(event) {
    event.preventDefault()

    console.log('submitted')
  }

  render () {
    const { imageUrl } = this.state;

    return(
      <div className='twelve columns form_container'>
        <div className='fields_container'>  
          <form onSubmit={this.newItemSubmit} >
            {this.renderNameField()}
            {this.renderNotesField()}
            {this.renderUrlField()}
            {this.renderImageUrlField()}
            {this.renderPriceField()}

            <input type='submit' className='button-primary' />
          </form>
        </div>
      </div>
    );
  }
}

