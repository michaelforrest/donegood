import "phoenix_html";
// import socket from "./socket";
import React from "react";
import {render} from "react-dom";

// import { WellbeingFormContainer } from './wellbeing';
if (document.location.pathname == "/wellbeings/new"){
  // render((<WellbeingFormContainer />), document.getElementById("react-app"))
  // Here is the sort of nonsense I'd avoid if I knew how to
  // integrate React properly!
  $(".add-note").click(function(event){
    event.preventDefault();
    let field = $(event.target).data("field");
    let $notes = $("#" + field + "-note")
    if ($notes.hasClass("hidden")){
      $notes.removeClass("hidden");
      $(event.target).html("[x]")
    }else{
      let $textarea = $notes.find("textarea");
      if ($textarea.val() == "" || confirm("Clear this note?")){
        $textarea.val("");
        $notes.addClass("hidden");
        $(event.target).html("[+]")
      }
    }
  })
}
