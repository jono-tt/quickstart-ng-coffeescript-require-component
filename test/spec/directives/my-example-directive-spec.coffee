define [
  "app"
  "runnerHelpers"
  "angularMocks"
  #TODO: Add your directive path here
  "scripts/directives/my-example-directive"
], (app, RunnerHelpers) ->
  
  describe "My Example Directive", ->
    #Create a runtime context the module
    ctx = RunnerHelpers.createInjectCtx()

    success_template = '<div my-dir ng-model="data"></div>'
    fail_template = '<div my-dir></div>'

    it 'should throw error when ngModel attribute not defined', ->
      invalidTemplate = ->
        dir = RunnerHelpers.createDirective ctx, null, fail_template

      expect(invalidTemplate).toThrow()

    it 'should render the expected output', ->
      element = RunnerHelpers.createDirective ctx, null, success_template
      expect(element.text()).toBe 'this is my directive'

