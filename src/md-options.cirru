
var
  hljs $ require :highlight.js

require :highlight.js/styles/github.css

= module.exports $ object
  :html false
  :breaks true
  :langPrefix :language-
  :linkify true
  :highlight $ \ (code lang)
    var result $ hljs.highlight lang code
    return result.value
