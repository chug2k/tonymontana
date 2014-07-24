class Dashing.Chartjs extends Dashing.Widget

@accessor 'current', Dashing.AnimatedValue

ready: ->
  @chart = new Highcharts.Chart(
    chart:
      renderTo: @node
  )

onData: (data) ->
  @chart = new Highcharts.Chart(
    @get('data')
  )
