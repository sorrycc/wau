# Watch And Upload

监听目录并上传文件.

![demo](https://i.alipayobjects.com/e/201311/1b1dy1fTwD.png)

## 安装

```
$ npm install wau -g
```

## 使用

在项目目录下执行 `wau`，注意第一次执行的时候会在 `~/` 目录下生产 `.wau` 配置文件，添加 `host` 机器后即可使用.

```
$ wau
```

### 配置说明

```
{
  "host": "admin@1.1.1.1",
  "ignore_regexes": [
    "\\.swp$"
  ],
  "project": {
    "cashier": {
      "test": "./cashier-htdocs/",
      "remotePath": "/home/admin/build/",
      "watch": [
        "./cashier-htdocs/"
      ]
    }
  }
}
```

* host: 远程机器，需配置不用密码自动登陆
* ignore_regexes: 列在这里的文件不会被上传，通过正则的方式匹配
* project: 项目
  * test: 用来探测当前文件夹是否为该项目
  * remotePath: 对应的远程服务器目录
  * watch: 项目中需监听的文件夹

### 项目配置

在项目目录里可以增加一个 `.wau` 文件，里面的 host 优先级比 `~/.wau` 里的高。

```
{
  "host": "admin@1.1.1.1"
}
```

## FAQ

* 报 `EMFILE error` 怎么处理?

  执行下面命令并重启机器，详见：[https://github.com/joyent/node/issues/2479](https://github.com/joyent/node/issues/2479) 。

  ```
  echo 'kern.maxfiles=20480' | sudo tee -a /etc/sysctl.conf
  echo -e 'limit maxfiles 8192 20480\nlimit maxproc 1000 2000' | sudo tee -a /etc/launchd.conf
  echo 'ulimit -n 4096' | sudo tee -a /etc/profile 
  ```

* 配置文件在哪里? 

  ~/.wau


