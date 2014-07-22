window.List = (db) ->
  db = db || DB('generator-riotjs')
  self = riot.observable(this)
  items = db.get()
  self.add = (str) ->
    item =
      id: '_' + ('' + Math.random()).slice(2)
      desc: str
    items[item.id] = item
    self.trigger('add', item)

  self.on 'add', ->
    db.put(items)
