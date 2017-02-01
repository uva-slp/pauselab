
class IterationControl extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      current: this.props.data.status,
      id: this.props.data.id,
      created_at: this.props.data.created_at,
      updated_at: this.props.data.updated_at,
      info: this.props.info
    };
    console.log(this.props.info)
    this.nextPhase = this.nextPhase.bind(this);
    this.endPhase = this.endPhase.bind(this);
  }

  getDate(date_str) {
    let d = new Date(date_str);
    return d.getMonth() + 1 + '/' + d.getDate();
  }

  nextPhase() {
    const self = this;
    $.get("/admin/next_phase", (data) => {
      self.setState({current: data.status, updated_at: new Date()});
    });
  }

  endPhase() {
    const self = this;
    if (confirm("are you sure?")) {
      $.get("/admin/end_phase", (data) => {
        // console.log(data)
        self.setState({
          current: data.current.status,
          id: data.current.id,
          created_at: data.current.created_at,
          updated_at: data.current.updated_at
        });
        self.props.onEnd(data.prev);
        self.setState({ideas: 0, votes: 0, blogs: 0, proposals: 0});
      });
    }
  }

  render() {

    let phase_btn = null
    if (this.state.current != "progress") {
      phase_btn = <button
        className="btn btn-primary phase-btn"
        onClick={this.nextPhase}>next phase</button>
    } else {
      phase_btn = <button
        className="btn btn-primary phase-btn"
        data-toggle="tooltip"
        title='this will start a new iteration'
        onClick={this.endPhase}>end iteration</button>
    }

    return (
      <div className="iteration-control">
        <div className="iteration-progress">
          currently on: <span>{this.state.current}</span> since {this.getDate(this.state.updated_at)}
        </div>
        <div className="iteration-stats">
          <ul>
            <li>ideas: {this.state.info.ideas}</li>
            <li>votes: {this.state.info.votes}</li>
            <li>blogs: {this.state.info.blogs}</li>
            <li>proposals: {this.state.info.proposals}</li>
          </ul>
        </div>
        <div>
          {phase_btn}
        </div>
      </div>
    )
  }

}
