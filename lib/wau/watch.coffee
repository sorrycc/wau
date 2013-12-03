##
# @fileOverview Watch 类.
##

node_watch    = require "node-watch"
child_process = require "child_process"
path          = require "path"
fs            = require "fs"

require("colorful").toxic()
Config = require "./config"


class Watch

  constructor: (@path, @type) ->
    @config = Config["project"][@type]
    @setupWatch()

  setupWatch: ->
    return if !@config
    @watchDir item for item in @config["watch"]

  watchDir: (dirpath) ->
    console.log "watching: " + "[#{@type}] #{dirpath}".green
    node_watch path.join(@path, dirpath), (filepath) => @upload filepath

  # [todo] - scp 支持用户名密码.
  # [todo] - 添加 ignore_regexes 支持.
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
      "#{@getHost()}:#{remotePath}"
    ].join " "

  getHost: ->
    Config["host"]


module.exports = Watch
