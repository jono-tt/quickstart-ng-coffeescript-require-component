define [
  "scripts/module"
], (module) ->

  module.controller "ExampleCtrl", ["$scope", "$http", ($scope, $http)->
    $scope.doAction = ->
      console.log "Action Taken"
  ]
