
path = require "path"
fs = require "fs"

filePath = path.join(__dirname, "../config.json")
module.exports = JSON.parse fs.readFileSync filePath
