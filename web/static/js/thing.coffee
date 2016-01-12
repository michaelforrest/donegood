React = require 'react'
ThingComponent = React.createClass
  render: ->
    console.log "deeds", @props.deeds, @props.deeds.map
    React.DOM.ul null,
      @props.deeds.map (deed)->
        React.DOM.li
          className: "deed"
          key: deed.id
          deed.title

ThingComponentContainer = React.createClass
  getInitialState: ->
    deeds: []

  componentDidMount: ->
    $.ajax
      url: "/deeds"
      dataType: "json",
      success: (json)=>
        @setState deeds: json.data

  render: ->
    React.createElement ThingComponent, deeds: @state.deeds

module.exports =
  ThingComponent: ThingComponent
  ThingComponentContainer: ThingComponentContainer
