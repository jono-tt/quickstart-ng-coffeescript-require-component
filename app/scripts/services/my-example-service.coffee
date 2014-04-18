define [
  "jquery"
  "app"
], ($, app) ->

  app.module.factory "$myExampleService", [()->
    tryMyService: ->
      return "do something"
  ]