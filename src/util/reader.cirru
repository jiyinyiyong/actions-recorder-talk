
= exports.read $ \ (slides)

  var divider /\n---+\n

  var blocks $ slides.split divider

  return $ blocks.map $ \ (block)
    var block $ block.trim
    var lines $ block.split /\n
    var afterLines $ lines.slice 1
    var title $ . lines 0
    return $ object
      :title $ title.replace /^#+\s :
      :content $ afterLines.join ":\n"
