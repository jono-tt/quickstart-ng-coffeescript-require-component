define [
  "jquery"
  "angular"
  "scripts/boot/boot-strapper"
  "app"
], ($, angular, bootStrapper, app) ->
  describe "Boot Strapper", ->
    beforeEach ->
      spyOn console, "log"
      spyOn console, "error"
      spyOn app, "start"

    it "should have correct classes added to the html element during boot", ->
      app.start.andCallFake ->
        expect($("html")).toHaveClass "#{app.name}-loading"
      
      bootStrapper()

      expect(app.start).toHaveBeenCalled()
      expect($("html")).not.toHaveClass "#{app.name}-loading"
      expect($("html")).toHaveClass "#{app.name}-loaded"

    it "should log successful start", ->
      bootStrapper()
      expect(console.log).toHaveBeenCalledWith "Bootstrapper: #{app.name} Start: Starting Application"
      expect(console.log).toHaveBeenCalledWith "Bootstrapper: #{app.name} Start: Success"

    it "should log failed start", ->
      app.start.andCallFake ->
        throw new Error("Dummy Start Error")
    
      bootStrapper()

      expect(console.log).toHaveBeenCalledWith "Bootstrapper: #{app.name} Start: Starting Application"
      expect(console.error).toHaveBeenCalledWith "Bootstrapper: #{app.name} Start: Error", jasmine.any(Object)
