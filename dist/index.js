(function(glob) {
  var define, require, defineCache;

  if (glob.define) {
    define = glob.define;
    require = glob.require;
  } else {
    //Create a basic define and require statements to manage internal dependencies
    defineCache = {};
    require = function(deps, callback) {
      var args = [], i = 0;
      for (i=0; i < deps.length; i++) {
        args.push(defineCache[deps[i]]);
      }

      return callback.apply(this, args);
    };

    define = function(name, deps, callback) {
      if(!callback) {
        callback = deps
        deps = []
      }
      defineCache[name] = require.call(this, deps, callback);
    };
  }
(function() {
  define('scripts/module',[], function() {
    return angular.module("MyModuleName", []);
  });

}).call(this);

(function() {
  define('scripts/directives/my-example-directive',["scripts/module"], function(module) {
    return module.directive('myDir', function($timeout, $rootScope, $location) {
      return {
        restrict: 'A',
        require: 'ngModel',
        scope: true,
        link: function(scope, element, attrs) {
          return element.text('this is my directive');
        }
      };
    });
  });

}).call(this);

(function() {
  define('scripts/controllers/example-controller',["scripts/module"], function(module) {
    return module.controller("ExampleCtrl", [
      "$scope", "$http", function($scope, $http) {
        return $scope.doAction = function() {
          return console.log("Action Taken");
        };
      }
    ]);
  });

}).call(this);

(function() {
  require(["scripts/module", "scripts/directives/my-example-directive", "scripts/controllers/example-controller"], function() {});

}).call(this);

  
})(this);