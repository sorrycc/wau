##
# @fileOverview Watch 类.
##

node_watch    = require "node-watch"
child_process = require "child_process"
path          = require "path"
fs            = require "fs"

require("colorful").toxic()
CONFIG = require "./config"


class Watch

  constructor: (@path, @type) ->
    @config = CONFIG["project"][@type]
    @setupWatch()

  setupWatch: ->
    return if !@config
    @watchDir item for item in @config["watch"]

  watchDir: (dirpath) ->
    console.log "watching: " + "[#{@type}] #{dirpath}".green
    node_watch path.join(@path, dirpath), (filepath) => @upload filepath

  upload: (filepath) ->
    command = @getCommand(filepath)
    console.log "  >> ".white + filepath.replace(@path, "").blue
    child_process.exec command, (e, stdout, stderr) ->
      console.log "  error: #{e}".red if e

  getCommand: (filepath) ->
    relativePath = filepath.replace(@path, "")
    remotePath = path.join @config["remotePath"], relativePath
    [
      "scp"
      filepath
      "#{@getHost()}:#{remotePath}"
    ].join " "

  getHost: ->
    CONFIG["host"]


module.exports = Watch
