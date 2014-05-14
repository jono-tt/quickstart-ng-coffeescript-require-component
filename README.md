Component Quick Start - Angular, Coffeescript and RequireJS
-------------------------------------------------

[![Build Status](https://travis-ci.org/jono-tt/quickstart-ng-coffeescript-require-component.svg?branch=master)](https://travis-ci.org/jono-tt/quickstart-ng-coffeescript-require-component)

Overview
--------
This is a template component to get you up and running with a solid implementation and structure of angularJS. The main point of this is to have RequireJS setup, allow you to write Coffeescript, run continuous testing in development mode with Testem and finally have an easy to use Packager that will package your component for deployment.

Requirements
------------

- NodeJS >= v0.10.25
- NPM >= v1.3.24

Installation
------------

Once the required software is installed (NodeJS, NPM) run the command:

- npm install
    - This will install all NPM required packages
    - After NPM, BOWER will automatically install all Web based packages
- Install Grunt CLI tools
    - npm install -g grunt
    - npm install -g grunt-cli

Software base
-------------

- [NPM](https://npmjs.org/)
    - Node Package Manage used to install required server side software (Packaging and Deployments)
- [Bower](https://github.com/bower/bower)
    - Web package manager used to manage Client Side dependencies (such as jQuery)
- [Grunt](http://gruntjs.com/)
    - Build scripts to manage test runner
    - Deployment Packager to minify and create single output files
- [RequireJS](http://requirejs.org/docs/api.html)
    - Used as Client Side dependency manager for all resource files
- [Testem Grunt](https://www.npmjs.org/package/grunt-contrib-testem)
    - Test runner used to run Jasmine Tests
- [Coffeelint](http://www.coffeelint.org/)
    - Used to ensure Coffee script standards are maintained


Project Packages and Classes Structure
--------------------------------------

Packages and Coffeescript files structure: 

- Component Code (app/scripts):

    - `controllers`: The application controllers
    - `directives`: namespace for all directives
    - `main.coffee`: contains all component internal dependencies
        - This is where we build the component from so place all high level internal dependencies that you want packaged with your component
        - directives, services and controllers must be added as described below

- Test Code (test/spec):

    - `controllers`: The application controllers
    - `directives`: namespace for all directives
    - `helpers`: any test helpers that are required

Development
-----------

Once you have got the dependencies added through npm and bower you can run the development environment by running the following command:

`grunt test:develop`

This command runs the `Testem` framework and does the following:

- Starts a basic WebServer
    - http://localhost:7357/xxxx/test/spec-runner.mustache
    - This feeds back test results to Testem
    - Testem watches all files and re-runs tests when any Coffeescript files change

- Starts a [Mincer](https://github.com/nodeca/mincer) WebServer (Pipeline asset Processor) 
    - http://localhost:7358/
    - Any coffeescript files requested from the server are compiled and returned as Javascript file
    - Map files are also served for easier debugging of Coffeescript

- For running the "ci" task `npm test` you will need [PhantomJS](http://phantomjs.org/)
    - If automatic npm install doenst work then manual installs:
        - for MacOS: brew install phantomjs
        - for windows: http://phantomjs.org/download.html

# Troubleshoot

- Unable to run the grunt task `grunt test:develop`
    - install grunt globally `npm install -g grunt`
- On startup you get LINT errors and then Webserver not running after fixing issue
    - stop the grunt command `ctrl-c`
    - rerun `grunt test:develop`
- If no tests are found running in CI mode `grunt test:ci` or `npm test`
    - Make sure PhantomJS is installed
    - Display valid browsers: `./node_modules/.bin/testem launchers`
- If you get the following similar errors:
    - Argument 'ExampleCtrl' is not aNaNunction, got undefined
        - Check that you have included the controller, service or directive in the RequireJS `define` statement within `app/scripts/boot/boot-strapper.coffee`


Developing (Services, Directives and Controllers)
-------------------------------------------------
Naming Conventions:

- Named with the convention of camelCase for directives:
    - myExampleDirective

- Named with the convention of PascalCase for controllers:
    - MyExampleController

- Named with the convention of $camelCase for services:
    - $myExampleService

- The reference to the resource must be added to the file app/scripts/main.coffee:
    - define [..., "scripts/services/my-example-service"]

- Each resource type should be in its own folder:
    - directives (app/scripts/directives)
    - services (app/scripts/services)
    - controllers (app/scripts/controllers)

- An example directive is in:
    - my-example-directive.coffee
    - my-example-directive-spec.coffee

- An example service is in:
    - my-example-service.coffee
    - my-example-service-spec.coffee

- An example controller is in:
    - example-controller.coffee
    - example-controller-spec.coffee


Testing and Code Quality
------------------------

All tests are linted and then run each time any relevant files change, under development this will warn/fail in the console for any errors that occur during reload process.

All development must be done in test driven way to ensure maximum code coverage.



Coding Conventions
------------------

While lint will try keep the code tidy and the compilation nature of Coffee script will ensure correct syntax, there are a few things that must be kept manually by developers of the project:

- File name conventions
    - All lowercase
    - Separate each word with a '-' (hyphen)
- Code Indentation
    - 2 spaces instead of tabs
    - LINT will fail with the use of TABS
    - Coffeescript requires strict convention of indentation
- Library Dependencies
    - Adding new dependencies must be discussed with the team before being added
    - Updating exiting dependencies must be discussed with the team before upgrading
- RequireJS
    - As we are using AMD for file dependency, it is important to use the "define" statement

Pull Requests
-------------

Once coding is complete for a feature or a hotfix and you would like this to be reviewed for merge to develop branch, the following steps must be taken:

1. Rebase feature branch
    - Ensure that your feature branch is up to date with its origin
    - git rebase develop
2. Open pull request
    - From the feature branch open a Pull Request as develop <- feature/your-new-feature
    - Ensure you have given a good description of what the pull request contains
    - Specify what the Final commit message should be in the comments eg.
        - Add feature Swinging Monkeys which allows monkeys to swing from trees through the use of banana peels
3. Get feedback
    - Make any nessesary changes from the feedback
4. Finialise Pull Request
    1. Once the pull request is ready to be accepted
        - rebase your feature branch (again)
        - squash your commits (into a single commit with the commit message from the Pull Request comments specified above)
        - [Info and Example](https://github.com/edx/edx-platform/wiki/How-to-Rebase-a-Pull-Request)
    2. Ask reviewer to complete pull request

Build Scripts / Deployment
--------------------------

For building a the component into a minified version, run the following command:

```
grunt --gruntfile PackageGruntFile.coffee
or
npm run-script package
```

This will generate 2 output files `dist/index.js` and `dist/index.min.js` for the Javascript and make the css all into one file at `dist/index.min.css`.

