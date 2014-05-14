module.exports = (grunt) ->
  grunt.initConfig
    coffeelint:
      options:
        configFile: "coffeelint.json"

      all: ['Gruntfile.coffee', 'app/**/*.coffee', 'test/**/*.coffee']

    watch:
      coffee:
        files: ['Gruntfile.coffee', 'app/**/*.coffee', 'test/**/*.coffee']
        tasks: ['newer:coffeelint:all']

    coffee:
      options:
        sourceMap: true
        bare: true
        force: true
      dist:
        expand: true
        src: ['app/**/*.coffee', 'test/**/*.coffee']
        dest: '.tmp'
        ext: '.js'

    testem:
      develop:
        src: [ 'app/**/*.coffee', 'test/**/*.coffee' ]
        options:
          src_files: [ "app/**/*.coffee", "test/**/*.coffee" ]
          serve_files: [ "test/spec/**/*.coffee" ]
          test_page: "test/spec-runner.mustache"
          launch_in_dev: [ "Chrome", "PhantomJS" ]
          before_tests: "grunt newer:coffeelint:all"
          fail_on_zero_tests: true

      jenkins:
        src: [ 'app/**/*.coffee', 'test/**/*.coffee' ]
        report_file: "test/results/output.tap"
        options:
          src_files: [ "app/**/*.coffee", "test/**/*.coffee" ]
          serve_files: [ "test/spec/**/*.coffee" ]
          test_page: "test/spec-runner.mustache"
          launch_in_ci: [ "PhantomJS" ]
          fail_on_zero_tests: true
          reporter: "tap"

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-newer'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-testem'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  grunt.registerTask 'lint', ['coffeelint:all']
  grunt.registerTask 'test:ci', ['coffeelint:all', 'testem:ci:jenkins']
  grunt.registerTask 'test:develop', ['testem:run:develop']
  grunt.registerTask 'default', ['lint', 'testem:ci:develop']
