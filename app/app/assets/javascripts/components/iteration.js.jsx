

class Iteration extends React.Component {

  constructor(props) {
    super(props);
    this.getURL = this.getURL.bind(this);
  }

  getInterval(created_at, ended) {
    return this.getDateFormatted(new Date(created_at));
  }

  getDateFormatted(date) {
    // return (date.getMonth() + 1) + '/' + date.getDate();
    return this.props.date.id + '. ' + date.getFullYear();
  }

  getURL() {
    return "/admin/export_zip/" + this.props.data.id;
    // $.get("/admin/export_zip/" + this.props.data.id, data => {
    //   console.log(data);
    // });
  }

  render() {
    return (
      <div className="iteration">
        <a className="btn btn-outline-primary" href={this.getURL()}>{this.getInterval(this.props.data.created_at, this.props.data.ended)}</a>
      </div>
    )
  }

}
