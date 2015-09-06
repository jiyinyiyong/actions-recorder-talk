
var
  React $ require :react
  Markdown $ React.createFactory $ require :react-remarkable
  keycode $ require :keycode
  classnames $ require :classnames

var
  slides $ require :../../slides.md
  reader $ require :../util/reader
  mdOptions $ require :../md-options

var
  viewHeight 600

var
  div $ React.createFactory :div

var blocks $ reader.read slides

= module.exports $ React.createClass $ {}
  :displayName :app-root

  :getInitialState $ \ ()
    {} (:cursor 0)

  :componentDidMount $ \ ()
    window.addEventListener :keydown this.onWindowKeydown

  :componentWillUnmount $ \ ()
    window.removeEventListener :keydown this.onWindowKeydown

  :moveUp $ \ ()
    this.setState $ {}
      :cursor $ Math.max (- this.state.cursor 1) 0

  :moveDown $ \ ()
    this.setState $ {}
      :cursor $ Math.min (+ this.state.cursor 1) (- blocks.length 1)

  :onWindowKeydown $ \ (event)
    switch (keycode event.keyCode)
      :up
        event.preventDefault
        this.moveUp
      :down
        event.preventDefault
        this.moveDown
    return undefined

  :onTitleClick $ \ (index)
    this.setState $ {}
      :cursor index

  :onSlideClick $ \ (event)
    event.preventDefault
    if (is event.target.tagName :A) $ do
      window.open event.target.href
    return undefined

  :renderSlides $ \ ()
    return $ blocks.map $ \\ (block index)
      var style $ {}
        :top $ * viewHeight (- index this.state.cursor)
      return $ div
        {} (:className :slide) (:key index) (:style style)
        Markdown $ {} (:source block.content)
          :options mdOptions

  :renderTitles $ \ ()
    blocks.map $ \\ (block index)
      var className $ classnames :title $ {}
        :is-active $ is index this.state.cursor
      var onTitleClick $ \\ ()
        this.onTitleClick index
      var style $ {}
        :top $ + (/ viewHeight 2)
          * 50 (- index this.state.cursor)
      div
        {} (:className className) (:key index) (:style style)
          :onClick onTitleClick
        , block.title

  :render $ \ ()
    var markStyle $ {}
      :top $ + (/ viewHeight 2)
        * 50 0
    div ({} (:className :app-root))
      div
        {} (:className :slides)
          :onClick this.onSlideClick
        this.renderSlides
      div ({} (:className :titles))
        div $ {} (:className :mark) (:style markStyle)
        this.renderTitles
