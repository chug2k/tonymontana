class @Tony
  constructor: (conf) ->
    @self = riot.observable(this)
    @backend = new Backend()
    $.extend(@self, conf)

    # Initialize.
    # These arguments come from the direct script call in index.html.
    @backend.call('init', conf.page).always (data) =>
      @.trigger 'ready'
    .done (data) =>
      console.log 'triggering load', load, data
      @.trigger 'load', data.view


  load: (page, fn) ->
    @self.trigger 'before:load', page
    @self.one 'load', fn



