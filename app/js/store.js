(function() {
  window.DB = function(key) {
    var store;
    store = window.localStorage;
    return {
      get: function() {
        return JSON.parse(store[key] || '{}');
      },
      put: function(data) {
        return store[key] = JSON.stringify(data);
      }
    };
  };

}).call(this);
