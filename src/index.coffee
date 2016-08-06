###
Copyright (c) 2015 - 2016 Markus Kohlhase <mail@markus-kohlhase.de>
###

(require 'es6-promise').polyfill() # required for redux-form

React                 = require "react"
ReactDOM              = require "react-dom"
App                   = require "./components/App"
store                 = require "./Store"
#{ I18nextProvider }   = require 'react-i18next'
#i18n                  = require './i18n' # initialized i18next instance

{ Provider, connect } = require "react-redux"

if __DEVELOPMENT__
  window.React = React
  { whyDidYouUpdate } = require 'why-did-you-update'
  whyDidYouUpdate React

ConnectedApp = (connect (s) -> s) App

rootElement  = document.querySelector '#app'

# inject the 'dispatch' method and the state
Wrapper = React.createElement Provider, { store },
  React.createElement ConnectedApp
  
#I18nWrapper = React.createElement I18nextProvider, { i18n },
#  React.createElement Wrapper

ReactDOM.render Wrapper, rootElement
#ReactDOM.render I18nWrapper, rootElement