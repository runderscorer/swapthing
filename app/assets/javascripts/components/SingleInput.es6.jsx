class SingleInput extends React.Component {
  constructor() {
    super();
    this.state = {
      value: '',
      validInput: true
    }
    this.handleChange = this.handleChange.bind(this);
    this.handleClick = this.handleClick.bind(this);
    this.renderFormError = this.renderFormError.bind(this);
  }

  handleChange(e) {
    const { changeCallback, validatorCallback } = this.props;

    this.setState({ validInput: validatorCallback(e.target.value) });
    changeCallback(e.target.value);
  };

  handleClick(e) {
    e.preventDefault();
    this.props.clickCallback(this.state.value);
  }

  renderFormError() {
    const { inputValue } = this.props;
    const { validInput } = this.state;

    if (inputValue && !validInput) return (
      <span className='error'>Invalid email</span>
    );
  }

  render() {
    return (
      <div>
        <div className='single-input'>
          <label htmlFor={this.props.id}>{this.props.labelValue}</label>
          <input
            id={this.props.id}
            onChange={this.handleChange}
            type='text'
            value={this.props.inputValue}
          />
          <button
            disabled={!this.state.validInput}
            onClick={this.handleClick}
          >{this.props.buttonValue}
          </button>
        </div>
        {this.renderFormError()}
      </div>
    );
  }
}
