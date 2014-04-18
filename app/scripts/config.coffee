require.config
  paths:
    jquery: "../bower_components/jquery/dist/jquery"
    domReady: "../bower_components/requirejs-domready/domReady"
    underscore: "../bower_components/underscore/underscore"
    store: "../bower_components/store-js/store"
    moment: "../bower_components/moment/min/moment-with-langs"
    jsonPath: "../libs/jsonpath-0.8.0"

    es5Shim: "../bower_components/es5-shim/es5-shim"
    consoleShim: "../bower_components/console-shim/console-shim"
    json3: "../bower_components/json3/lib/json3.min"
    promise: "../bower_components/es6-promise/promise.min"
    
    angular: "../bower_components/angular/angular"
    ngRoute: "../bower_components/angular-route/angular-route"
    
    baseObject: "scripts/helpers/base-object"
    app: "scripts/app/app"
    env: "../env"

  shim:
    angular:
      exports: "angular"
      deps: [ "jquery" ]

    ngRoute:
      exports: "angularRoute"
      deps: [ "angular" ]
      
    underscore:
      exports: "_"
    
    jsonPath:
      exports: "jsonPath"

    promise:
      exports: "Promise"

  deps: [
    "jquery", "angular", "consoleShim", "es5Shim", "consoleShim",
    "json3", "underscore", "baseObject", "promise", "env"
  ]
