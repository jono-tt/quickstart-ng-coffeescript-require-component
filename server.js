var express = require('express');
var app = express();
var environment = require('./config/environment')

app.use(express.static(process.env.PWD + '/target'));

//Every startup must write the existing ENVIRONMENT vars to the env.js file
environment.writeJavascriptEnvironmentConfig("./target/env.js");

app.listen(process.env.PORT || 9294);
