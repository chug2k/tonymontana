
window.DB = (key) ->
  store = window.localStorage

  {
    get: ->
      JSON.parse(store[key] || '{}')
    put: (data) ->
      store[key] = JSON.stringify(data)
  }