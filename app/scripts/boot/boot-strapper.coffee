define [
  "jquery"
  "angular"
  "app"
  #TODO: All other services, controllers and directives
  "scripts/controllers/example-controller"
], ($, angular, app) ->
  startBootLoader = ->
    #Set loading classes
    $("html").addClass "#{app.name}-loading"

    try
      console.log "Bootstrapper: #{app.name} Start: Starting Application"

      app.start()

      $("html").addClass "#{app.name}-loaded"
      $("html").removeClass "#{app.name}-loading"

      console.log "Bootstrapper: #{app.name} Start: Success"
    catch e
      $("html").addClass "#{app.name}-load-error"
      $("html").removeClass "#{app.name}-loading"
      console.error "Bootstrapper: #{app.name} Start: Error", e


  #Only bootstrap if the bootstrapper is enabled
  if !$("html").hasClass "disable-bootstrap"
    startBootLoader()
  else
    return startBootLoader

    