var fs   = require("fs");

Environment = {
  getEnvironmentConfig: function() {
    var filename = "./config/environment.env"
    var content = fs.readFileSync(filename, "utf8");
    var envHash = JSON.parse(content);

    for (key in envHash) {
      if (process.env[key]) {
        envHash[key] = process.env[key];
      }
    }

    return envHash;
  },

  /**
  This writes to the env.js file which can be used to get properties of the runtime environment.
  */
  writeJavascriptEnvironmentConfig: function(path) {
    var configContent = "define('env', [], function() { return " + JSON.stringify(this.getEnvironmentConfig()) + ";});\n";

    fs.writeFileSync(path, configContent, "utf8");
  }
};

module.exports = Environment;
