import "phoenix_html";
// import socket from "./socket";
import React from "react";
import {render} from "react-dom";
import { WellbeingForm } from './wellbeing';

if (document.location.pathname == "/wellbeings/new"){
  render((<WellbeingForm/>), document.getElementById("react-app"))
}
