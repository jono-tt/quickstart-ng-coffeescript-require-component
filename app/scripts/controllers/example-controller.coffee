define [
  "jquery"
  "app"
  "env"
], ($, app, env) ->

  app.module.controller "ExampleCtrl", ["$scope", "$http", ($scope, $http)->
    $scope.doAction = ->
      console.log "Action Taken"
      console.log "These are the current environment vars from (config/environment.env): ", env
  ]
