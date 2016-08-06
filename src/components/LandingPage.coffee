# Copyright (c) 2015 - 2016 Markus Kohlhase <mail@markus-kohlhase.de>

React         = require "react"
T             = React.PropTypes
logo          = require "../img/logo.png"
CityList      = require "./CityList"
Info          = require "./Info"
Workshop      = require "./Workshop"
Imprint       = require "./Imprint"
Explain       = require "./LandingExplain"
URLs          = require "../constants/URLs"
V             = require "../constants/PanelView"
{ pure }      = require "recompose"
#{ translate } = require 'react-i18next';

{ div, h1, h2, h3, h4, br, input, button, ul, li, a, img, p, strong, hr, i } = React.DOM

module.exports = pure React.createClass

  displayName: "LandingPage"

  propTypes:
    content     : T.string
    searchText  : T.string
    cities      : T.array
    onChange    : T.func
    onEscape    : T.func
    onSelection : T.func

  onChange: (ev) ->
    return unless (v = ev.target?.value)?
    @props.onChange? v

  onKeyUp: (ev) ->
    ev.preventDefault()
    switch ev.key
      when "Escape" then @props.onEscape?()
      when "Enter"  then @props.onSelection? @props.cities?[0]

  render: ->
#    { t } = @props
    t = (x) -> x
    { content, searchText, cities, onSelection } = @props
    onClick = @props.onMenuItemClick
    div className: "landing",
      div className: "banner",
        div className: "content pure-g",
          div className:"logo pure-u-2-5",
            a onClick: (-> onClick 'landing'), href:"#",
              img src: logo
          div className:"pure-u-3-5",
            div className:"menu pure-menu pure-menu-horizontal",
              ul className:"pure-menu-list",
                li className:"pure-menu-item",
                  a onClick: (-> onClick 'map'), href:"#", className:"pure-menu-link", t "menu.map"
                li className:"pure-menu-item", "|"
                li className:"pure-menu-item",
                  a onClick: (-> onClick 'new'), href:"#", className:"pure-menu-link", t "menu.addEntry"
                li className:"pure-menu-item", "|"
                li className:"pure-menu-item",
                  a onClick: (-> onClick V.WORKSHOP), href:"#", className:"pure-menu-link", t "menu.workshops"
                li className:"pure-menu-item", "|"
                li className:"pure-menu-item",
                  a href:"https://www.facebook.com/vonmorgen", className:"pure-menu-link", t "menu.news"
                li className:"pure-menu-item", "|"
                li className:"pure-menu-item",
                  a onClick: (-> onClick V.INFO), href:"#", className:"pure-menu-link", t "menu.contact"
                li className:"pure-menu-item", "|"
                li className:"pure-menu-item",
                  a onClick: (-> onClick V.DONATE), href:"#", className:"pure-menu-link", t "menu.donate"

      div className: "search",
        div className: "content",
          h1 null, t "slogan"
          div className:"place-search",
            div className: "pure-g pure-form",
              input
                className   : "pure-u-1"
                onChange    : @onChange
                onKeyUp     : @onKeyUp
                value       : searchText or ''
                type        : 'text'
                placeholder : t "discover"
              if cities?.length > 0
                div className: "pure-u-1",
                  React.createElement CityList,
                    cities  : cities
                    onClick : onSelection

      div className: "explain",
        if content is null
          a href: "#tutorial", className: "circleTutorial",
            strong null,
              "Tutorial",
              div style: { paddingTop: "10px", fontSize: "12px"},
                i className: "fa fa-chevron-down"
        div className: "content",

          if content is null
            React.createElement Explain,
              onClick: onClick
          else
            switch content

              when V.TEAM
                React.createElement Explain,
                  onClick: onClick
              when V.SUPPORTERS
                React.createElement Explain,
                  onClick: onClick

              when V.IMPRINT
                React.createElement Imprint

              when V.INFO
                React.createElement Info

              when V.WORKSHOP
                React.createElement Workshop

              when V.MAP_INFO
                React.createElement Info

              when V.OPEN_SOURCE
                React.createElement Info

              when V.DONATE
                div null,
                  h2 null, t "donate.heading"
                  p null, t "donate.text.1"
                  p null, t "donate.text.2"
                  p null,
                    t "donate.text.3"
                    a href: URLs.DONATE.link, URLs.DONATE.name
                  p null, t "donate.text.4"
                  p null, t "donate.ending"

              when V.JOIN
                div null,
                  h3 null, t "join.heading.1"

                  p null, t "join.text.1"
                  p null,
                    a href: URLs.JOB_ADS.link, URLs.JOB_ADS.name
                  h3 null, t "join.heading.2"
                  p null, t "join.text.2"
                  p null, t "join.text.3"
                    br null
                    a href: "mailto:netzwerk@kartevonmorgen.org",
                      "netzwerk@kartevonmorgen.org"

      div className: "footer",
        h3 null, t "footer.heading"
        p null,
          t "footer.contact"
          a href: URLs.MAIL.link, URLs.MAIL.name
          br null
          t "footer.socialMedia"
          a href: URLs.FACEBOOK.link, URLs.FACEBOOK.name,
          br null
          t "footer.openSource"
          a href: URLs.REPOSITORY.link, URLs.REPOSITORY.name
        p null,
          a href:"#", onClick: (-> onClick V.IMPRINT),
            t "footer.impressum"
