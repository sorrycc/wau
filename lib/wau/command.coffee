
path   = require "path"
fs     = require "fs"
Config = require "./config"
Project  = require "./project"


class Command

  constructor: ->
    @execute()

  ##
  # 执行命令行.

  execute: (argv) ->

    if !Config["host"]
      console.log "Please set host in ~/.wau first.".red
      return

    dir = process.cwd()
    return if @watch(dir) > 0

    for item in fs.readdirSync dir
      newPath = path.join dir, item
      @watch newPath if fs.lstatSync(newPath).isDirectory()

  ##
  # 测试目录是否为已知项目.

  test: (dir, type) ->
    testPath = path.join dir, Config["project"][type]["test"]
    fs.existsSync testPath

  ##
  # 尝试监听目录.

  watch: (dir) ->
    count = 0
    for k, v of Config["project"]
      if @test dir, k
        count++
        new Project dir, k
    count


module.exports = Command
