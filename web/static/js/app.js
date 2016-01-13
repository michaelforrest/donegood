import "phoenix_html";
// import socket from "./socket";
import React from "react";
import ReactDOM from "react-dom";
import { Router, Route, Link, browserHistory } from 'react-router';

import { WellbeingForm } from './wellbeing';
console.log("React", React);
class Thing extends React.Component{
  render(){
    return (<h1>Hello! WHY?</h1>)
  }
}

ReactDOM.render((
  <Thing />
), document.getElementById("react-app"));

ReactDOM.render((
  <Router history={browserHistory}>
    <Route path="/" component={Hello}>
      <Route path="wellbeings/new" component={WellbeingForm}/>
    </Route>
  </Router>
), document.getElementById("react-app"));
