define [
  "app"
  "runnerHelpers"
  "angularMocks"
  "scripts/services/environment-service"
], (app, RunnerHelpers) ->
  
  describe "Environment Service", ->
    ctx = RunnerHelpers.createInjectCtx("$environmentService")

    it "should get env property", ->
      expect(ctx.$environmentService.get("BACKEND_SERVER")).toEqual "http://localhost:3000"

    it "should return all keys of the environment", ->
      expect(ctx.$environmentService.allKeys()).toEqual ["BACKEND_SERVER", "ENV"]

