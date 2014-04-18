define [
  "app"
  "runnerHelpers"
  "angularMocks"
  #TODO: Add your service path here
  "scripts/services/my-example-service"
], (app, RunnerHelpers) ->
  
  describe "My Example Service", ->
    #TODO: Inject your service by specifying it in the RunnerHelper
    ctx = RunnerHelpers.createInjectCtx("$myExampleService")

    it "should have the tryMyService feature", ->
      expect(ctx.$myExampleService).toBeDefined()
      expect(ctx.$myExampleService.tryMyService).toBeDefined()
      expect(ctx.$myExampleService.tryMyService()).toEqual "do something"


