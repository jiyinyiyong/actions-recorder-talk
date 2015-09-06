
var
  hljs $ require :highlight.js

= module.exports $ {}
  :html false
  :breaks true
  :langPrefix :language-
  :linkify true
  :highlight $ \ (code lang)
    var result $ hljs.highlight lang code
    return result.value
