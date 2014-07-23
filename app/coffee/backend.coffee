class @Backend
  constructor: (conf) ->
    @cache = {}
    @storage = window.localStorage;

  call: (method, arg, fn) ->
    console.log '->', method
    promise = new Promise(fn)
    console.log 'promise', promise.done
    promise.done(fn)
    promise




