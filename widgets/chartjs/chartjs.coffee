class Dashing.Chartjs extends Dashing.Widget

  ready: ->
    $canvas = $('canvas', $(@node))

    # Wow, this is shitty.
    $container = $(@node).parent()
    if $container.data('sizex') == 3 && $container.data('sizey') == 1
      $canvas.attr 'width', 900
      $canvas.attr 'height', 250

    if @get('labels') && @get('datasets')
      @.renderGraph
        labels: @get('labels')
        datasets: @get('datasets')


  onData: (data) ->
    @.renderGraph(data)


  renderGraph: (data) ->
    $canvas = $('canvas', $(@node))
    if $canvas.get(0)
      ctx = $canvas.get(0).getContext('2d')
      ctx.clearRect(0, 0, $canvas.width, $canvas.height)
      chart = new Chart(ctx).Bar(data, showLabels: false)



