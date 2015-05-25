
var
  stir $ require :stir-template
  (object~ html head title meta script body div link) stir

= module.exports $ \ (data)
  return $ stir.render
    stir.doctype
    html null
      head null
        title null ":Sedum Slide"
        meta $ object (:charset :utf-8)
        script $ object (:src data.main) (:defer true)
        link $ object (:rel :icon)
          :href :images/sedum-icon.png
        link $ object (:rel :stylesheet)
          :href :style/main.css
      body null
        div null :empty
