##
# @fileOverview Project 类.
##

node_watch    = require "node-watch"
child_process = require "child_process"
path          = require "path"
fs            = require "fs"

require("colorful").toxic()
Config = require "./config"


class Project

  constructor: (@path, @type) ->
    @config = Config["project"][@type]
    @host = @getHost()
    @setupWatch()

  readPeojctConfig: ->
    waurcPath = path.join @path, ".wau"
    ret = {}
    if fs.existsSync waurcPath
      ret = JSON.parse fs.readFileSync waurcPath
      console.log ret
    ret

  setupWatch: ->
    return if !@config
    @watchDir item for item in @config["watch"]

  watchDir: (dirpath) ->
    console.log "watching: " + "[#{@type}] #{dirpath}, [host] #{@host}".green
    node_watch path.join(@path, dirpath), (filepath) => @upload filepath

  upload: (filepath) ->
    if Config["ignore_regexes"]
      for item in Config["ignore_regexes"]
        re = new RegExp item
        return if filepath.match re

    command = @getCommand(filepath)
    console.log "  >> ".white + "[#{@type}] #{filepath.replace(@path, "")}".blue
    child_process.exec command, (e, stdout, stderr) ->
      console.log "  error: #{e}".red if e

  getCommand: (filepath) ->
    relativePath = filepath.replace(@path, "")
    remotePath = path.join @config["remotePath"], relativePath
    [
      "scp"
      filepath
      "#{@host}:#{remotePath}"
    ].join " "

  getHost: ->
    projectConfig = @readPeojctConfig()
    projectConfig && projectConfig["host"] || Config["host"]


module.exports = Project
