# Copyright (c) 2015 - 2016 Markus Kohlhase <mail@markus-kohlhase.de>

React    = require "react"
{ pure } = require "recompose"
T        = React.PropTypes
URLs     = require "../constants/URLs"
pkg      = require "json!../../package.json"

{ div, p, a, h2, h3, h4, br, button, i}  = React.DOM

module.exports = pure React.createClass

  displayName: "Info"

  render: ->
    t = (x) -> x
    div className: "info",
      h2 null, t "info.heading"
      p null, t "info.text.1"
      p null, t "info.text.2"
      p null, t "info.text.3"
      p null, t "info.text.4"

      p null, t "info.text.5"

      p null, t "info.text.6"
      p null,
        i className: "fa fa-globe"
        " "
        a href: URLs.PROTOTYPE.link, URLs.PROTOTYPE.name
        br null
        i className: "fa fa-facebook"
        " "
        a href: URLs.FACEBOOK.link, URLs.FACEBOOK.name,
        br null
        i className: "fa fa-envelope-o"
        " "
        a href: URLs.MAIL.link, URLs.MAIL.name
        br null
        i className: "fa fa-github"
        " "
        a href: URLs.REPOSITORY.link, URLs.REPOSITORY.name
      br null
      br null
      h2 null, t "info.paragraph1.heading"
      p null, t "info.paragraph1.text"
      p null, a href: URLs.REPOSITORY.link, URLs.REPOSITORY.name

      p className: "version",
        (t "info.clientVersion")+" v#{pkg.version}"
      if (sv = @props.server?.version)?
        p className: "version",
          (t "info.clientVersion")+" v#{sv}"
