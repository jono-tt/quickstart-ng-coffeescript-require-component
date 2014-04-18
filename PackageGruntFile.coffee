coffee = require "coffee-script"

module.exports = (grunt) ->
  destFile = grunt.option("out-file") or "application"

  #Write the environment VARS to the JS file: Ensure in the root as requirejs compile will fail
  environment = require('./config/environment')
  environment.writeJavascriptEnvironmentConfig("./env.js")

  grunt.initConfig

    clean: 
      build: ["target"]

    coffee:
      compile:
        files: [
          expand: true
          cwd: "app/"
          src: ["**/*.coffee"]
          dest: "target/"
          ext: ".js"
        ]

    copy:
      main:
        files: [{
          expand: true
          src: ["**"]
          cwd: "public/"
          dest: "target/"
        }]

    replace:
      jsincludes:
        src: ['public/index.html']
        dest: 'target/index.html'
        replacements: [{
          from: /<!-- START: Script Includes: Replaced by Packager -->([\s\S]*?)<!-- END: Script Includes: Replaced by Packager -->/m
          to: '''
            <!--Injected By Packager-->
            <script type="text/javascript" src="application.min.js" /></script>
            <script type="text/javascript" src="env.js" /></script>
            <script type="text/javascript">
              require(["scripts/boot/boot-strapper"]);
            </script>'''
        }]

      #Change the define statement in the vars so that we can override it with the env.js in the root folder
      # each time the server is started.
      envVars:
        src: ['target/application*']
        overwrite: true
        replacements: [{
          from: /define\([\'\"]env[\'\"]/m
          to: 'define(\'env_old\''
        }]

    requirejs:
      production:
        options:
          optimize: "uglify2"
          mainConfigFile: "target/scripts/config.js"
          baseUrl: "target/"
          generateSourceMaps: true
          preserveLicenseComments: false
          include: ["../bower_components/requirejs/require.js", "scripts/boot/boot-strapper"]
          out: "target/" + destFile + ".min.js"

      develop:
        options:
          optimize: "none"
          mainConfigFile: "target/scripts/config.js"
          baseUrl: "target/"
          include: ["../bower_components/requirejs/require", "scripts/boot/boot-strapper"]
          out: "target/" + destFile + ".js"

    testem:
      jenkins:
        src: [ "test/**/*.coffee" ]
        report_file: "target/output.tap"
        options:
          src_files: [ "test/**/*.coffee" ]
          serve_files: [ "test/spec/**/*.coffee" ]
          test_page: "test/minify-spec-runner.mustache"
          launch_in_ci: [ "PhantomJS" ]
          fail_on_zero_tests: true
          reporter: "tap"

  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-testem"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-text-replace"

  grunt.registerTask "write-environment-vars", ->
    #Write the environment VARS to the JS file
    environment.writeJavascriptEnvironmentConfig("target/env.js")

  grunt.registerTask "default", ["clean:build", "coffee:compile", "requirejs", "testem:ci:jenkins", "copy:main", "replace", "write-environment-vars"]
