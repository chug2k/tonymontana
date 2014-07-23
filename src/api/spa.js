
// The ability to split your single-page application (SPA) into loosely-coupled modules

var instance;

top.tony = riot.observable(function(arg) {

  // tony() --> return instance
  if (!arg) return instance;

  // tony(fn) --> add a new module
  if ($.isFunction(arg)) {
    top.tony.on("ready", arg);

  // tony(conf) --> initialize the application
  } else {

    instance = new Tony(arg);

    instance.on("ready", function() {
      top.tony.trigger("ready", instance);
    });

  }

});

