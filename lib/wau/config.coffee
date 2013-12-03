
path = require "path"
fs = require "fs-extra"

getConfig = ->
  destPath = path.join process.env.HOME, "./.wau"
  origPath = path.join(__dirname, "../config.json")
  fs.copySync origPath, destPath if !fs.existsSync destPath
  JSON.parse fs.readFileSync destPath

module.exports = getConfig()
