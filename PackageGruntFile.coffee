module.exports = (grunt) ->

  wrap = {
    start: """
      (function(glob) {
        var define, require, defineCache;

        if (glob.define) {
          define = glob.define;
          require = glob.require;
        } else {
          //Create a basic define and require statements to manage internal dependencies
          defineCache = {};
          require = function(deps, callback) {
            var args = [], i = 0;
            for (i=0; i < deps.length; i++) {
              args.push(defineCache[deps[i]]);
            }

            return callback.apply(this, args);
          };

          define = function(name, deps, callback) {
            if(!callback) {
              callback = deps
              deps = []
            }
            defineCache[name] = require.call(this, deps, callback);
          };
        }

      """
    end: """
        
      })(this);
    """
  }

  grunt.initConfig

    clean: 
      build: ["target", "dist"]

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
      dist:
        files: [{
          expand: true
          src: ["index.*"]
          cwd: "target/"
          dest: "dist/"
        }]

    cssmin:
      minify:
        src: ['app/css/main.css']
        dest: "dist/index.min.css"

    requirejs:
      dist:
        options:
          optimize: "uglify2"
          baseUrl: "target/"
          generateSourceMaps: false
          preserveLicenseComments: true
          name: "index"
          out: "target/index.min.js"
          skipModuleInsertion: true

      develop:
        options:
          optimize: "none"
          baseUrl: "target/"
          include: ["scripts/main"]
          out: "target/index.js"
          wrap: wrap
          skipModuleInsertion: true

    testem:
      jenkins:
        src: [ "test/**/*.coffee" ]
        report_file: "target/output.tap"
        options:
          src_files: [ "test/**/*.coffee" ]
          serve_files: [ "test/spec/**/*.coffee" ]
          test_page: "test/minified-spec-runner.mustache"
          launch_in_ci: [ "PhantomJS" ]
          fail_on_zero_tests: true
          reporter: "tap"

  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-testem"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-cssmin"

  grunt.registerTask "default", ["clean:build", "coffee:compile", "requirejs:develop", "requirejs:dist"
    , "testem:ci:jenkins", "copy:dist", "cssmin:minify"]
