
var
  React $ require :react
  Markdown $ require :react-remarkable
  keycode $ require :keycode
  classnames $ require :classnames
  slides $ require :../slides.md
  reader $ require :./util/reader

var
  div $ React.createFactory :div

var blocks $ reader.read slides

var App $ React.createClass $ object
  :displayName :app-root

  :getInitialState $ \ ()
    return $ object
      :cursor 0
      :focus false

  :componentDidMount $ \ ()
    window.addEventListener :keyDown this.onWindowKeydown

  :componentWillUnmount $ \ ()
    window.removeEventListener :keyDown this.onWindowKeydown

  :moveUp $ \ ()
    this.setState $ object
      :cursor $ - this.state.cursor 1

  :moveDown $ \ ()
    this.setState $ object
      :cursor $ + this.state.cursor 1

  :onFocusToggle $ \ ()
    this.setState $ object
      :focus $ not this.state.focus

  :onWindowKeydown $ \ (event)
    switch (keycode event.keyCode)
      :up
        event.preventDefault
        this.moveUp
      :down
        event.preventDefault
        this.moveDown
      :space
        event.preventDefault
        this.onFocusToggle

  :onTitleClick $ \ (index)
    this.setState $ object
      :cursor index

  :renderSlides $ \ ()
    return $ blocks.map $ \ (block index)
      return $ div
        object (:className :slide) (:key index)
        , block.content

  :renderTitles $ \ ()
    return $ blocks.map $ \\ (block index)
      var className $ classnames :title $ object
        :is-active $ is index this.state.cursor
      var onTitleClick $ \\ ()
        this.onTitleClick index
      return $ div
        object (:className className) (:key index)
          :onClick onTitleClick
        , block.title

  :render $ \ ()
    return $ div (object (:className :app-root))
      div (object (:className :slides))
        this.renderSlides
      div (object (:className :titles))
        this.renderTitles

React.render (React.createElement App) document.body
