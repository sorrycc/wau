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


