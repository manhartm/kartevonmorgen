# Copyright (c) 2015 - 2016 Markus Kohlhase <mail@markus-kohlhase.de>

React    = require "react"
T        = React.PropTypes
URLs     = require "../constants/URLs"
pkg      = require "json!../../package.json"
{ pure } = require "recompose"

{ div, p, a, h2, h3, h4, br, button, i} = React.DOM

module.exports = pure React.createClass

  displayName: "Workshops"

  render: ->
    t = (x) -> x
    div className: "info",
      h3 null, t "workshop.heading"

      h2 null, t "workshop.paragraph1.heading"

      p null, t "workshop.paragraph1.text.1"

      p null, t "workshop.paragraph1.text.2"

      p null, t "workshop.paragraph1.text.3"