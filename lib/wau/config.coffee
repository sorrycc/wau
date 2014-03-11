
path = require "path"
fs = require "fs-extra"

getConfig = ->
  destPath = path.join process.env.HOME, "./.wau"
  origPath = path.join(__dirname, "../../config.json")
  fs.copySync origPath, destPath if !fs.existsSync destPath

  content = fs.readFileSync destPath, "utf-8"
  content = content.split("\n").map (item) ->
    item = item.trim()
    if item.indexOf("//") == 0 then "" else item
  JSON.parse content.join("\n")

module.exports = getConfig()
