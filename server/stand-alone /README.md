# 单机安装Redis

## 快速入门

定义这些变量:

1. DATA: redis的数据存储目录, 例如`/home/redis/data`
2. CONFIG: redis的配置文件`redis.conf`所在的目录, 例如`/home/redis/config`
3. PORT: 宿主机的端口, 即远程连接Redis时的端口, 为了安全性, 建议使用非常见端口, 默认是`31379`
4. CONTAINER_PORT: 容器的端口, 设置任意端口, 为了安全性, 建议使用非常见端口, 默认是`6379`

然后填充到下面的变量:

```shell
export DATA=""
export CONFIG=""
export PORT=""
export CONTAINER_PORT=""
```

最后执行:

```shell
chmod +x ./install.sh
./install.sh
```
