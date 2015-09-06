
var
  stir $ require :stir-template
  React $ require :react
  (object~ html head title meta link script body div) stir

var
  Page $ React.createFactory $ require :./src/app/page

= module.exports $ \ (data)
  return $ stir.render
    stir.doctype
    html null
      head null
        title null ":Unidirection Data Flow"
        meta $ {} (:charset :utf-8)
        cond (not data.dev)
          link $ {} (:rel :icon)
            :href :images/sedum-icon.png
          , undefined
        link $ {} (:rel :stylesheet) (:href data.style)
        script $ {} (:src data.vendor) (:defer true)
        script $ {} (:src data.main) (:defer true)
      body null
        React.renderToString (Page)
