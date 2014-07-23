# This is to help separate everything into "loosely coupled modules".
# I've been told that's a good thing, but I'm skeptical of a clean, modular codebase.
# NOTE(Charles): The riot.js codebase has some stuff here to check is_node to make things
# work on both client and server, but I'm only ever going to run this client-side.

# Okay, Charles is going to write a little README here. I don't quite understand all of this yet,
# but basically you can overload the module name to do different things based on what type of argument you provide.
# You either bind a new module (which is a function, that will be invoked when 'ready' is triggeredm,
# or you want the singleton-esque instance (when you call just module()), or you want to start things, which
# is when you pass a configuration variable.

# The core app here is called "tony".

@instance = null # I don't know if I have to keep this global, but it seems safer to, non?

@tony = riot.observable (arg) ->
  # when called without argument, the API is returned.
  if !arg then return instance

  # function argument --> bind a new module
  if $.isFunction(arg)
    tony.on 'ready', arg
  else
    # configuration argument --> start the application.
    instance = new Tony(arg)
    instance.on 'ready', ->
      tony.trigger 'ready', instance
