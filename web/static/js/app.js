import "deps/phoenix_html/web/static/js/phoenix_html";
// import socket from "./socket";
import React from "react";
import ReactDOM from "react-dom";
import {ThingComponent} from "./thing"
var Hello = React.createClass({
  render: function() {
    return <div>Hello {this.props.name}</div>;
  }
});


ReactDOM.render(
  <ThingComponent />,
  document.getElementById('app')
);
