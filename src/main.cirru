
var
  React $ require :react
  Markdown $ React.createFactory $ require :react-remarkable
  keycode $ require :keycode
  classnames $ require :classnames
  slides $ require :../slides.md
  reader $ require :./util/reader
  mdOptions $ require :./md-options

var
  div $ React.createFactory :div

var blocks $ reader.read slides

var App $ React.createClass $ object
  :displayName :app-root

  :getInitialState $ \ ()
    return $ object
      :cursor 0

  :componentDidMount $ \ ()
    window.addEventListener :keydown this.onWindowKeydown

  :componentWillUnmount $ \ ()
    window.removeEventListener :keydown this.onWindowKeydown

  :moveUp $ \ ()
    this.setState $ object
      :cursor $ Math.max (- this.state.cursor 1) 0

  :moveDown $ \ ()
    this.setState $ object
      :cursor $ Math.min (+ this.state.cursor 1) (- blocks.length 1)

  :onWindowKeydown $ \ (event)
    switch (keycode event.keyCode)
      :up
        event.preventDefault
        this.moveUp
      :down
        event.preventDefault
        this.moveDown

  :onTitleClick $ \ (index)
    this.setState $ object
      :cursor index

  :onSlideClick $ \ (event)
    event.preventDefault
    if (is event.target.tagName :A) $ do
      window.open event.target.href

  :renderSlides $ \ ()
    return $ blocks.map $ \\ (block index)
      var style $ object
        :top $ * innerHeight (- index this.state.cursor)
      return $ div
        object (:className :slide) (:key index) (:style style)
        Markdown $ object (:source block.content)
          :options mdOptions

  :renderTitles $ \ ()
    return $ blocks.map $ \\ (block index)
      var className $ classnames :title $ object
        :is-active $ is index this.state.cursor
      var onTitleClick $ \\ ()
        this.onTitleClick index
      var style $ object
        :top $ + (/ innerHeight 2)
          * 50 (- index this.state.cursor)
      return $ div
        object (:className className) (:key index) (:style style)
          :onClick onTitleClick
        , block.title

  :render $ \ ()
    return $ div (object (:className :app-root))
      div
        object (:className :slides)
          :onClick this.onSlideClick
        this.renderSlides
      div (object (:className :titles))
        div (object (:className :mark))
        this.renderTitles

React.render (React.createElement App) document.body
