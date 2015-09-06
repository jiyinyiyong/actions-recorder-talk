
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
        title null :Workflow
        meta $ object (:charset :utf-8)
        link $ object (:rel :icon)
          :href :images/sedum-icon.png
        link $ {} (:rel :stylesheet) (:href data.style)
        script $ object (:src data.vendor) (:defer true)
        script $ object (:src data.main) (:defer true)
      body null
        React.renderToString (Page)
