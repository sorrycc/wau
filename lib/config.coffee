
path = require "path"
fs = require "fs-extra"

destPath = path.join process.env.HOME, "./.wau"
origPath = path.join(__dirname, "../config.json")

fs.copySync origPath, destPath if !fs.existsSync destPath
module.exports = JSON.parse fs.readFileSync destPath
