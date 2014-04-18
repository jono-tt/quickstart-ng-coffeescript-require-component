define [
  "env"
  "app"
  "underscore"
], (env, app, _) ->

  app.module.factory "$environmentService", [()->
    get: (name) ->
      return env[name]
    allKeys: () ->
      return _.map env, (value, key) -> key
  ]