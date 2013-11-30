# Watch And Upload

* 突破系统对于同时 watch 文件数量限制的命令

```
echo 'kern.maxfiles=20480' | sudo tee -a /etc/sysctl.conf
echo -e 'limit maxfiles 8192 20480\nlimit maxproc 1000 2000' | sudo tee -a /etc/launchd.conf
echo 'ulimit -n 4096' | sudo tee -a /etc/profile 
```
