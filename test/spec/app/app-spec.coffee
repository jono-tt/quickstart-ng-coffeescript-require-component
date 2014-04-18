define [
  "angular"
  "app"
], (angular, app) ->
  describe "App", ->
    initialStart = app.start

    beforeEach ->
      spyOn console, "warn"
      spyOn angular, "bootstrap"
      spyOn app.module, "config"
      app.start = initialStart

    it "should always have an App name", ->
      expect(app.name).toBeDefined()
      
    it "should only be allowed to start once", ->
      app.start()
      app.start()
      expect(app.module.config.callCount).toEqual 1
      expect(angular.bootstrap.callCount).toEqual 1
      expect(console.warn).toHaveBeenCalledWith "Application already started"

    it "should bootstrap angular", ->
      app.start()
      expect(angular.bootstrap).toHaveBeenCalledWith(document, [app.name])

    #TODO: This is where all route tests should be placed
    describe "Routes", ->
      routeProvider = null
      beforeEach ->
        routeProvider = jasmine.createSpyObj("routeProvider", ["when", "otherwise"])
        app.start()
        expect(app.module.config).toHaveBeenCalledWith ["$routeProvider", jasmine.any(Function)]
        #Call the configure function with the mocked RouteProvider
        app.module.config.calls[0].args[0][1](routeProvider)

      it "should setup Example route", ->
        expect(routeProvider.when).toHaveBeenCalledWith '/example', {
          templateUrl: 'partials/example.html',
          controller: 'ExampleCtrl'
        }

      it "should setup Otherwise route", ->
        expect(routeProvider.otherwise).toHaveBeenCalledWith redirectTo: '/example'
