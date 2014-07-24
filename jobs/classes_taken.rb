# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '300s', :first_in => 0 do |job|
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


  # urgh
  data = {
    labels: [
      'Mo 5:30p - Pac Heights',
      'Tu 6:00a - Dolores',
      'Tu 7:00p - Dolores',
      'Tu 9:00a - Dolores',
      'Tu 6:30p - Embarcadero',

      'We 5:30p - Pac Heights',
      'Th 6:00a - Dolores',
      'Th 7:00p - Dolores',
      'Th 9:00a - Dolores',
      'Th 6:30p - Embarcadero'



    ],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [5, 4, 9, 15, 12, 13, 5, 2, 10, 2]
        }
    ]
  }

  send_event('attendance_by_class', data);


end