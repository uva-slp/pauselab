

class Iteration extends React.Component {

  constructor(props) {
    super(props);
  }

  getInterval(created_at, ended) {
    return this.getDateFormatted(new Date(created_at));
  }

  getDateFormatted(date) {
    return (date.getMonth() + 1) + '/' + date.getDate();
  }

  render() {
    return (
      <div className="iteration">
        <span>{this.getInterval(this.props.data.created_at, this.props.data.ended)}</span>
      </div>
    )
  }

}
