
var
  React $ require :react

require :highlight.js/styles/github.css
require :../style/main.css

var
  Page $ React.createFactory $ require :./app/page

React.render (Page) document.body
window.addEventListener :resize $ \ ()
  React.render (Page) document.body
