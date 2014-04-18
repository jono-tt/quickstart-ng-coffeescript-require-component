require.config
  baseUrl: "http://#{document.location.hostname}:7358/app/"
  paths:
    "angularMocks": "../bower_components/angular-mocks/angular-mocks"
    "runnerHelpers": "../test/spec/helpers/runner-helpers"

  shim:
    "angularMocks":
      deps: [ "angular" ]
      exports: "angular.mock"

  deps: [ "scripts/config" ]

  callback: ->
    require ["underscore", "jquery"], (_, $) ->

      # REMOVE THE .js BECAUSE UNDERSCORE DOESNT USE THE BASE URL
      #  IF THE EXTENTION IS SPECIFIED
      tests = _.map window.tests, (item) ->
        return item.replace(".js", "")

      require tests, (->
        # Run tests once the SPEC files have been fetched
        jasmineEnv = jasmine.getEnv()
        jasmineEnv.addReporter(new jasmine.HtmlReporter)
        jasmineEnv.execute()
      ), ( (err)->
        #Stop tests on Script Load Failure
        jasmine.getEnv().currentRunner().finishCallback()
        console.error "Error loading scripts: #{err?.message}"
        console.error err
      )

