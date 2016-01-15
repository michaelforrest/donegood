import "phoenix_html";
// import socket from "./socket";
import React from "react";
import {render} from "react-dom";

import Select from "react-select";

// import { WellbeingFormContainer } from './wellbeing';
switch (document.location.pathname){
  case "/wellbeings/new": renderWellbeingForm(); break;
  case "/deeds/new":
  case "/deeds":
  renderNewDeedForm(); break;
}
console.log("adding gmaps callback");

function renderNewDeedForm(){
  console.log("rendering new deeds form");
  $.getScript("https://maps.googleapis.com/maps/api/js?key=AIzaSyAiEeHbpDSFnzSWdud2E1FBhQZOYfXhF5A&libraries=places", function(){
    let input = document.getElementById("location-autocomplete")
    let autocomplete = new google.maps.places.SearchBox(input, {types:["(regions)"]});
    let onPlaceChanged = function(){
      let place = autocomplete.getPlace();
      console.log(place);
      let lat = place.geometry.location.lat()
      let lng = place.geometry.location.lng()
      let data = {
        point:{coordinates: [lat, lng], srid: 4326},
        name: place.name,
        place_id: place.place_id,
        types: place.types,

      }
      $("#deed_location_data").val(JSON.stringify(data))
    }

    $(input).keydown(function (e) {
      const ENTER = 13;const TAB = 9;
      if(event.keyCode == ENTER || event.keyCode == TAB) {
        debugger;
        return false;
      }
    });
    autocomplete.addListener("place_changed", onPlaceChanged)
  });

  // var getOptions = function(input, callback) {
  //   var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+input+"&key=AIzaSyAiEeHbpDSFnzSWdud2E1FBhQZOYfXhF5A&callback=?";
  //   console.log("Get", url);
  //   $.getJSON(url).done(function(error, data){
  //     console.log(error, data);
  //     callback(error, {
  //       options: data.map(function(item){
  //         return {value: item.value, label: item.label}
  //       }),
  //       complete: false // set to true if more are not available - so never here.
  //     })
  //   })
  // };
  // function logChange(val) {
  //     console.log("Selected: " + val);
  // }
  // render((<Select
  //     name="location"
  //     asyncOptions={getOptions}
  //     onChange={logChange}
  // />), document.getElementById("location-select"))


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
