define [
], ->
  class BaseObject
    @new: (options) ->
      new @(options)

  return BaseObject
