import "phoenix_html";
// import socket from "./socket";
import React from "react";
import {render} from "react-dom";

// import { WellbeingFormContainer } from './wellbeing';
switch (document.location.pathname){
  case "/wellbeings/new": renderWellbeingForm(); break;
  case "/deeds/new":
  case "/deeds":
  renderNewDeedForm(); break;
}

function renderNewDeedForm(){
  navigator.geolocation.getCurrentPosition(function(position){
    $("#location-unknown").hide()
    let {latitude, longitude } = position.coords
    $("#deed_location_data").val(JSON.stringify({
      type: "Point",
      coordinates: [latitude,longitude]
    }));
    $("#location-tracked").removeClass("hidden")
  }, function(error){
    $("#location-unknown").hide()
    $("#location-denied").removeClass("hidden")
  })
}

function renderWellbeingForm(){
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
