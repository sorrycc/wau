
path   = require "path"
fs     = require "fs"
CONFIG = require "./config"
Watch  = require "./watch"

test = (dir, type) ->
  testPath = path.join dir, CONFIG["project"][type]["test"]
  fs.existsSync testPath

watch = (dir) ->
  count = 0
  for k, v of CONFIG["project"]
    if test dir, k
      count++
      new Watch dir, k
  count

init = ->
  dir = process.cwd()
  return if watch(dir) > 0

  for item in fs.readdirSync dir
    newPath = path.join dir, item
    watch newPath if fs.lstatSync(newPath).isDirectory()

init()
