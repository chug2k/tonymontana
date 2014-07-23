(function() {
  this.instance = null;

  this.tony = riot.observable(function(arg) {
    var instance;
    if (!arg) {
      return instance;
    }
    if ($.isFunction(arg)) {
      return tony.on('ready', arg);
    } else {
      instance = new Tony(arg);
      return instance.on('ready', function() {
        return tony.trigger('ready', instance);
      });
    }
  });

}).call(this);

(function() {
  this.Backend = (function() {
    function Backend(conf) {
      this.cache = {};
      this.storage = window.localStorage;
    }

    Backend.prototype.call = function(method, arg, fn) {
      var promise;
      console.log('->', method);
      promise = new Promise(fn);
      console.log('promise', promise.done);
      promise.done(fn);
      return promise;
    };

    return Backend;

  })();

}).call(this);

(function() {
  this.Promise = (function() {
    function Promise(fn) {
      var self;
      self = riot.observable(this);
      ['done', 'fail', 'always'].map((function(_this) {
        return function(name) {
          return self[name] = function(arg) {
            if ($.isFunction(arg)) {
              return self.on(name, arg);
            } else {
              return self.trigger(name, arg);
            }
          };
        };
      })(this));
    }

    return Promise;

  })();

}).call(this);

(function() {
  this.Tony = (function() {
    function Tony(conf) {
      this.self = riot.observable(this);
      this.backend = new Backend();
      $.extend(this.self, conf);
      this.backend.call('init', conf.page).always((function(_this) {
        return function(data) {
          return _this.trigger('ready');
        };
      })(this)).done((function(_this) {
        return function(data) {
          console.log('triggering load', load, data);
          return _this.trigger('load', data.view);
        };
      })(this));
    }

    Tony.prototype.load = function(page, fn) {
      this.self.trigger('before:load', page);
      return this.self.one('load', fn);
    };

    return Tony;

  })();

}).call(this);
