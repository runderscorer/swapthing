class InviteForm extends React.Component {
  constructor() {
    super();
    this.state = {
      emails: [],
      inputValue: ''
    };
    this.emailFormData = this.emailFormData.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.handleClick = this.handleClick.bind(this);
    this.renderEmailList = this.renderEmailList.bind(this);
    this.removeEmail = this.removeEmail.bind(this);
    this.validateEmail = this.validateEmail.bind(this);
  }

  emailFormData() {
    return this.state.emails.map((email, i) => {
      return (
        <input type='hidden' name='emails[]' value={email} />
      );
    });
  }

  handleChange(inputValue) {
    this.setState({ inputValue });
  }

  handleClick() {
    const { emails, inputValue } = this.state;
    if (inputValue.length > 0) {
      this.setState({
        emails: [...emails, inputValue],
        inputValue: ''
      });
    };
  }

  removeEmail(index) {
    this.setState({
      emails: this.state.emails.filter((email, i) => { return i != index })
    });
  }

  renderEmailList() {
    const { emails } = this.state;
    const emailList = emails.map((email, i) => {
      return <ListItem clickHandler={this.removeEmail} index={i} key={i} name={email} />;
    });

    return <div className='list-items'>{emailList}</div>;
  }

  renderSubmitButton() {
    return (
      <div>
        <input type='submit' className='button-primary' value='Send Invites' />
      </div>
    )
  }

  validateEmail(value) {
    return (
      value.match(/^([\w.%+-]+)@([\w-]+\.)+([\w]{2,})$/i) ?
      true :
      false
    );
  }

  render() {
    return (
      <form action={`/events/${this.props.eventId}/invites`} method='post'>
        <SingleInput
          buttonValue='Add'
          changeCallback={this.handleChange}
          clickCallback={this.handleClick}
          id='emails'
          inputValue={this.state.inputValue}
          labelValue='Enter Email Address'
          validatorCallback={this.validateEmail}
        />
        <input type='hidden' name='authenticity_token' value={this.props.authenticityToken} />
        {this.renderEmailList()}
        {this.emailFormData()}
        {this.state.emails.length ? this.renderSubmitButton() : ''}
      </form>
    )
  }
}
