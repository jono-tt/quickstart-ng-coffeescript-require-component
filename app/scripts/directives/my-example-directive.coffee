define [
  "scripts/module"
], (module) ->

  module.directive 'myDir', ($timeout, $rootScope, $location) ->
    restrict: 'A'
    require: 'ngModel'
    scope: true

    link: (scope, element, attrs) ->
      element.text 'this is my directive'

