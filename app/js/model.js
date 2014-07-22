(function() {
  window.List = function(db) {
    var items, self;
    db = db || DB('generator-riotjs');
    self = riot.observable(this);
    items = db.get();
    self.add = function(str) {
      var item;
      item = {
        id: '_' + ('' + Math.random()).slice(2),
        desc: str
      };
      items[item.id] = item;
      return self.trigger('add', item);
    };
    return self.on('add', function() {
      return db.put(items);
    });
  };

}).call(this);
