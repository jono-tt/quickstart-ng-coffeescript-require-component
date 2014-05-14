define [
  "runnerHelpers"
  #TODO: Add your controller path here
  "scripts/controllers/example-controller"
], (RunnerHelpers) ->
  describe "Example Controller", ->
    ctx = RunnerHelpers.createControllerCtx 'ExampleCtrl', (ctx)->
      #TODO: You can change the current context before the controller
      # is invoked.
      ctx.$scope.hasSomePreFilledProperty = "i do"

    it "should have an action function", ->
      spyOn console, "log"
      expect(ctx.$scope.doAction).toBeDefined()
      ctx.$scope.doAction()
      expect(console.log).toHaveBeenCalledWith "Action Taken"

    it "should have prefilled properties on the scope", ->
      expect(ctx.$scope.hasSomePreFilledProperty).toEqual "i do"
