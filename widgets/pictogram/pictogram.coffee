class Dashing.Pictogram extends Dashing.Widget

  ready: ->
    if @get('value')
      @renderPictoWrapper(@get('value'))


  onData: (data) ->
   @renderPictoWrapper(data.value)

  renderPictoWrapper: (numImages) ->
    @set('items', [0...numImages].map () -> {'object': 'dummy'})

    # Now fit the images inside this container.
    imgWidth = 43
    imgHeight = 131

    containerWidth = 276
    containerHeight = 150


#    bestRatioDiffSoFar = 100
#    optimalScale = 1
#    for numRows in [1...numImages]
#      numCols = numImages / numRows
#      scaleFactor = containerWidth / (numCols * imgWidth)
#      console.log('trying to fit ', numImages, 'in ', numRows, 'rows', 'scale would be ', scaleFactor)
#      continue if scaleFactor >= 1
#      totalHeight = scaleFactor * imgHeight * numRows
#      while(totalHeight > containerHeight)
#        scaleFactor -= 0.01;
#        totalHeight = scaleFactor * imgHeight * numRows
#      totalWidth = scaleFactor * imgWidth * numCols
#
#
#
#      endRatio = totalWidth / totalHeight
#      ratioDiff = Math.abs(containerWidth / containerHeight - endRatio)
#      if ratioDiff < bestRatioDiffSoFar
#        optimalScale = scaleFactor
#        bestRatioDiffSoFar = ratioDiff

    # Let's do something much stupider. Because I am stupider.


    @width = imgWidth # * optimalScale
    @height = imgHeight # * optimalScale

    $('.picto-wrapper').hide()

    tryResize = =>
      if $('.picto-wrapper').height() > containerHeight

        @set('width', @width * 0.8)
        @set('height', @height * 0.8)
        setTimeout tryResize, 10
      else
        $('.picto-wrapper').fadeIn()

    setTimeout tryResize, 100




