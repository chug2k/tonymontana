# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '10000s', :first_in => 0 do |job|
  num_classes = 30
  num_classes_last = 10
  cost_per_class = 20.0
  calories_per_class = 481

  steps_per_class = 2093

  send_event('classes_taken', { current: num_classes, last: num_classes_last })
  send_event('cost_month', { current: num_classes * cost_per_class})
  send_event('cost_calorie', { current: '%.4f' % (cost_per_class / calories_per_class) })
  send_event('steps_taken', { current: num_classes * steps_per_class, last: num_classes_last * steps_per_class })
  send_event('calories_burned', { current: num_classes * calories_per_class, last: num_classes_last * calories_per_class})


  series = [
      {
          name: 'Classes',
          data: [
              {x:0, y: 4}, {x:1, y:9}, {x:2, y:6}, {x:3, y: 3},
              {x:4, y: 1}, {x:5, y:2}, {x:6, y:7}, {x:7, y: 3},
              {x:8, y: 4}, {x:9, y:2}
          ]
      }

  ]

  send_event('attendance_by_class', series: series, xAxisLabels: {});

end