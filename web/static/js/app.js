import "phoenix_html";
// import socket from "./socket";
import React from "react";
import {render} from "react-dom";
import { WellbeingFormContainer } from './wellbeing';

if (document.location.pathname == "/wellbeings/new"){
  render((<WellbeingFormContainer />), document.getElementById("react-app"))
}
