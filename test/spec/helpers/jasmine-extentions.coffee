beforeEach ->
  @addMatchers
    toInheritFrom: (expected) ->
      if @actual
        item = @actual
        while(parent = item.constructor.__super__)
          if parent.constructor == expected
            return true
          else
            item = parent

      @message = ->
        [
          "Expected #{@actual.constructor.name} to inherit from #{expected.name}",
          "Expected #{@actual.constructor.name} not to inherit from #{expected.name}"
        ]

      return false

    toContainElement: (expectedChild) ->
      unless @actual instanceof $
        @message = ->
        [
          "Expect actual value to be an instanceof a JQuery object"
        ]
        return false

      @message = ->
        [
          "Expected child element to live inside parent",
          "Expected child element not to live inside parent"
        ]

      return @actual.find(expectedChild).length > 0


    ##############################################
    # OVERRIDE THE EXISTING toContain SO WE CAN CHECK OBJECTS "contain"
    ##############################################
    toContain: (expected) ->
      if typeof expected != "object"
        jasmine.Matchers.prototype.toContain.call(this, expected)
      else
        if @actual
          passed = true
          for name, value of expected
            if expected.hasOwnProperty(name) && !@actual.hasOwnProperty(name)
              passed = false
              break
            else if expected.hasOwnProperty(name) && @actual.hasOwnProperty(name)
              if expected[name] != @actual[name]
                passed = false
                break

        @message = ->
          [
            "Expected #{JSON.stringify(@actual)} to contain #{JSON.stringify(expected)}",
            "Expected #{JSON.stringify(@actual)} to not contain #{JSON.stringify(expected)}"
          ]

        return passed

    toHaveClass: (expectedClass) ->
      actual = if @actual instanceof $ then @actual else $(@actual)

      @message = ->
        [
          "Expected #{actual[0]} to have class #{expectedClass}",
          "Expected #{actual[0]} not to have class #{expectedClass}"
        ]
      
      return actual.hasClass and actual.hasClass(expectedClass)
      
    toHaveElementCount: (expected) ->
      unless @actual instanceof $
        @message = ->
        [
          "Expected actual to be a jQuery element"
        ]
        return false

      @message = ->
        [
          "Expected element count of selector #{@actual.selector} to equal #{expected} but was #{@actual.length}"
          "Expected element count of selector #{@actual.selector} not to equal #{expected}"
        ]

      return @actual.length == expected


