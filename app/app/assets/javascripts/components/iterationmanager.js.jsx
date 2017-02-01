
class IterationManager extends React.Component {

  constructor(props) {
    super(props);
    this.state = {past: this.props.data};
    this.addIteration = this.addIteration.bind(this);
  }

  addIteration(prev) {
    this.setState({past: this.state.past.concat(prev)});
  }

  render() {
    return (
      <div className="iteration-manager">
        <div className="row">
          <div className="col-sm-2 iteration-list">
            {this.state.past.map(i => {
              return <Iteration key={i.id} data={i}/>
            })}
          </div>
          <div className="col-sm-8">
            <IterationControl
              info={this.props.info}
              data={this.props.current}
              onEnd={this.addIteration}/>
          </div>
        </div>
      </div>
    )
  }

}
