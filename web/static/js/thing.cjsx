React = require 'react'
ThingComponent = React.createClass
  render: ->
    <h1 className="thing">
      THING!
    </h1>

module.exports =
  ThingComponent: ThingComponent
