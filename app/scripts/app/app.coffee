#TODO: Setup all define statements for RequireJS
# These are configured in app/scripts/config.coffee
define [
  "angular"
  "ngRoute"
], (angular, ngRoute) ->
  #TODO: Configure the application Name
  appName = 'myApplication'

  #TODO: Set all dependencies of Angular
  allNgDependencies = [
    "ngRoute"
  ]
  
  module = angular.module appName, allNgDependencies

  app = {
    module: module
    name: appName
  }

  app.start = ->
    #Override start so that application can only be started once
    app.start = -> console.warn "Application already started"

    #TODO: Setup all routes needed for the application
    module.config ['$routeProvider', ($routeProvider) ->
      $routeProvider.when('/example', {
        templateUrl: 'partials/example.html',
        controller: 'ExampleCtrl'
      })

      $routeProvider.otherwise({
        redirectTo: '/example'
      })
    ]

    #Bootstrap application
    angular.bootstrap(document, [app.name])

  return app
