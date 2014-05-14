define [
  "scripts/module"
], (pluginModule) ->
  beforeEach ->
    #Load our pluginModule module for each test
    module(pluginModule.name)

    # Provide any mocks needed
    module ($provide) ->
      # Make sure CoffeeScript doesn't return anything
      return null

  RunnerHelpers =
    loadModules: (moduleNames) ->
      beforeEach ->
        moduleNames = if _.isArray(moduleNames) then moduleNames else [moduleNames]
        # Load the directive's module
        for moduleName in moduleNames
          module moduleName

    createModuleTestCtx: (moduleNames, injectFeatures) ->
      #Setup module for each directive test
      @loadModules(moduleNames)

      return RunnerHelpers.createInjectCtx(injectFeatures)

    createControllerCtx: (controllerName, beforeControllerCreated) ->
      ctx = @createInjectCtx()
      beforeEach ->
        beforeControllerCreated(ctx) if beforeControllerCreated
        ctx.ctrl = ctx.$controller(controllerName, {$scope: ctx.$scope})

      return ctx

    createInjectCtx: (injectFeatures = []) ->
      # Inject in angular constructs otherwise,
      #  you would need to inject these into each test
      context = {}
      args = ["$rootScope", "$compile", "$controller"]
      injectFeatures = if _.isArray(injectFeatures) then injectFeatures else [injectFeatures]
      allInjects = _.reject(_.unique(args.concat injectFeatures), (item) -> !item)

      #For injection to work the arg names need to match so create a wrapper function
      func = eval("""
        f = function(#{allInjects.join(',')}) {
          #{ 'context[\'' + name + '\'] = ' + name for name in allInjects };
          context['$scope'] = $rootScope.$new()
        }
      """)

      beforeEach ->
        inject.apply context, [func]

      return context

    createDirective: (runtimeContext, data, template) ->
      # Setup scope state
      runtimeContext.$scope.data = data

      # Create directive
      elm = runtimeContext.$compile(template)(runtimeContext.$scope)

      # Trigger watchers
      runtimeContext.$scope.$apply()

      # Return
      return elm

  return RunnerHelpers
